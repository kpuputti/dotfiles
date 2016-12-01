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

alias llh="ll --human-readable"
alias lah="la --human-readable"
alias tree="tree -C"
alias server="python -m SimpleHTTPServer"

alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias glo="git log --oneline"
alias glp="git log --patch"
alias gc="git commit"
alias ga="git add"
alias gco="git checkout"

## Functions

function git-publish() {
    # Merge changes from master branch into the gh-pages branch and
    # push them to the origin gh-pages branch.
    git checkout gh-pages && git merge master && git push origin gh-pages && git checkout master
}

function delete-merged-branches() {
    git checkout master && git branch --merged | grep -v master | xargs git branch -d
}

function update() {
    echo 'updating brew...'
    brew update
    brew upgrade --all
    echo 'updating gem...'
    gem update
    echo 'updating npm...'
    npm update --global
    # TODO: update pip (+ easy_install ?) packages
    echo 'everything updated'
}

## Exports

# HOME_BIN_DIR=$HOME/bin

# PATH
# export PATH=$HOME_BIN_DIR:$PATH
