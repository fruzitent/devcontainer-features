#!/bin/sh

set -ex

FEATURE_ID="taplo"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    taplo --version

    taplo completions "bash" | install -D "/dev/stdin" "/usr/share/bash-completion/completions/taplo"
    taplo completions "fish" | install -D "/dev/stdin" "/usr/share/fish/vendor_completions.d/taplo.fish"
    taplo completions "zsh" | install -D "/dev/stdin" "/usr/local/share/zsh/site-functions/_taplo"
}

stdlib_install "install_callback"
