---
description: How to process sarcomere length images in standardized way
---

# Sarcomere Length

## Overview of the Scripts

#### `rmv_long file1 file2 [file..]`

{% file src="../.gitbook/assets/rmv_long" %}
Tool to remove redundant sequences in file names
{% endfile %}

#### `analysis_prepare folder [folder...]`

{% file src="../.gitbook/assets/analysis_prepare" %}
Script to create the analysis structure for analyzing
{% endfile %}

requires folders with ome-tiffs Experiment/image1..N.ome.tiff

#### `analysis_make_panels folder [folder...]`

{% file src="../.gitbook/assets/analysis_make_panels (1)" %}

requires Experiment/Condition\_1..N/image\_folder\_1..N structure

#### `analysis_make_cells_panels folder [folder...]`

{% file src="../.gitbook/assets/analysis_make_cells_panel" %}

requires Experiment/image\_folder\_1..N structure

#### Application to measure the distance of sarcomere peaks

Application link: [https://vinarsky.shinyapps.io/sarcomere/](https://vinarsky.shinyapps.io/sarcomere/)

## Detailed description

### 0. Remove redundant parts of the name

Use the `rmv_long` script to remove the redundant parts of the names of `ome.tiff` files (such as Maximum Intensity Projection etc.) before you start the analysis

### 1. Create the analysis structure

First, the ome.tiff images exported from czi format need to be created.

Use the `analysis_prepare` script applied to a folder (folders) which containg `ome.tiff` images we want to measure

The created analysis folder contains one `.csv` file for results of the measurements and one folder per each image containg following files:

1. one `ome.tiff` image which is used for measurments
2. four `.csv` files which is used to save the line graphs from measurments
3. four `.png` with dummy files to be used to save the measurments

The `.png` and `.csv` files are empty and serve to be used as a name for saving the screenshot of the region measured (`.png`) and the graph of intensity of the measurment (`.csv`)&#x20;

### 2. Analysis in FiJi

During the measurement in image J/FiJi it is recomendded just save the screenshots and csv files, and then count the number of the Z-discs using the online app.&#x20;

The resulting `.csv` file with results is supposed to replace the original `.csv` file created by the script

{% file src="../.gitbook/assets/sarcomere-app_manual.docx" %}

### 3. When the analysis is done - check it

Once the analysis is done the selection of sarcomeres should be checked and verified by another person and the faulty selection measurments need to be removed from the analysis csv.

&#x20;To do this we need to go through all the regions used for measurment and check them. Therefore the following scripts are used to make this more straightforward in following way:

1. Create panels of the whole image and the selections for checking
2. Check the quality of sarcomere selection
3. Rescale the intenstiy of individual cell images to be easily visible
4. Make panels out of these normalized images to give a quick overview of the images.

#### 1. Create panels of the regions of interest&#x20;

&#x20;Script `analysis_make_panels` is used to get images of whole cell and the regions into panels in and save them in `panels_<date-time>` folder. However there is a catch, that the script expects a folder structure as shown below:

* Experiment\_folder
  * Condition1\_folder
    * Image1\_folder
    * Image2\_folder
  * Condition2\_folder
    * Image1\_folder
    * Image2\_folder

In case the structure is missing the condition layer and looks like this:

* Experimet\_folder
  * Image1\_folder
  * Image2\_folder

The script would fail and it is necessary to recreate the structure by copying the experiment folder into another "helper" folder

* Helper\_folder
  * Experiment\_folder
    * Image1\_folder
    * Image2\_folder

Once this is done the script can be used

The output of this folder is `panels_<date-time>` folder which contains the panels for checking

{% file src="../.gitbook/assets/analysis_make_panels (1)" %}
Makes panels for checking
{% endfile %}

#### 2. Check the quality of selection

Open the results `.csv` file and the first panel of cell+regions of interest side by side in windows photo or somethng which enables drawing and go through the panels one by one. The ones which are not good are to be crossed out on the panel (and the modified image saved to replace the old panel) and the corresponding line in the results should be deleted.

Save the `.csv` file with `-DONE` at the end

#### 3&4 rescale intensity of normal images and make them into panels

To generate an overview of the cells the last script is applied to the Experiment folder of the following structure:

* Experimet\_folder
  * Image1\_folder
  * Image2\_folder

In case there are conditions, do them individually

### 4. Make it neat

Once the analysis and checking is done, its time to put it together with other results.

In order to avoid nesting try to keep it as flat as possible and put each condition separately at all levels

The structure is as follows:

* 01\_SOURCE\_IMAGES (minimal nesting to be able to grab a subset of images which you need for something else)
  * Exp01\_Condition01
  * Exp01\_Condition02
  * Exp02\_Condition01



* 02\_ANALYSIS (here the nesting doesnt make sense)
  * Exp01
    * Condition01
    * COndition02

03\_RESULTS

* 03\_Results
  * Exp01
    * Condition01
      * CELLS (normalized images of individual cells)
        * ROIS (panels of regions of interest used for checking)
        * multiple `.png` panels of normalized cells
    * Condition02
      * CELLS (normalized images of individual cells)
        * ROIS (panels of regions of interest used for checking)
        * multiple `.png` panels of normalized cells
    * multiple `exp_condition_results.csv` files of the checked measurements
    * `graphpad results`
    * `powerpoint results`

### 5. Integrate with all measurments

Add the measured values into the `ALL-MEASUREMENTS-TOGETHER.csv` and fill in the additional details about experiment



## Documentation in word format

#### Processing of files in imageJ

{% file src="../.gitbook/assets/sarcomere-manual.docx" %}

#### Using the application for counting Z-discs

{% file src="../.gitbook/assets/sarcomere-app_manual.docx" %}

## Useful links

[add-a-script-as-a-programme.md](../git-bash/add-a-script-as-a-programme.md "mention")

{% embed url="https://vinarsky.shinyapps.io/sarcomere/" %}

