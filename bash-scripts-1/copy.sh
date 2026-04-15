#!/bin/bash

usage() {
    cat <<'EOF'
-p / --pattern <glob>	file pattern to match (default: *.log)
-v / --verbose	       	print each filename as it is copied
-h / --help             show usage and exit
EOF
}

if [[ $# -eq 0 ]]; then
    usage
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
        usage
        exit 0
        ;;
    ?)
        echo "Error. Unknown command."
        exit 1
        ;;
    esac
done
