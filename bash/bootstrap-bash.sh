#!/bin/bash
set -e

echo "Bootstrap script for hx-dotfiles/bash"

function loge {
    echo $* >&2
}

if [ -z "$HXDOTFILES_DIR" ]; then
    loge "!!ERR Environmental Variable HXDOTFILES_DIR must be specified"
    exit 1
fi

if [ ! -f ~/.bashrc ]; then
    touch ~/.bashrc
fi

if grep "# hx-dotfiles section" ~/.bashrc >/dev/null 2>/dev/null; then
    loge "~/.bashrc is already dotfilized"
else
    BASHRC_COMMON=$HXDOTFILES_DIR/bash/bashrc_common
    loge "- including $BASHRC_COMMON in ~/.bashrc"
    
    echo >> ~/.bashrc
    echo "# hx-dotfiles section" >> ~/.bashrc
    echo "if [ -f $BASHRC_COMMON ]; then"  >> ~/.bashrc
    echo "  source $BASHRC_COMMON"  >> ~/.bashrc
    echo "fi" >> ~/.bashrc

    if [ $PLATFORM = 'osx' ]; then
        BASHRC_OSX=$HXDOTFILES_DIR/bash/bashrc_osx
        loge "- including $BASHRC_COMMON in ~/.bashrc"

        echo "if [ -f $BASHRC_OSX ]; then"  >> ~/.bashrc
        echo "  source $BASHRC_OSX"  >> ~/.bashrc
        echo "fi" >> ~/.bashrc
    fi
fi

if [ $PLATFORM = 'osx' ]; then
    if grep "# hx-dotfiles section" ~/.bash_profile >/dev/null 2>/dev/null; then
        loge "~/.bash_profile is already dotfilized"
    else
        BASHRC_COMMON=$HXDOTFILES_DIR/bash/bashrc_common

        loge "- including ~/.bashrc in ~/.bash_profile"
        
        echo >> ~/.bash_profile
        echo "# hx-dotfiles section" >> ~/.bash_profile
        echo "if [ -f ~/.bashrc ]; then"  >> ~/.bash_profile
        echo "  source ~/.bashrc"  >> ~/.bash_profile
        echo "fi" >> ~/.bash_profile
    fi
fi

loge
