---
description: command line tool to manipulate excel and csv files
---

# csvkit

## Getting example data&#x20;

```
// Some code 
mkdir csvkit_tutorial
cd csvkit_tutorial
curl -L -O https://raw.githubusercontent.com/wireservice/csvkit/master/examples/realdata/ne_1033_data.xlsx
```

## in2csv the excel killer

_transform to csv and show in terminal_\
`in2csv ne_1033_data.xlsx`

_transform to csv and save as data.csv_\
`in2csv ne_1033_data.xlsx > data.csv`

## csvlook: dataperiscope

_to get the rough idea of the data use csvlook_\
`csvlook data.csv`

_to get it paged, separated in columns and able to navigate through, use less_\
`csvlook data.csv | less -S`

## csvcut: datascalpel

_to select and reorder columns_

to display the numbers and names of the columns use -n flag\*\
`csvcut -n data.csv`

## Installation for gitbash

1. `pip --version` check if the pip is installed&#x20;
2. `pip install csvkit` try to install
3. in case the output contains "Warning ... is not in the path", add the folder to the path following way:
   1. `PATH_BACKUP=$PATH` create a copy of path just in case&#x20;
   2. the path is formatted in windows style `C:\something\something` and needs to be reformatted into linux style
   3. copy the path of the folder indicated in the folder in text file&#x20;
   4. first replace the '\\' with '/'&#x20;
   5. second change 'C:' into '/c/'&#x20;
   6. in the terminal add the changed string into the PATH using `PATH=$PATH:<your string>`
   7. `echo $PATH` to see if it is there&#x20;
4. &#x20;run `csvkit --version` to see if it is installed
