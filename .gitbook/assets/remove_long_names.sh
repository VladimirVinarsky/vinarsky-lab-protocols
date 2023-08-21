#!/bin/bash

# This script helps to remove redundant (not unique) parts of filenames
# Written by Vladimir Vinarsky
# 18-08-2023
# Licence: GPL2 and higher


## Initial help ##
# when no arguments are supplied
if [ $# -lt 1 ]
	then
	echo ""
	echo "Please supply files as arguments"
	echo ""
	echo "# INFO # "
	echo "The script "$0" removes the longest shared (redundant) part of filenames supplied to the script"
	echo "After finding the common sequence you can choose if you want to remove it from the filenames"
	echo "You can decide if you want to keep a copy of files with the old filenames"
	echo "The script accepts globbing ('*' and such)"
	echo "NOTE: Works only on files in the current directory"
	echo "NOTE: When using globbing make sure not to include the script filename"
	echo ""
	echo "# USAGE #"
	echo "$0 FILE1 FILE2..."
	echo "Longest shared sequence is: ... "
	echo "Do you want to remove this sequence from the filenames? [y/n]"
	echo "Do you want to keep the old files? [y/n]"
	echo "Script $0 is done."
	echo ""
	exit 0
fi

## Longest common string search ## 
declare -a strings=("$@")
# Get the first string to use as a reference
reference="${strings[0]}"
# Strip the extension from the reference to excluded it from the search 
reference="${reference%.*}"

# Initialize the longest sequence variable
longest_sequence=""
# Run the comparisons loop to get the longest share sequence
for ((i=0; i<${#reference}; i++)); do
    for ((j=i+1; j<=${#reference}; j++)); do
        sequence="${reference:$i:$((j-i))}"

        # Check if the sequence is shared among all strings
        shared=true
        for string in "${strings[@]:1}"; do
            if [[ "$string" != *"$sequence"* ]]; then
                shared=false
                break
            fi
        done

        # Update the longest sequence if applicable
        if [ "$shared" = true ] && [ "${#sequence}" -gt "${#longest_sequence}" ]; then
            longest_sequence="$sequence"
        fi
    done
done

# Check if the common string is non-zero length if it is zero-length exit 
if ! [ -n "${longest_sequence}" ]
	then
	echo ""
	echo "There is no shared sequence among the filenames"
	echo ""
	exit 0
else         
	echo "Longest shared sequence is : ${longest_sequence}"
	read -p "Do you want to remove this sequence from the filenames? [y/n]: " remove
	if [ $remove = "y" ]
		then
		read -p "Do you want to keep the old files? [y/n]: " keep
		if [ $keep = "y" ]
	  		then
			echo "Creating copies.."
			for file in "${strings[@]}"
	  			do 
				cp "${file}" "${file/"${longest_sequence}"/}"
	  		done
  		else
			echo "Not creating copies..." 
			for file in "${strings[@]}"
	  			do
				mv "${file}" "${file/"${longest_sequence}"/}"
	  		done
        	fi
	else 
		echo ""	
		echo "Not changing anything"
		echo "Script $0 is done"
		exit 0
	fi
fi

echo ""
echo "Script $0 is done"
echo ""

