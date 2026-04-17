#!/bin/bash

set -eou pipefail

argument=""
if [ "$1" != "" ]; then
    argument=$1
    if ! [ -d "$argument" ]; then
        echo "Error. Not a directory." >&2
        exit 1
    fi
fi
print_int_error() {
    echo "Rename aborted on line $LINENO" >&2
}
trap print_int_error ERR
argument="${argument%/}"
date_to_append=$(date +%Y%m%d)
for file in "$argument"/*; do
    old_file_name="${file##*/}"
    if [[ -f "$file" && "$old_file_name" = *.txt ]]; then
        if ! [[ "$old_file_name" =~ [0-9]{8} ]]; then
            new_file_name="${date_to_append}_${old_file_name}"
            new_file_name="${argument%/}/${new_file_name}"
            mv "$file" "$new_file_name"
        fi
    fi
done
