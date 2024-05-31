---
description: command line tool to manipulate excel and csv files
---

# csvkit

## Resources

[link to tutorial page](https://csvkit.readthedocs.io/en/latest/index.html) and documentation really awesome, read this first



## Installation for gitbash

```
pip install csvkit
```

This run without problems but installed in a different path

So I just copied the files into `/usr/bin/`

The scripts got installed here:

```
C:\Users\vld\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts
```

To get to the hidden AppData folder pres `WindowButton + R` and then type `%AppData%`

## Adjust csv data and insert into a text document

### Insert a table

Insert a table from "stacked.csv" into document in vim:\
`.r ! csvlook stacked.csv`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data1-test.csv | 1      | 2   | 20  |
| data1-test.csv | 2      | 13  | 34  |
| data2-test.csv | 1      | 3   | 205 |
| data2-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |
| data3-test.csv | 2      | 13  | 34  |
| data3-test.csv | 3      | 13  | 34  |
| data3-test.csv | 4      | 13  | 34  |

### Insert only selected columns of table

To insert only "group" and "peakNo" columns.

`.r ! csvcut -c group,peakNo | csvlook`

| group          | peakNo |
| -------------- | ------ |
| data1-test.csv | 1      |
| data1-test.csv | 2      |
| data2-test.csv | 1      |
| data2-test.csv | 2      |
| data2-test.csv | 3      |
| data2-test.csv | 4      |
| data3-test.csv | 2      |
| data3-test.csv | 3      |
| data3-test.csv | 4      |

### Insert table sorted by one or multiple columns

To insert a table sorted by two columns (max and peakNo):\
`.r ! csvsort -c max,peakNo stacked.csv | csvlook`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data1-test.csv | 1      | 2   | 20  |
| data1-test.csv | 2      | 13  | 34  |
| data2-test.csv | 2      | 13  | 34  |
| data3-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data3-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |
| data3-test.csv | 4      | 13  | 34  |
| data2-test.csv | 1      | 3   | 205 |

\-r flag: revert the sorting to descending

## Tutorial

### Getting example data&#x20;

```
// Some code 
mkdir csvkit_tutorial
cd csvkit_tutorial
curl -L -O https://raw.githubusercontent.com/wireservice/csvkit/master/examples/realdata/ne_1033_data.xlsx
```

### in2csv the excel killer

_transform to csv and show in terminal_\
`in2csv ne_1033_data.xlsx`

_transform to csv and save as data.csv_\
`in2csv ne_1033_data.xlsx > data.csv`

### csvlook: dataperiscope

_to get the rough idea of the data use csvlook_\
`csvlook data.csv`

_to get it paged, separated in columns and able to navigate through, use less_\
`csvlook data.csv | less -S`

### csvcut: datascalpel

_to select and reorder columns_

to display the numbers and names of the columns use -n flag\*\
`csvcut -n data.csv`

### Insert table filtered by word in given column

To select only rows containing "data2" use -m flag:\
`.r ! csvgrep -c group -m data2 stacked.csv | csvlook`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data2-test.csv | 1      | 3   | 205 |
| data2-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |

\-i flag: to revert from select matching to return not matching

### Insert table filtered by regular expression in given column

To filter rows which in group column contain "ta2" or "ta3" use -r flag:\
`.r ! csvgrep -c group -r "ta2|ta3" stacked.csv | csvlook`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data2-test.csv | 1      | 3   | 205 |
| data2-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |
| data3-test.csv | 2      | 13  | 34  |
| data3-test.csv | 3      | 13  | 34  |
| data3-test.csv | 4      | 13  | 34  |

\-i flag: to revert from select matching to return not matching

### Filter table rows by matching list contained in a file

#### Cell in csv is matched exactly by line

To filter by file "filter-file" which contains 2 lines: data3-test.csv and data1-test.csv.\\

**Print the lines containing what is in the file**\\

`.r ! csvgrep -c group -f filter-file stacked.csv | csvlook`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data1-test.csv | 1      | 2   | 20  |
| data1-test.csv | 2      | 13  | 34  |
| data3-test.csv | 2      | 13  | 34  |
| data3-test.csv | 3      | 13  | 34  |
| data3-test.csv | 4      | 13  | 34  |

**print lines not containing what is in the file**\
`.r ! csvgrep -c group -if filter-file stacked.csv | csvlook`

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data2-test.csv | 1      | 3   | 205 |
| data2-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |

#### Cell in csv contains string found in file

To filter by file which contains two lines: data3 and data1\
`.r ! cat stacked.csv | grep -Fvwf filter-file | csvlook`

grep flags:\
\-f: take from file\
\-F: as fixed strings\
\-W: only lines with whole words matches\
\-v: select non matching lines (filtering)\\

| group          | peakNo | min | max |
| -------------- | ------ | --- | --- |
| data2-test.csv | 1      | 3   | 205 |
| data2-test.csv | 2      | 13  | 34  |
| data2-test.csv | 3      | 13  | 34  |
| data2-test.csv | 4      | 13  | 34  |

### Stack first lines of csvs together - csvstack approach

1. stack the csvs --filename flag creates a column with filenames\
   `csvstack --filenames data*t.csv > stacked.csv`
2. select the (number of peaks) you want to keep\
   `csvgrep -c peakNo -r "^[1-2]$" stacked.csv > filtered.csv`

Or this is an alternative\
`csvgrep -c peakNo -r "^1|2$" stacked.csv > filtered.csv`

3. Look at the data\
   `csvlook filtered.csv`
4. Do a summary statistics\
   `csvstat filtered.csv`

## Getting tables into markdown files



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
