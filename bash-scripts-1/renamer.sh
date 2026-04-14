#!/bin/bash env

set -eou pipefail

argument=""
if [ "$1" != "" ]; then
	argument=$1
	if ! [ -d "$argument" ]; then
		echo "Error. Not a directory." >&2
		exit 1
	fi
fi
argument="${argument%/}"
echo "$argument"
for file in "$argument"/*; do
	file="${file##*/}"
	if [[ -f "$file" && "$file" = *.txt ]]; then
		echo "$file this shit is a txt file"
	fi
done
