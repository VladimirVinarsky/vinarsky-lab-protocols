# Reorganize daily images

## Info

1. Script takes images from chronologically (dd-mm-yyyy) named folders(`03-12-2023` ,`04-12-2023`... ) located in parent folder.
2. Groups them by CellLine ID as beginning of the filename (filename: `#0001_rest-of-filename.tif` , CellLine ID: `0001` )
3. Saves them in `Reorganized` folder into "CellLine ID named" folders (`CellLine_#0001`, `CellLine_#0002` ... ).
4. Renames files in "CellLine ID named" folders for better chronological sorting (`CellLine_#0001/2023-12-03_rest-of-filename.tif`) format for better sorting

## Notes

* CellLine ID must be separated from the rest of the file by underscore `_`&#x20;
* &#x20;`#` in the CellLine ID can be ommited&#x20;
* accepts unequal padding of CellLine ID (`#1` is  equal to`#0001`)
* accepts both dd-mm-yyyy and dd-mm-yy
* accepts names with a space inside `#003_this spaced name`

{% file src="../.gitbook/assets/reorg_daily_images.sh" %}
script to download
{% endfile %}

```
#!/bin/bash
shopt -s extglob globstar
ext="(jpg|JPG|jpeg|JPEG|png|PNG|tif|TIF|tiff|TIFF)"

date_parser(){
dd_mm_yyyy=$1
day="${dd_mm_yyyy%%-*}"
month_year="${dd_mm_yyyy#*-}"
month="${month_year%-*}"
year="${month_year#*-}"

if [[ ${#year} -eq 2 ]]
then
	year="20${year}"
fi

yyyy_mm_dd="${year}-${month}-${day}"
echo "${yyyy_mm_dd}"
}

if [[ $# -ne 1 ]]
then
echo ""	
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                      >  $0  <                  "
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Usage: $0 <parent-folder>                  "
echo "Supply path to <parent-folder> which contains multiple <sub-folders>."
echo ""
echo "Each <sub-folder> contains images taken in one day."
echo "Example <sub-folder>: 03-12-2023."
echo ""
echo "The image names start with CellLine ID: #0001 - #9999 which is followed by details (objective,comment etc)."
echo "Example image: #0003_sparse_good-morpholgy_10x.tif"
echo ""
echo "The script will bring together images of each CellLine ID and sort them from newest to oldest"
echo "Reorganized images will appear in 'Reorganized' folder"
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                          >  Let's go  <                             "
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
exit 1
fi

working_folder=$(dirname "$1")

reorg="${working_folder}/Reorganized"
mkdir "$reorg"

for file in ${1}/*/*.@${ext}
do
date_folder="$(dirname "${file}")"
date_folder="${date_folder##*/}"
new_date_folder="$(date_parser "${date_folder}")"

filename="$(basename "${file}")"
cell_id="${filename%%[_.]*}"
cell_id="${cell_id/#\#/}"
cell_id="$(printf "%.4d" "${cell_id}")"
cell_id="CellLine_#${cell_id}"
details="${filename#*[_.]}"

if [[ ! -d "${reorg}/${cell_id}" ]]
then
	mkdir "${reorg}/${cell_id}"
fi

pre_destination="${reorg}/${cell_id}/${new_date_folder}_${details}"
destination="${pre_destination/%_${ext}/.${ext}}"

cp "${file}" "${destination}"

echo "${file} done"

done
```
