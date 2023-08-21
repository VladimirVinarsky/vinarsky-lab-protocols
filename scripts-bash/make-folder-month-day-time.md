# Make folder month-day-time

When generating `output` folder from the script I like to add date and time to avoid overwriting data when I run the script later

```
folder=$(date +%b-%d_%Hh%Mm%Ss) # creates the date 
mkdir output_"${folder}" # appends the date and time to the folder name
```
