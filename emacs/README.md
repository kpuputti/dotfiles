# kpuputti's dot emacs

Built on top of
[Emacs Starter Kit](https://github.com/technomancy/emacs-starter-kit),
heavily inspired by @akheron's
[dotemacs](https://github.com/akheron/dotemacs).

## Requirements

Command line tools for flycheck:

    sudo npm install -g jshint csslint jsonlint coffeelint
    sudo gem install sass # or compass
    sudo pip install flake8

## TODO

- organize modules
  - init.el defined packages, install them, loads specified modules
  - no numbers in file names for defining the order

- JavaScript
  - js2-refactor
    - https://github.com/magnars/js2-refactor.el
  - ac-js2 for autocompletion
    - https://github.com/ScottyB/ac-js2
  - js2-imenu-extras ?
  - fix yasnippets in js2-mode

- configure flycheck
- proper html mode with support for HTML5 and embedded css/js
  - https://github.com/fgallina/multi-web-mode
  - http://stackoverflow.com/questions/1082474/authoring-html5-in-emacs
- ac-nrepl for Clojure autocompletion
- imenu ?
- set up server + possible shell aliases
- set up saving/restoring projects
- Makefile for compiling all .el files to .elc
- Use git submodules for packages not found in the repos
- add support for .editorconfig
  - https://github.com/editorconfig/editorconfig-emacs
- set up fuzzy format to detect indentation settings
  - http://www.emacswiki.org/emacs/FuzzyFormat

- check out kite (WebKit inspector front end for Emacs)
  - https://github.com/jscheid/kite
- mark multiple
- string rectangle
- undo tree
- expand region
- ace jump mode
- swank-js
- emmet (zen coding)
- mc (multiple cursors)
