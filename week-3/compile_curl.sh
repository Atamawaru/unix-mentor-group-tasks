#!/bin/bash

if [[ $(id -u) != 0 ]]; then
    echo "Error. Run $0 as root instead."
    exit 1
fi

user_home_dir=$(eval echo "~$SUDO_USER")
curl_install_dir=$user_home_dir/opt/curl
find_openssl_dir=$user_home_dir/opt/openssl
curl_source_tarball="https://github.com/curl/curl/releases/download/curl-8_20_0/curl-8.20.0.tar.gz"
if ! [[ -d $curl_install_dir ]]; then
    echo "Curl install directory not found. Creating it..."
    mkdir -p "$curl_install_dir"
fi

if ! [[ -d $find_openssl_dir ]]; then
    echo "Error. Couldnt not find openssl directory."
    exit 1
fi

wget $curl_source_tarball

curl_build_tar_name=${curl_source_tarball##*/}
tar -xf "$curl_build_tar_name"
curl_build_dir_name=$(tar --list -f "$curl_build_tar_name" | head -1)
rm "$curl_build_tar_name"
cd "$curl_build_dir_name" || eval "$( echo "CD to build dir failed"; exit 1)" && ./configure LDFLAGS="-Wl,-rpath,$find_openssl_dir/lib64" --prefix="$curl_install_dir" --with-openssl="$find_openssl_dir" --without-libpsl
cd .. || eval "$(echo "CD to git repo failed"; exit 1)"
make -C ./"$curl_build_dir_name" -j"$(nproc)"
make -C ./"$curl_build_dir_name" test
make -C ./"$curl_build_dir_name" install
rm -rf "$curl_build_dir_name"
echo "Installed curl to $curl_install_dir"
"$curl_install_dir"/bin/curl --version
