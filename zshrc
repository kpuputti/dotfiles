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

## Functions

function git-publish() {
    # Merge changes from master branch into the gh-pages branch and
    # push them to the origin gh-pages branch.
    git checkout gh-pages && git merge master && git push origin gh-pages && git checkout master
}

function update() {
    echo 'updating brew...'
    brew update
    brew upgrade
    echo 'updating gem...'
    gem update
    echo 'updating npm...'
    npm update --global
    # TODO: update pip (+ easy_install ?) packages
    echo 'everything updated'
}

## Exports

HOME_BIN_DIR=$HOME/bin

export EDITOR='subl -w'

# PATH
export PATH=$HOME_BIN_DIR:$PATH
