1. File inspector - inspect.sh
Write a script that accepts a filename as $1. If no argument is given, default to . (current directory).

File: print its name (use parameter expansion to strip the path), size (du -h), and line count (wc -l)
Directory: print how many files it contains
Neither: (not a regular file, but for example a block device, char device) print an error to stderr and exit with code 1
2. Safe renamer - rename.sh
Rename all .txt files in a given directory by prepending today's date as YYYYMMDD_.

Add set -euo pipefail at the top
Add a trap that prints "Rename aborted on line $LINENO" to stderr on early exit
Skip files already prefixed with a date - check if the filename starts with 8 digits
3. Backup - copy.sh
Copy files matching a glob pattern from a source directory to a destination directory. Takes two required positional arguments: <source_dir> and <dest_dir> - call usage() if either is missing.

Parse all flags with a while/case loop - no getopts:

Flag	Description
-p / --pattern <glob>	file pattern to match (default: *.log)
-v / --verbose	print each filename as it is copied
-h / --help	show usage and exit
Create <dest_dir> if it doesn't exist. Skip gracefully if the glob matches nothing. Print total files copied at the end.

4. Process checker - check.sh
Accept one or more process names as positional arguments, e.g. ./check.sh nginx postgres redis.

For each process: check if it's running with pgrep and append a result to a REPORT array. Print the full report at the end.

Include a proper argument parser with:

Flag	Description
--help	show usage and exit
-q / --quiet	suppress per-process output, only print the final report
