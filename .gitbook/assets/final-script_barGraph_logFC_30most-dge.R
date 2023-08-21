library(ggplot2)
library(tidyverse)
library(rstudioapi)

# set the working directory to the folder with the script
activeDcoumentContext <- rstudioapi::getActiveDocumentContext()
wd<-dirname(activeDcoumentContext$path)
setwd(wd)
getwd()

dir_to_be_processed<-choose.dir()

files<-list.files(dir_to_be_processed)

for(file in seq_along(files)){
#  print(files[file]) 
# }
# 
# quit()
# to grep the genes you want: "egrep -i '^itg|gene_symbol' RNAseqTable.csv > Integrins.csv"
file_name<-basename(files[file])
file_name_short_01<-word(file_name, 1,sep = fixed("."))
file_name_short<-str_remove(file_name_short_01,pattern = "filt_")
complete_table <- read_csv(paste0(dir_to_be_processed,"/",file_name))

complete_table_up_down <- complete_table %>% 
  dplyr::filter(adj.P.Val<0.05) %>% 
  mutate(log2FC = log2(exp(logFC))) %>% 
  dplyr::filter(abs(log2FC)>0.585) %>% 
  mutate(abs_value=(log2FC*log2FC)) %>%
  slice_max(abs_value,n=30) %>% 
  mutate(direction=ifelse(log2FC>0,"up","down"))

# graph with gene expression sorted from highest to lowest
complete_table_up_down %>% 
  ggplot(aes(x = reorder(gene_symbol, log2FC, decreasing = FALSE), y = log2FC)) +
  #geom_point(size = 3)+
  geom_point(size = 3, aes(colour = direction)) +
  scale_colour_brewer(palette = "Set1", limits = c("up", "down")) +
  #geom_col(aes(fill = DESCRIPTION), show.legend = FALSE) +
  geom_vline(xintercept = 0, lty=2) +
  geom_hline(yintercept = 0, lty=2) +
 # facet_grid(~DESCRIPTION, scales='free', space = "free_x") +
  ylim(min(complete_table_up_down$log2FC)-1,max(complete_table_up_down$log2FC)+1) +
  theme_bw() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    #panel.grid.major.x = element_line(colour = "grey60", linetype = "dashed"),
    axis.text.x = element_text(angle = 60, hjust = 1)
  )+
    ggtitle(file_name_short) +
      theme(text = element_text(size = 16, family = "Impact"))
ggsave(paste0(file_name_short,".jpg"))

}
