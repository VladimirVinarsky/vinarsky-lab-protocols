# join

## Joining by first column

```
join file1 file2
```

* joining works by default by first column
* the files need to be sorted in the same direction

## Joining by a different column&#x20;

* in case you want to join by different column use following:

```
join -1 1 -2 3 file1 file2
```

joins by the first column of file1 and third column of file2

## Joining when files have delimiter

```
join -1 1 -2 3 -t , file1.csv file2.csv
```

## &#x20;Specifying the output



```
join -1 2 -2 3 -o 1.1,1.2,1.3,2.2,2.1 file1.csv file2.csv
```

