# Adjust and convert tifs to jpgs

```
for file in *.tiff      ;  # for all tiffs in current directory
  do convert "${file}"  \  # can be also written as "$file"
    -level 0%,15%       \  # set black and white value of the histogram
    -type Grayscale     \  # turn image into grayscale
    "${file%.tiff}"_adjusted.jpg  ; # remove the tiff suffix and save as adjusted jpg
   done

```
