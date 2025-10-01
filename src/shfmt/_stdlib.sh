#!/bin/sh

set -ex

_stdlib_check_commands() {
    for name in "${@}"; do
        if ! command -v "${name}"; then
            >&2 echo "${name}: command not found"
            exit 1
        fi
    done
}

stdlib_init() {
    if [ "$(id --user)" -ne 0 ]; then
        >&2 echo "Script must be run as root. Use sudo, su, or add 'USER root' to your Dockerfile before running this script"
        exit 1
    fi

    if [ -d "/opt/${FEATURE_ID}/" ]; then
        exit 0
    fi

    _stdlib_check_commands "${@}"
}

stdlib_configure() {
    mkdir --parents "/tmp/${FEATURE_ID}/"
    cd "/tmp/${FEATURE_ID}/"
    "${1}"
}

stdlib_build() {
    mkdir --parents "/opt/${FEATURE_ID}/"
    cd "/opt/${FEATURE_ID}/"
    "${1}"
}

stdlib_install() {
    mkfifo "./pipe"
    jq -r ".containerEnv | try to_entries[][]" "$(dirname "$(realpath "${0}")")/devcontainer-feature.json" >"./pipe" &
    while read -r "key"; do
        read -r "value"
        eval "export \"${key}\"=\"${value}\""
    done <"./pipe"
    rm --force "./pipe"

    "${1}"
}

_stdlib_check_commands "jq"
