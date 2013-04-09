# kpuputti's dot emacs

Built on top of
[Emacs Starter Kit](https://github.com/technomancy/emacs-starter-kit),
heavily inspired by @akheron's
[dotemacs](https://github.com/akheron/dotemacs).

## Requirements

Flymake tmp directory:

    mkdir ~/.emacs.d/tmp

Command line tools for flymake:

    sudo npm install -g jshint csslint
    sudo gem install sass # or compass

## TODO

- JavaScript
  - configure js2-mode
  - js2-refactor
    - https://github.com/magnars/js2-refactor.el
  - js2-highlight-vars-mode
    - http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode/js2-highlight-vars-mode
  - ac-js2 for autocompletion
    - https://github.com/ScottyB/ac-js2
  - jshint through flymake (with .jshintrc file support?)
  - proper indentation (espresso?)
  - js2-imenu-extras ?
- proper html mode with support for HTML5 and embedded css/js
  - https://github.com/fgallina/multi-web-mode
  - http://stackoverflow.com/questions/1082474/authoring-html5-in-emacs
- CoffeeScript (mode)
- Python (mode + pyflakes with flymake)
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
