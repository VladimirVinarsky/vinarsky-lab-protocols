---
description: >-
  Make reproducible horizontal and vertical panels by combining ZEN and image
  magick utility.
---

# Panels with outlines

## ZEN

Following steps in ZEN software will lead to export of tif format single channel images and merge images. Both with and without graphical elements.

### Adjust display colours

1. Adjust the display settings on the images
2. Save the settings to be applied to each image as my\_beautiful-image\_display-settings.cz
3. Save the image as my-beautiful-image\_adjusted.czi

### Delineate the outlines

1. Use the spline tool from graphic to delineate the outline of the cell and the nucleus
2. right click when your drawing is finished
3. right click to adjust the thickness to 3, colour to white
4. in graphics pane unclick the "M" chckebox to maike the measurments disappear
5. add the 20um scalebar change colour to white, solid, 2.5 thickness, calibri, 40pt size&#x20;
6. save the outlines as my-beautiful-image\_outline.czi

### Export images with and without outlines

1. Export the images with outlines as tifs into folder called my-beautiful-image\_with-outlines
2. Remove the outlines (but not scalebar) from the graphics pane and export into my-beautiful-image\_no-outline

## File manager

Following steps will reorganize the images so that only the relevant images will be used for the panels.

1. Copy all exported images into a new folder called panel\_source&#x20;
2. Focus on following images from each condition:
   * image with a protein of interest and outline
   * merge image without the outline
3. Rename these images in the panel\_source folder in a following way:
   * control condition with protein of interest starts with 1
   * control condition with merge starts with 2
   * treated condition with protein of interest starts with 3
   * treated condition with merge starts with 4
4. Copy renamed images into a folder called panel\_images
5. The step No3 can be done repeatable by creating a simple rename-script placed in the panel\_source folder. This will enable quickly redoing the panels from newly adjusted images

### Run rename-script&#x20;

```bash
bash rename-script
```

### rename-script

```bash
cp old-name_protein-of-interest_control.tif   ../panel_images/1.tif
cp old-name_merge_control.tif                 ../panel_images/2.tif
cp old-name_protein-of-interest_treatment.tif ../panel_images/3.tif
cp old-name_merge_treatment.tif               ../panel_images/4.tif
```

## Create panels

After running panel-script in panel\_images folder, following panels will be created:

1. Horizontal layout in two sizes (512x512pxs and 2048x2048pxs)
2. Vertical layout  in two sizes (512x512pxs and 2048x2048pxs)

### Run panel-script

```bash
bash panel-script
```

### panel-script for 2x2 panels

```
  magick montage {1..4}*.tif -tile 2x2 -geometry 256x256+1+1 small_horizontal.jpg
  magick montage {1,3,2,4}*.tif -tile 2x2 -geometry 256x256+1+1 small_vertical.jpg
    
  magick montage {1..4}*.tif -tile 2x2 -geometry 1024x1024+4+4 full-size_horizontal.jpg
  magick montage {1,3,2,4}*.tif -tile 2x2 -geometry 1024x1024+4+4 full-size_vertical.jpg
```

### panel script for 1x2 panels

```
#!/bin/bash
magick montage *.tif -tile 1x -geometry 256x256+1+1 small_vertical.jpg
magick montage *.tif -tile x1 -geometry 256x256+1+1 small_horizontal.jpg


magick montage *.tif -tile 1x -geometry 1024x1024+4+4 full-size_vertical.jpg
magick montage *.tif -tile x1 -geometry 1024x1024+4+4 full-size_horizontal.jpg

```

### panel-script for 2x4 panels

```
magick montage {1..8}*.tif -tile 4x2 -geometry 256x256+1+1 small_horizontal.jpg
magick montage {1,5,2,6,3,7,4,8}*.tif -tile 2x4 -geometry 256x256+1+1 small_vertical.jpg
    
magick montage {1..8}*.tif -tile 4x2 -geometry 1024x1024+4+4 full-size_horizontal.jpg
magick montage {1,5,2,6,3,7,4,8}*.tif -tile 2x2 -geometry 1024x1024+4+4 full-size_vertical.jpg
```

