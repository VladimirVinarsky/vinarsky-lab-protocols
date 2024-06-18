library(tidyverse)
library(rstudioapi)
library(lubridate)

# set the working directory etc (run it twice as it throws error on the first run usually)
for (i in c(1:2)){
working_directory<-rstudioapi::getActiveDocumentContext()
setwd(dirname(working_directory$path))
getwd()
}

filters<-(choose.files(caption = "Select gene ontologies or custom gene sets"))
data_to_be_filtered<-choose.files(multi=FALSE, caption = "Select the gene expression table")

# Create the output folder with date and time
# Get the current date and time
current_datetime <- Sys.time()
# Format the date and time according to the desired format
formatted_datetime <- format(current_datetime, format = "%b-%d_%Hh-%Mm-%Ss")
# Create the folder name with "output" prefix and formatted date-time
output_folder<- paste0("output_", formatted_datetime)
# Create the output folder
dir.create(output_folder)
# Print the folder name

# data_source_strings<-str_trim( toupper( read_lines("data-source.txt" ) ) )

data_source_strings<-read_csv(data_to_be_filtered)

for (file in seq_along(filters) ) {
  
filter_name<-str_remove(basename(filters[[file]]), "\\.[a-zA-Z0-9]*")
# load the files into strings, change to upper case and trim the whitespace from both ends
data_filter<-str_trim( toupper( read_lines( filters[file] ) ) )
data_filter<-gsub("[,;\\t\"]", "", data_filter) # remove possible quotation marks commas, semicolons and tabs

# make a dummy tibble
# data_source_numbers<-seq(1:length(data_source_strings))
data_source<-tibble(data_source_strings) %>% 
  mutate(gene_symbol=toupper(gene_symbol))

# Now I need to prepare the strings which contain the regular expressin understood by grep
# define the start and endanchors
# start_anchor<-"^"
# end_anchor<-"$"

#put the anchores at the start and end of each vector item
# # filter_anchored_start<-paste0(start_anchor,data_filter)
# # filter_anchored_end<-paste0(data_filter,end_anchor)
# 
# #collapse the filter vectors into filter strings - the individual vector components are separated with "|" which is logical OR 
# filter_exact_match_collapsed<-paste(data_filter, collapse ="|")
# filter_anchored_start_collapsed<-paste(filter_anchored_start , collapse ="|")
# filter_anchored_end_collapsed<-paste0(filter_anchored_end,collapse ="|")

# Filtering part
# Keep only such rows of the data_source tibble where there are matches with filter strings:
# 1. get the exact match (here we cannot use the regular expressions defined above but %in% operator)
match_exact<-data_source %>% 
  dplyr::filter(data_source_strings$gene_symbol %in% data_filter)
# 2. get the anywhere match 
# match_anywhere<-data_source %>% 
  # dplyr::filter(grepl(filter_exact_match_collapsed,data_source_strings$gene_symbol, ignore.case = TRUE))
# 3. get the match at the start
# match_start<-data_source %>% 
  # dplyr::filter(grepl(filter_anchored_start_collapsed,data_source_strings$gene_symbol, ignore.case = TRUE))
# 4. get the match at the end
# match_end<-data_source %>% 
  # dplyr::filter(grepl(filter_anchored_end_collapsed,data_source_strings$gene_symbol, ignore.case = TRUE))


# Prepare for output to be able to extract the different matches
# matches<-list(exact = match_exact, 
#               anywhere = match_anywhere, 
#               start = match_start,
#               end = match_end 
#               )

# Print out the individual matches
# walk(names(matches), ~ {
#   cat("Name:", .x, "\n")
#   print(matches[[.x]])
#   cat("\n")
# })
# Print out the individual matches
# walk(names(matches), ~ write_csv(matches[[.x]], paste0(output_folder,"/",filter_name,"_",.x, ".csv")))
write_csv(match_exact, paste0(output_folder,"/",filter_name,".csv"))
}


