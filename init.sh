#!/bin/bash

set -e

if ! type "wget" &>/dev/null; then
    echo "[ERROR] wget: not found in your PATH" >&2
    exit 1
fi

version="${V:-1.8}"
os="$(uname | tr '[A-Z]' '[a-z]')"

# Validation
case "$os" in
    "linux" | "darwin")
        ;;
    *)
        echo "[ERROR] $os: invalid os type" >&2
        exit 1
        ;;
esac

url="https://storage.googleapis.com/golang/go${version}.${os}-amd64.tar.gz"
dest="$HOME/bin"
tmp="/tmp/go$version/$$"

mkdir -p "$tmp"
cd "$tmp"

wget "$url"
tar zxvf "go${version}.${os}-amd64.tar.gz"

mkdir -p "$dest"
install -m 755 go/bin/go "$dest"

sleep 0.5
eval "$dest/go version"
printf "\033[33m[INFO] go $version: successfully installed to $dest\033[m\n"
