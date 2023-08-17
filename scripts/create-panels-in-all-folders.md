# Create panels in all folders

```
for folder in * ; # the * takes everything in the current directory
do 
  cd "${folder}" ;  # get into the folder "" are required in case the name contains spaces
  magick montage -label '%f' \   # label each image by its name
                   *.jpg \       # use all jpg images   
                  -tile 3x3 \    # make a 3x3 layout (if more images present will start another)
                  -geometry 300x300+2+2 \ # set size and boundary of each image in pixels
                  panel_"${folder}".jpg;  # name the panel according to the folder storing the images
  cd .. ; # go to parent folder to continue
done

# the ";" at the end of line is not necessary, unless you want to write it on a single line
# the "\" is there for better formatting otherwise all the parameters need to be on one line


```
