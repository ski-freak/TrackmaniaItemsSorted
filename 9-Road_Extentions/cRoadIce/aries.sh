#!/bin/bash

# Function to replace spaces in filenames
replace_spaces() {
    for file in "$1"/*; do
        # Check if the file or directory exists
        [ -e "$file" ] || continue

        # Recursively process directories
        if [ -d "$file" ]; then
            replace_spaces "$file"
        fi

        # Get the directory and base name of the file
        dir=$(dirname "$file")
        base=$(basename "$file")

        # Replace spaces with underscores in the base name
        new_base=$(echo "$base" | tr ' ' '_')

        # Rename the file if the name has changed
        if [ "$base" != "$new_base" ]; then
            mv -v "$file" "$dir/$new_base"
        fi
    done
}

# Start the recursive replacement from the current directory
replace_spaces .
