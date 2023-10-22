#!/bin/bash
if [[ $# -eq 0 ]]
then
echo "
usage: $0 mm/dd/yy 1L
Insert date in mm/dd/yy format (10/1/23) and integer (3) 
Script will shift the date by the integer and display it in yyyy-mm-dd format (2023-10-04)
"
exit 1
fi

start_date="$1"
echo "Submitted date: $start_date"
shift_days="$2"
echo "Days to shift the date forward: $shift_days"
reformatted_start_date=$(date -d $start_date +%Y-%m-%d)
echo "Reformatted submitted date: $reformatted_start_date"
shifted_date=$(date '+%Y-%m-%d' -d "$reformatted_start_date+$shift_days days")
echo "Date shifted forward by ${shift_days} days: $shifted_date"
