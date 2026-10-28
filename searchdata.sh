#!/bin/bash
# Student Number: S4228356  
# Student Full Name: Jed Ernest John Beard
#
# searchdata.sh - Searches for text inside a file and saves the
# matching lines into pattern.txt

# Ask the user for the name of the file to search
read -p "Enter the name of the file: " file

# Check the file exists before asking for the search text
if [ -f "$file" ]; then
    read -p "Enter the text to search for: " text

    # Case-insensitive search; matching lines are saved into pattern.txt
    grep -i "$text" "$file" > pattern.txt

    echo "Matching data saved to pattern.txt:"
    cat pattern.txt
else
    echo "File not found"
fi
