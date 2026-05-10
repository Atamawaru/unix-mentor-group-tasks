#!/usr/bin/bash
argument=""
if [ "$1" != "" ]; then
    argument=$1
else
    argument="."
fi

if [ -f "$argument" ]; then
    echo "File name: ${argument##*/}"
    echo "File size: $(du -h "$argument" | sed s:"$argument"::)"
    echo "Line count: $(wc -l "$argument" | sed s:"$argument"::)"

elif [ -d "$argument" ]; then
    echo "Number of files in directory: $(find "$argument" -type f | wc -l)"
else
    echo "Error. Neither a regular file or directory." >&2
    exit 1
fi
