#!/usr/bin/bash

is_verbose=0
pattern="*.log"
source_dir=""
target_dir=""
usage() {
	cat <<'EOF'
Usage: ./copy.sh (OPTIONS) <source_dir> <target_dir>

Flags:
        -p / --pattern <glob>	file pattern to match (default: *.log)
        -v / --verbose	       	print each filename as it is copied
        -h / --help             show usage and exit
EOF
}
non_flag_args=()
non_flag_count=0
if [[ $# -eq 0 ]]; then
	usage
	exit 1
fi

while [[ $# -gt 0 ]]; do
	case $1 in
	-p | --pattern)
		if [[ -z $2 || "${2:0:1}" == "-" ]]; then
			echo "Error. -p/--patern requires an argument."
			exit 1
		fi
		pattern=$2
		shift 2
		;;
	-v | --verbose)
		is_verbose=1
		shift 1
		;;
	-h | --help)
		usage
		exit 0
		;;
	-* | --*)
		echo "Error. Unknown $1 command."
		exit 1
		;;
	*)
		non_flag_args[non_flag_count]=$1
		((non_flag_count++))
		shift 1
		;;
	esac
done
if [[ $non_flag_count -gt 2 ]]; then
	echo "Error. Too many non-flag arguments."
	exit 1
fi

source_dir=${non_flag_args[0]}
target_dir=${non_flag_args[1]}

if [[ -z $source_dir || -z $target_dir ]]; then
	echo "Error. One of directory argument empty."
fi
