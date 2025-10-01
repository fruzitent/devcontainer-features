#!/bin/sh

set -ex

FEATURE_ID="bash-language-server"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    true
}

build_callback() {
    npm install --save-exact --save-dev "bash-language-server@${VERSION}"
}

stdlib_init "npm"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
