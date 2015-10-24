#!/bin/bash
set -e

echo "Bootstrap script for hx-dotfiles/git"

function loge {
    echo $* >&2
}

if [ -z "$HXDOTFILES_DIR" ]; then
    loge "!!ERR Environmental Variable HXDOTFILES_DIR must be specified"
    exit 1
fi

set -x
git config --global include.path "$HXDOTFILES_DIR/git/gitconfig_common"

{ set +x; } 2> /dev/null
loge
