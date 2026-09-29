#!/bin/sh
set -eu
export PATH="/opt/homebrew/bin:$PATH"
[ -d "$HOME/.emacs.d" ] && exit 0
git clone --depth 1 https://github.com/doomemacs/core "$HOME/.emacs.d"
"$HOME/.emacs.d/bin/doom" install --no-config --env
