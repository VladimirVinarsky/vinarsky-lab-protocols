# panels - image magick

make a 3x panel of all tiff images both in small and big format

```
#!/bin/bash

magick montage -label '%f' *.tif -tile 3x -geometry 256x256+1+1 small_vertical.jpg
# magick montage *.tif -tile x3 -geometry 256x256+1+1 small_horizontal.jpg

magick montage -label '%f' *.tif -tile 3x -geometry 1024x1024+4+4 full-size_vertical.jpg
 # magick montage *.tif -tile x2 -geometry 1024x1024+4+4 full-size_horizontal.jpg
```

{% code title="No labels" %}
```
#!/bin/bash

magick montage *.tif -tile 3x -geometry 256x256+1+1 small_vertical.jpg
# magick montage *.tif -tile x3 -geometry 256x256+1+1 small_horizontal.jpg

magick montage *.tif -tile 3x -geometry 1024x1024+4+4 full-size_vertical.jpg
 # magick montage *.tif -tile x2 -geometry 1024x1024+4+4 full-size_horizontal.jpg
```
{% endcode %}
