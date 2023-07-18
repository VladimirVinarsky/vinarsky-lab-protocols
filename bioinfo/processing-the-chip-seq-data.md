# Processing the ChIP-seq data



```
# transform a comma inside a chipseq file (usually where there is an intron)
sed 's/, /: /g' data_ChIP-seq\ day\ 10.csv > data_ChIP-seq_d-10_fixed.csv 
```



```
# Aim: filter a fixed chipseq file by text file with names of genes

# 05. transform a comma inside a chipseq file  into a column

# 10. put comma in the beginning and end of the term

# 20. filter the chipseq file the comma-fixed file

# 25. Select the intron/region and gene column

# 26. Export it into a table

# 28. Select the gene field

# 30. Do counting of the genes and output it to 

# 40. Do a join of the rnaseq data with the chipseq count data into a new column


```



```
# Do it from a different side
# Join the rna-seq with the summary from the chipseq add a column of hits

# do this for each of the characteristics TSS, 



```

```
# count the numbers of the bindings for each gene
```



```
# create a table with the locus specification and name of the gene
```
