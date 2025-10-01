#!/bin/sh

set -ex

FEATURE_ID="zig"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    zig version
    # TODO: https://github.com/ziglang/shell-completions
}

stdlib_install "install_callback"
