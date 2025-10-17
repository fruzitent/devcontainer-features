#!/bin/sh

set -ex

FEATURE_ID="helix-editor"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    hx --version

    mkdir --parents "/usr/share/bash-completion/completions/"
    ln --symbolic "$PWD/contrib/completion/hx.bash" "/usr/share/bash-completion/completions/taplo"
    
    mkdir --parents "/usr/share/fish/vendor_completions.d/"
    ln --symbolic "$PWD/contrib/completion/hx.fish" "/usr/share/fish/vendor_completions.d/taplo.fish"
    
    mkdir --parents "/usr/local/share/zsh/site-functions/"
    ln --symbolic "$PWD/contrib/completion/hx.zsh" "/usr/local/share/zsh/site-functions/_taplo"
}

stdlib_install "install_callback"
