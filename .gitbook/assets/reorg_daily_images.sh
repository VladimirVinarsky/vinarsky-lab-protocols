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
echo "Example <sub-folder>: 11-10-2023."
echo ""
echo "The image names start with CellLineId: #0001 - #9999 which is followed by details (objective,comment etc)."
echo "Example image: #0003_sparse_good-morpholgy_10x.tif"
echo ""
echo "The script will bring together images of each CellLineId and sort them from newest to oldest"
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
