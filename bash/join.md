# join

## Joining by first column

```
# by default the files are joined by the first column
join file1 file2
```

* joining works by default by first column
* the files need to be sorted in the same direction

## Joining by a different column&#x20;

* in case you want to join by different column use following:

```
join -1 1 -2 3 file1 file2
```

joins by the first column of file1 and third column of file3

## Joining when files have delimiter

&#x20;

