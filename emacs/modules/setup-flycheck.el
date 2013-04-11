;;; flycheck

(global-flycheck-mode t)

(setq flycheck-checkers (quote (bash
                                coffee-coffeelint
                                css-csslint
                                go-gofmt
                                haml
                                html-tidy
                                javascript-jshint
                                json-jsonlint
                                lua
                                perl
                                php
                                php-phpcs
                                python-flake8
                                python-pylint
                                python-pyflakes
                                ruby
                                rust-rustc
                                sass
                                sh
                                tex-chktex
                                tex-lacheck
                                xml-xmlstarlet
                                zsh)))
