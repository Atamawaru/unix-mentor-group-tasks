#!/bin/bash

if [[ $(id -u) != 0 ]]; then
    echo "Error. Run $0 as root instead."
fi

user_home_dir=$(eval echo "~$SUDO_USER")
openssl_dir=$user_home_dir/opt/openssl
openssl_source_repo="https://github.com/openssl/openssl.git"
openssl_source_branch="openssl-4.0"

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
git clone -b $openssl_source_branch --single-branch --depth=1 "$openssl_source_repo"
echo "Compiling OpenSSL source code"
cd ./openssl || return 1; ./config -Wl,-rpath,"$openssl_dir/lib64" --prefix="$openssl_dir" --openssldir="$openssl_dir"
cd ..
make -C ./openssl -j"$(nproc)"
make -C ./openssl test
make -C ./openssl install
echo "Openssl installed in $openssl_dir"
echo "Making second version of lib folder, incase curl cant find it..."
mkdir -p "$openssl_dir"/lib
cp -r "$openssl_dir"/lib64/* "$openssl_dir"/lib
"$openssl_dir"/bin/openssl version
rm -rf openssl
