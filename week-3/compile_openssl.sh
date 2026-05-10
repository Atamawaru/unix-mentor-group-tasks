#!/bin/bash

if [[ $(id -u) != 0 ]]; then
    echo "Error. Run $0 as root instead."
fi

openssl_dir="$HOME/opt/openssl"
openssl_source_repo=""
if ! [[ -d $openssl_dir ]]; then
    echo "$openssl_dir does not exist. Creating it."
    mkdir -p "$openssl_dir"
fi

echo "Upgrading package manager..."
apt update && apt upgrade -y
install_packages=""

echo -n "Checking git... "
if [[ $(git --version > /dev/null 2>&1; echo $?) != 0 ]]; then
    echo "no"
    install_packages=$install_packages"git "
else
    echo "yes"
fi

echo -n "Checking gcc... "
if [[ $(gcc -v > /dev/null 2>&1; echo $?) != 0 ]]; then
    echo "no"
    install_packages=$install_packages"gcc "
else
    echo "yes"
fi

echo -n "Checking make... "
if [[ $(make -v > /dev/null 2>&1; echo $?) != 0 ]]; then
    echo "no"
    install_packages=$install_packages"make "
else
    echo "yes"
fi

if [[ $install_packages != "" ]]; then
    echo "Packages to install: $install_packages"
    apt install "$install_packages" -y
else
    echo "No packages to install. Continueing."
fi

echo "Installing OpenSSL source code..."
git clone 
