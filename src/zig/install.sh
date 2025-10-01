#!/bin/sh

set -ex

FEATURE_ID="zig"
VERSION="${VERSION:?}"
ZSF_PUBLIC_KEY="${ZSF_PUBLIC_KEY:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="zig-aarch64-linux-${VERSION}.tar.xz" ;;
    x86_64) file="zig-x86_64-linux-${VERSION}.tar.xz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://ziglang.org/download/community-mirrors.txt"
    mirror="$(shuf --head-count 1 ./community-mirrors.txt)"
    curl --location --remote-name "${mirror}/${file}"
    curl --location --remote-name "${mirror}/${file}.minisig"
    minisign -V -m "./${file}" -P "${ZSF_PUBLIC_KEY}" -x "./${file}.minisig"
}

# shellcheck disable=SC2016
build_callback() {
    mkdir -p "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --strip-components 1 --verbose
    printf '#!/bin/sh\nzig ar ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/ar"
    printf '#!/bin/sh\nzig c++ ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/c++"
    printf '#!/bin/sh\nzig cc ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/cc"
    printf '#!/bin/sh\nzig dlltool ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/dlltool"
    printf '#!/bin/sh\nzig lib ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/lib"
    printf '#!/bin/sh\nzig objcopy ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/objcopy"
    printf '#!/bin/sh\nzig ranlib ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/ranlib"
    printf '#!/bin/sh\nzig rc ${@}\n' | install -D -m755 "/dev/stdin" "./local/bin/rc"
}

stdlib_init "bsdtar" "curl" "minisign"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
