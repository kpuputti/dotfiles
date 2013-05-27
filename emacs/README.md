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

## Updating packages

From [MELPA docs](http://melpa.milkbox.net/#installing):

    package.el now includes a mechanism to upgrade packages. After
    running package-list-packages, type U (mark Upgradable packages)
    and then x (eXecute the installs and deletions). When it’s done
    installing all the packages it will ask if you want to delete the
    obsolete packages and so you can hit y (Yes).

    If you run into a problem installing or upgrading, you may need to
    go into your ~/.emacs.d/elpa/ directory and delete packages that
    are installed multiple times. This can happen when the install
    times out.

## TODO

- JavaScript
  - js2-refactor
    - https://github.com/magnars/js2-refactor.el
  - js2-imenu-extras ?
  - fix yasnippets in js2-mode

- Helm (anything): https://github.com/emacs-helm/helm
- try fixing compilation errors in Makefile
- proper html mode with support for HTML5 and embedded css/js
  - https://github.com/fgallina/multi-web-mode
  - http://stackoverflow.com/questions/1082474/authoring-html5-in-emacs
- ac-nrepl for Clojure autocompletion
- imenu ?
- set up server + possible shell aliases
- set up saving/restoring projects
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
