#!/bin/bash


curl_dir="$HOME/opt/curl"

echo "Checking libraries of curl binary..."
ldd "$curl_dir"/bin/curl

echo "Testing curl with MIF website link..."
"$curl_dir"/bin/curl --head https://mif.vu.lt/lt3
