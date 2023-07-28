#!/bin/bash

# check if all required arguments are provided
if [ $# -lt 3 ]; then
  echo "Usage: $0 [destination_folder] [file_to_check] [text_to_search]"
  exit 1
fi

# configuration
destination_directory="$1" # Destination folder
checking_file="$2"         # File to check
searched_text="$3"         # Text to look for

# option configuration
timeout=1 # how often to check the file in seconds

if [ $# -eq 4 ]; then
    timeout=$4
fi

# initialization a variable for searching
search=""

echo "$(date): Check is running. Waiting..."

# while it's not empty
while [ "$search" = "" ]; do
  # reassign the variable
  search=$(grep "$searched_text" "$checking_file")

  sleep "$timeout"
done

# if a directory doesn't exist then create it
if [ ! -d "$destination_directory" ]; then
  mkdir "$destination_directory"
  echo "Created the directory $destination_directory"
fi

# copy the file to the destination
cp "$checking_file" "$destination_directory"

echo "$(date): It's done! Your file is in $destination_directory/$checking_file"
