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

# alias gitg='gitg --all'
# alias share-folder='python -mSimpleHTTPServer 8080'
alias dev-browser='chromium-browser \
    --disable-web-security \
    --disable-application-cache \
    --disk-cache-size=0 \
    --enable-devtools-experiments \
    --enable-memory-info \
    --media-cache-size=0'

# Lol, run sl on typos.
alias lls="sl"
alias LS="sl"
alias CD="sl"
alias gi="sl"
alias les="sl"

## Exports

# export EDITOR=

DEV_LIB=$HOME/dev/lib

export ANDROID_HOME=$DEV_LIB/android-sdk-linux

HOME_BIN=$HOME/bin
ANDROID_TOOLS=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
SBT=$DEV_LIB/sbt/bin

export PATH=$HOME_BIN:$ANDROID_TOOLS:$SBT:$PATH
