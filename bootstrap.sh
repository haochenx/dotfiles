#!/bin/bash
set -e

function configure_base {
    SCRIPT_DIR=$(dirname $0)
    GIT_ROOT=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)
    GIT_DIR="$SCRIPT_DIR/$(git -C "$SCRIPT_DIR" rev-parse --git-dir)"

    export HXDOTFILES_DIR="$GIT_ROOT"
}

function install_base {
    ## install git configuration
    "$HXDOTFILES_DIR/git/bootstrap-git.sh"

    ## install bash configuration
    "$HXDOTFILES_DIR/bash/bootstrap-bash.sh"
    
    ## install emacs configuration
    "$HXDOTFILES_DIR/emacs/bootstrap-emacs.sh"
}

function configure_osx {
    export PLATFORM=osx
}

function install_osx {
    configure_base
    configure_osx
    install_base
}

function configure_cygwin {
    export PLATFORM=cygwin
}

function install_cygwin {
    loge "!!WARN: Installation on cygwin is not supported yet."
    loge "        only base installation would be executed, which"
    loge "        may not function correctly."
    loge

    configure_base
    configure_cygwin
    install_base
}

function loge {
    echo "$*" >&2
}

function show {
    echo $* >&1
}

function main {
    case $1 in
        config)
            case $2 in
                show)
                    show_config
                    ;;
                *)
                    show_help_config
                    exit 1
            esac
            ;;
        install)
            case $2 in
                osx)
                    install_osx
                    ;;
                cygwin)
                    install_cygwin
                    ;;
                *)
                    show_help_install
            esac
            ;;
        *)
            show_help_main
            exit 1
    esac
}

function show_config {
    configure_base
    
    show Git Root = "$GIT_ROOT"
    show Git Dir = "$GIT_DIR"
}

function show_help_config {
    loge "usage: bootstrap.sh config {show,help}"
}

function show_help_main {
    loge "usage: bootstrap.sh {install,config,help}"
}

function show_help_install {
    loge "usage: bootstrap.sh install {osx,cygwin}"
}

main $*
