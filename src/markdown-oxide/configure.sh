#!/bin/sh

set -ex

FEATURE_ID="markdown-oxide"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    markdown-oxide --version
}

stdlib_install "install_callback"
