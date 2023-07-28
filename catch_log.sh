#!/bin/bash

# check if all required arguments are provided
if [ $# -lt 3 ]; then
  echo "DESCRIPTION
  catch_log.sh is a simple bash script to check files for certain text on timeout and then save the log with a timestamp.
Use case:
  You have a permanently changing log (or you only wait for the log's created) and you have to wait for the appearance of certain text (a message of mistakes). After encountering errors, the log may be deleted due to certain reasons (software actions), and you won't be able to read it.

USING
  launch:
    ./catch_log.sh [destination_folder] [file_to_check] [text_to_search] [timeout]
  where:
    [destination_folder] - the directory in which you want to save a log
    [file_to_check] - the file which you check
    [text_to_search] - what you look for in the file
    optional: [timeout] - by default, the file polling timeout is 1 time per a second

  Keep in mind: the script waits for the file to appear, so, if you point to a nonexistent file then it wouldn't be a mistake (a feature, not a bug)

Example:
  ./catch_log.sh ./backup system.log \"system error\" 0.001
explanation:
  In the current directory, the script will check the \"system.log\" file for system errors every 1 millisecond. When they are found, catch_log.sh will create a directory \"backup\" (if it hasn't already existed) and will copy \"system.log\" to \"backup/2022-09-30_14-30-59_system.log\""
  exit 1
fi

# configuration
destination_directory="$1" # Destination folder
checking_file="$2"         # File to check
searched_text="$3"         # Text to look for
timeout=1                  # option: how often to check the file in seconds
destination_file="$destination_directory/$(date +%Y-%m-%d_%H-%M-%S)_$checking_file" # path to the destination file

# if the timeout is set manually
if [ $# -eq 4 ]; then
  timeout=$4
fi

echo "$(date): Check is running. Waiting..."

# initialization a variable for searching
search=""
# while it's not empty
while [ "$search" = "" ]; do
  # reassign the variable.
  search=$(grep "$searched_text" "$checking_file" 2>/dev/null)

  sleep "$timeout"
done

# if a directory doesn't exist then create it
if [ ! -d "$destination_directory" ]; then
  mkdir "$destination_directory"
  echo "Created the directory $destination_directory"
fi

# copy the file to the destination
cp "$checking_file" "$destination_file"

echo "$(date): It's done! Your file is in $destination_file"
