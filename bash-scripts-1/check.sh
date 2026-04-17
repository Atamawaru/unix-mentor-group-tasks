#!/usr/bin/bash

usage() {
	cat <<'EOF'
Usage: ./check.sh (OPTIONS) <processes>

Flags:
        -q / --quiet          suppress per-process output, only print final report.
        -h / --help             show usage and exit
EOF
}
non_flag_args=()
non_flag_count=0
is_quiet=0
if [[ $# -eq 0 ]]; then
	usage
	exit 1
fi
while [[ "$#" -gt 0 ]]; do
	case "$1" in
	-q | --quiet)
		is_quiet=1
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
		if [[ "${1:0:1}" != "*" ]]; then
			non_flag_args[non_flag_count]=$1
			((non_flag_count++))
			shift 1
		fi
		;;
	esac
done
REPORT=()
report_count=0
for process in "${non_flag_args[@]}"; do
	output=$(echo -n $(pgrep "$process"))
	if [[ "$output" != "" && $is_quiet = 0 ]]; then
		echo "$output"
		REPORT[report_count]="$output $process"
		((report_count++))
	elif [[ "$output" != "" && $is_quiet = 1 ]]; then
		REPORT[report_count]="$output $process"
		((report_count++))
	fi
done
echo "STATUS REPORT: "
echo "${REPORT[*]}"
