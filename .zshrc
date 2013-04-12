### ZSH customizations

# add `source /path/to/this/file` in ~/.zshrc

## Aliases

alias cd,="cd .."
alias cd,,="cd ../.."
alias cd,,,="cd ../../.."
alias cd,,,,="cd ../../../.."
alias cd,,,,,="cd ../../../../.."
alias cd,,,,,,="cd ../../../../../.."
alias cd,,,,,,,="cd ../../../../../../.."

alias llh="ll -h"
alias lah="la -h"

# alias share-folder='python -mSimpleHTTPServer 8080'

alias dev-browser='chromium-browser \
    --disable-web-security \
    --disable-application-cache \
    --disk-cache-size=0 \
    --enable-devtools-experiments \
    --enable-memory-info \
    --media-cache-size=0'

alias mvn="mvn-color"

## Functions

function git-publish() {
    # Merge changes from master branch into the gh-pages branch and
    # push them to the origin gh-pages branch.
    git checkout gh-pages && git merge master && git push origin gh-pages && git checkout master
}

## Exports

# export EDITOR=

DEV_LIB=$HOME/dev/lib

# ANDROID_HOME
export ANDROID_HOME=$DEV_LIB/android-sdk-linux

HOME_BIN=$HOME/bin
ANDROID_TOOLS=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
SBT=$DEV_LIB/sbt/bin

# PATH
export PATH=$HOME_BIN:$ANDROID_TOOLS:$SBT:$PATH
