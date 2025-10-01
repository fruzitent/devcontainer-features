#!/bin/sh

set -ex

FEATURE_ID="common-utils"

if [ "$(id --user)" -ne 0 ]; then
    >&2 echo "Script must be run as root. Use sudo, su, or add 'USER root' to your Dockerfile before running this script"
    exit 1
fi

rm --force "/etc/apt/apt.conf.d/docker-clean"
echo "Binary::apt::APT::Keep-Downloaded-Packages \"true\";" | install -D "/dev/stdin" "/etc/apt/apt.conf.d/keep-cache"

apt-get -y update
apt-get -y install --no-install-recommends \
    "ca-certificates" \
    "curl" \
    "gpgv" \
    "jq" \
    "libarchive-tools" \
    ;
