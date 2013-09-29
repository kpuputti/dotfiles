# kpuputti-pack

[Emacs Live](http://overtone.github.io/emacs-live/)
([documentation](http://overtone.github.io/emacs-live/documentation.html))
pack for my [Emacs](http://www.gnu.org/software/emacs/) config.

## Requirements

Command line tools for [Flycheck](http://flycheck.github.io/):

```
sudo npm install -g jshint csslint jsonlint coffeelint
sudo gem install sass # or compass
sudo pip install flake8
```

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

### Must

- flycheck
- css, scss (with css autocompletion?)
- web-mode
- daemon mode + emacsclient + aliases

### Should

- yasnippet (config, bindings)
- FuzzyFormat for indentation detection
- ensime for Scala dev

### Could

- dirtree
- json (with flycheck)
- js2-refactor
- github flavored markdown + preview
- flyspell on code comments
- anzu-mode to enhance isearch
- opening a URL
- el-get
- .editorconfig support
