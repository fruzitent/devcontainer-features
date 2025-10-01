#!/bin/sh

set -ex

FEATURE_ID="dockerfmt"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    dockerfmt version

    dockerfmt completion "bash" | install -D "/dev/stdin" "/usr/share/bash-completion/completions/dockerfmt"
    dockerfmt completion "fish" | install -D "/dev/stdin" "/usr/share/fish/vendor_completions.d/dockerfmt.fish"
    dockerfmt completion "zsh" | install -D "/dev/stdin" "/usr/local/share/zsh/site-functions/_dockerfmt"
}

stdlib_install "install_callback"
