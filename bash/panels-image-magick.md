# panels - image magick

## SotaTool

make a 2x1 panel for sotaTool

```
magick montage -label '%f' *.tif -tile 2x1 -geometry 480x480+2+2 panel.jpg
```

make 3x3 panel from these sub-panels

```
magick montage panel* -tile 3x3 -geometry 720x360+2+2 big_panel.jpg
```

## big and small panels&#x20;

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
