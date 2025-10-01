#!/bin/sh

set -ex

FEATURE_ID="rust"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    rustup --version

    rustup completions "bash" | install -D "/dev/stdin" "/usr/share/bash-completion/completions/rustup"
    rustup completions "fish" | install -D "/dev/stdin" "/usr/share/fish/vendor_completions.d/rustup.fish"
    rustup completions "zsh" | install -D "/dev/stdin" "/usr/local/share/zsh/site-functions/_rustup"

    rustup completions "bash" "cargo" | install -D "/dev/stdin" "/usr/share/bash-completion/completions/cargo"
    rustup completions "fish" "cargo" | install -D "/dev/stdin" "/usr/share/fish/vendor_completions.d/cargo.fish"
    rustup completions "zsh" "cargo" | install -D "/dev/stdin" "/usr/local/share/zsh/site-functions/_cargo"
}

stdlib_install "install_callback"
