## Description
`catch_log.sh` is a simple bash script to check files for certain text on timeout and then save the log with a timestamp.

### Use case:
You have a permanently changing log (or you only wait for the log's created) and you have to wait for the appearance of certain text (a message of mistakes). After encountering errors, the log may be deleted due to certain reasons (software actions), and you won't be able to read it.

## Using
launch:
```bash
./catch_log.sh [destination_folder] [file_to_check] [text_to_search] [timeout]
```
where:
`[destination_folder]` - the directory in which you want to save a log
`[file_to_check]` - the file which you check
`[text_to_search]` - what you look for in the file
optional: `[timeout]` - by default, the file polling timeout is 1 time per a second

Keep in mind: the script waits for the file to appear, so, if you point to a nonexistent file then it wouldn't be a mistake (a feature, not a bug)

Example:
```bash
./catch_log.sh ./backup system.log "system error" 0.001
```
explanation:
In the current directory, the script will check the `system.log` file for system errors every 1 millisecond. When they are found, `catch_log.sh` will create a directory `backup` (if it hasn't already existed) and will copy `system.log` to `backup/2022-09-30_14-30-59_system.log`

## The history of this script
Once my friend told me about one problem: on a certain server the software was falling down and the logs were deleted in a few minutes. So, he had to wait until it will occur to be on time to save the log file.