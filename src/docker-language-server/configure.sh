#!/bin/sh

set -ex

FEATURE_ID="docker-language-server"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    docker-language-server --version

    docker-language-server completion "bash" | install -D "/dev/stdin" "/usr/share/bash-completion/completions/docker-language-server"
    docker-language-server completion "fish" | install -D "/dev/stdin" "/usr/share/fish/vendor_completions.d/docker-language-server.fish"
    docker-language-server completion "zsh" | install -D "/dev/stdin" "/usr/local/share/zsh/site-functions/_docker-language-server"
}

stdlib_install "install_callback"
