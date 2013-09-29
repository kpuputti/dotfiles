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

- helm
- projectile
- dirtree
- yasnippet
- flycheck
- js2-refactor
- web-mode
- daemon mode + emacsclient + aliases
- .editorconfig support
- FuzzyFormat for indentation detection
- json
- css, scss
- ensime
- github flavored markdown + preview
- enable flyspell on code comments
- anzu-mode to enhance isearch
- enable opening a browser when clicking a URL
