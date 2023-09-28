#!/bin/bash

date_parser(){

dd_mm_yyyy=$1
day="${dd_mm_yyyy%%-*}"
day=$(printf "%.2d" ${day})
month_year="${dd_mm_yyyy#*-}"
month="${month_year%-*}"
month=$(printf "%.2d" ${month})
year="${month_year#*-}"
if [[ ${#year} -eq 2 ]]
then
	year="20${year}"
fi
yyyy_mm_dd="${year}-${month}-${day}"
echo "${yyyy_mm_dd}"

}

echo "input: $1"

new_var=$(date_parser $1)

echo "output: ${new_var}"
