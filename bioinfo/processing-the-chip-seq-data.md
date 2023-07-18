# Processing the ChIP-seq data



```
# transform a comma inside a chipseq file (usually where there is an intron)
sed 's/, /: /g' data_ChIP-seq\ day\ 10.csv > data_ChIP-seq_d-10_fixed.csv 
```

