#!/bin/bash
set -e

echo "Bootstrap script for hx-dotfiles/emacs"

function loge {
    echo $* >&2
}

if [ -z "$HXDOTFILES_DIR" ]; then
    loge "!!ERR Environmental Variable HXDOTFILES_DIR must be specified"
    exit 1
fi

if [ -f ~/.emacs -a ! -L ~/.emacs ]; then
    loge "!!WARN backing up ~/.emacs to ~/.emacs.bak"
    mv ~/.emacs ~/.emacs.bak
else
    loge "~/.emacs is already dotfilized"
fi

if [ ! -f ~/.emacs.local ]; then
    set -x
    touch ~/.emacs.local
    { set +x; } 2> /dev/null
fi

if [ ! -L ~/.emacs.platform ]; then
    rm -f ~/.emacs.platform
    set -x
    ln -s "$HXDOTFILES_DIR/emacs/dot-emacs-$PLATFORM" ~/.emacs.platform
    { set +x; } 2> /dev/null
fi

if [ ! -f ~/.emacs ]; then
    ln -s "$HXDOTFILES_DIR/emacs/dot-emacs-common" ~/.emacs
fi

loge
