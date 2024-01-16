# Sarcomere Length

## How to use scripts to create the analysis folders and files and then panels

{% file src="../.gitbook/assets/how-to-use-scripts.docx" %}

## Scripts to be copied in /usr/bin/ to be usable

### Create the analysis structure

First, the ome.tiff images exported from czi format need to be created so that it can be done more efficiently this is done using the `analysis_prepare` script applied to a folder (folders) which containg `ome.tiff` images we want to measure

The created analysis folder contains one `.csv` file for results of the measurements and one folder per each image containg following files:

1. one `ome.tiff` image which is used for measurments
2. four `.csv` files which is used to save the line graphs from measurments
3. four `.png` with dummy files to be used to save the measurments

The `.png` and `.csv` files are empty and serve to be used as a name for saving the screenshot of the region measured (`.png`) and the graph of intensity of the measurment (`.csv`)&#x20;

{% file src="../.gitbook/assets/analysis_prepare" %}
Script to create the analysis structure for analyzing
{% endfile %}

&#x20;During the measurement in image J/FiJi it is recomendded just save the screenshots and csv files, and then count the number of the Z-discs using the online app.&#x20;

The resulting `.csv` file with results is supposed to replace the original `.csv` file created by the script

### When the analysis is done

Once the analysis is done the selection of sarcomeres should be checked and verified by another person and the faulty selection measurments need to be removed from the analysis csv.

&#x20;To do this we need to go through all the regions used for measurment and check them. Therefore the following scripts are used to make this more straightforward in following way:

1. create panels of the whole image and the selections for checking and gather them in one folder
2. Rescale the intenstiy of individual cell images to be easily visible
3. Make panels out of these normalized images to give a quick overview of the images.

#### 1. Create panels of the regions of interest

FIrst: only images are extracted from the folders (while keeping the structure) the new folder is called `images_<date-time>`

{% file src="../.gitbook/assets/analysis_copy_images" %}
Gather all images from the analysis in one folder
{% endfile %}

Second: images of whole cell and the regions of interest are made into panels for checking out of the images in `images_<date-time>` folder. However there is a catch, that the script expects a folder structure as:

* Experiment\_folder
  * Condition1\_folder
    * Image1\_folder
    * Image2\_folder
  * Condition2\_folder
    * Image1\_folder
    * Image2\_folder

In case the structure is like this:

* Experimet\_folder
  * Image1\_folder
  * Image2\_folder

It is necessary to recreate the structure by copying the experiment folder into another "helper" folder

* Helper\_folder
  * Experiment\_folder
    * Image1\_folder
    * Image2\_folder

Once this is done the script can be used

The output of this folder is `panels_<date-time>` folder which contains the panels for checking

{% file src="../.gitbook/assets/analysis_make_panels (1)" %}
needs Experiment/condition/imag-folders structure
{% endfile %}

{% file src="../.gitbook/assets/rmv_long" %}

{% file src="../.gitbook/assets/analysis_make_nine_cell_panel" %}

## Processing of files in imageJ

{% file src="../.gitbook/assets/sarcomere-manual.docx" %}



## Application to measure the distance of sarcomere peaks

Application link: [https://vinarsky.shinyapps.io/sarcomere/](https://vinarsky.shinyapps.io/sarcomere/)

{% file src="../.gitbook/assets/sarcomere-app_manual.docx" %}
