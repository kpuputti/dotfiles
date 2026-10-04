# Kimmo's dotfiles

Declarative machine setup, managed with [chezmoi](https://www.chezmoi.io/):

- **Dotfiles**: zsh, git, tmux, Hammerspoon — files in this repo, applied
  to `$HOME`
- **Homebrew packages**: `dot_Brewfile` → `~/.Brewfile`, applied with
  `brew bundle --global`
- **Language runtimes**: [mise](https://mise.jdx.dev/) (node, terraform,
  python) via `dot_config/mise/config.toml`; per-project versions from
  `.node-version` / `.terraform-version` files
- **Global npm packages**: `dot_default-npm-packages` →
  `~/.default-npm-packages`, installed by mise into every Node version
- **Emacs**: [Doom Emacs](https://github.com/doomemacs/core) private config
  in `dot_doom.d/` → `~/.doom.d`; Doom itself is an external clone at
  `~/.emacs.d` (not managed here, has its own `.gitignore` for the generated
  `.local/` etc.), cloned and installed by `run_once_after_30-doom-install.sh`
- **Containers**: [Colima](https://colima.run/) runs the Docker engine in a
  Linux VM (started at login as a brew service); the `docker` CLI, compose
  and buildx come from Homebrew. VM settings in
  `dot_colima/_templates/default.yaml`; `~/.docker/config.json` is patched in
  place by `dot_docker/modify_private_config.json` (needs `jq`)

The `run_onchange_after_*` scripts re-run `brew bundle`, `mise install` and
`doom sync` automatically whenever their source files change (for Doom:
`init.el` / `packages.el`).

## Prerequisites / assumptions

- Apple Silicon Mac — the Homebrew prefix `/opt/homebrew` is hardcoded where
  it must be (`.zprofile` bootstrap, run scripts, libpq/gcloud PATH entries)
- Directory convention: `~/code/projects/` for personal repos (drives the
  personal git identity via `includeIf`), work repos elsewhere
- Emacs: `$HOME/.emacs.d/bin` is on PATH and `emacs -nw` is the editor —
  emacs itself and the Doom module dependencies come from the Brewfile
- No username or home-directory assumptions — everything uses `$HOME`/`~`

## Machine-local overrides

Work-specific and machine-specific config (emails, work aliases, secrets)
stays OUT of this repo. Each managed file sources/includes an unmanaged,
hand-edited local file if it exists:

- `~/.gitconfig.local` — default git email (`[user] email = ...`), work overrides
- `~/.gitconfig.personal` — personal git email; applied automatically to all
  repos under `~/code/projects/` (via `includeIf` in the gitconfig)
- `~/.zshrc.local` — work aliases and functions, including per-repo `up`
  steps (see below)
- `~/.zshenv.local` — work env vars, secrets
- `~/.config/proj/projects` — project layouts for `proj` (see below)

If a secret is ever needed in a managed file, chezmoi can read 1Password at
apply time (`onepasswordRead "op://vault/item/field"` in a `.tmpl` file) —
requires the 1Password app's CLI integration. Not currently used.

## New machine bootstrap

1. Install Homebrew (installs Xcode CLT, which provides git):
   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. `brew install chezmoi`
3. `git clone git@github.com:kpuputti/dotfiles.git ~/code/projects/dotfiles`
4. `chezmoi init --source ~/code/projects/dotfiles --apply`
   — writes all dotfiles, then cascades: `brew bundle --global` →
   `mise install` → clone Doom + `doom install`
5. Create the machine-local files (see above), at minimum
   `~/.gitconfig.local` with the git email
6. Open a new terminal.

## Daily use

- Edit configs in this repo, then `chezmoi apply`
- `chezmoi diff` — show drift between repo and live files
- `chezmoi re-add` — pull a live edit back into the repo
- `update` (zsh function) — [topgrade](https://github.com/topgrade-rs/topgrade)
  (steps in `dot_config/topgrade.toml`), a list of pending macOS updates
  (install them from System Settings) + dotfiles/Brewfile sync checks
- `delete-merged-branches` (zsh function) — updates the default branch,
  deletes local branches merged into it, then offers to force-delete
  branches whose upstream is gone (e.g. squash-merged on GitHub)
- New global CLI tool: add to `dot_Brewfile` (or `dot_default-npm-packages`
  for npm tools), then `chezmoi apply`
- Emacs: edit `dot_doom.d/`, then `chezmoi apply` (runs `doom sync` when
  `init.el`/`packages.el` changed). `doom upgrade` is deliberately manual —
  it can break the editor, so run it when there's slack to fix fallout
- Containers: `colima status` / `colima stop` / `colima start`. The template
  only applies when the VM is created: tweak a running VM with
  `colima start --edit`, or `colima delete` (wipes all images, containers and
  volumes) and `colima start` to rebuild it from the template

## Terminal projects (`proj`)

`proj` (zsh function) opens a Ghostty window per project, with one tab per
configured directory:

- `proj` — list projects
- `proj <name>` — open the project, or bring its window to the front if
  `proj` already opened it
- `proj all` — open every project

Projects are defined in `~/.config/proj/projects`, which is kept out of the
repo:

```
[myproject]
~/path/to/myproject
~/path/to/myproject/subdir
```

Missing directories print a warning. Windows restored after a Ghostty
relaunch aren't recognised, so `proj` opens a new window for them.

## Updating a repo (`up`)

`up` (zsh function), run anywhere in a git repo: aborts if there are staged
or unstaged changes, switches to the default branch and pulls with
`--ff-only`.

Extra steps per repo go in `~/.zshrc.local` as a function named
`up_<repo dir name>`, run from the repo root after the pull:

```zsh
up_myrepo() { npm install && npm run migrate; }
```

## Follow-ups

In priority order.

### 1. Finish the mise migration

- After the mise soak period, decommission the legacy version managers:
  remove the TRANSITION-marked nodenv/pyenv/tfenv entries (Brewfile, zshrc,
  `nodenv-default-packages`, `.chezmoiignore`), the `nodenv-sync-defaults`
  function and the stale nodenv header in `dot_default-npm-packages`, then
  `brew uninstall nodenv pyenv tfenv && brew autoremove`,
  `rm -rf ~/.nodenv ~/.pyenv ~/.zsh/pure ~/Library/pnpm`, and the
  `~/.{zshrc,zshenv,zprofile,gitconfig}.bak` backups
- With the same change, move global npm tools from
  `dot_default-npm-packages` to mise's npm backend
  (`"npm:prettier" = "latest"` in the mise config): shared across Node
  versions, updated by `mise upgrade`/topgrade, and the npm install step in
  `run_onchange_after_20` can go. Install pnpm as its own mise tool
  (`pnpm = "10"`), since corepack isn't bundled from Node 25 on.
  Check that Emacs still finds the formatters: Doom snapshots `PATH` at
  `doom sync`, so putting mise's shims on `PATH` in `.zprofile` may be needed
- Python isn't used for development anymore: remove `python` from the mise
  config (`[tools]` and `idiomatic_version_file_enable_tools`). The gcloud
  cask and other Homebrew packages pull in Homebrew's Python as a dependency

### 2. Daily-use improvements

- Add CLI tools: `fzf` (Ctrl-T file picker, fzf-tab completion), `zoxide`
  (replaces the `cd,,,` aliases together with `setopt AUTO_CD`), `delta`
  (git pager; also `[diff] pager` in the chezmoi config), `bat`
- 1Password: use its SSH agent and sign commits with SSH
  (`gpg.format = ssh`); the CLI is already installed
- Terminal: trialling Ghostty (default keybindings, no tmux) with `proj <name>`
  opening one window per project, instead of iTerm + tmux. If it sticks,
  remove `tmux` from the Brewfile and `dot_tmux.conf`, and uninstall iTerm

### 3. Emacs

- Upgrade to Emacs 31.1 (released August 2026; Doom supports and recommends
  it): `emacs-plus@30` → `emacs-plus@31` in the Brewfile. Doom is also
  behind upstream, so do it together with `doom upgrade`. Afterwards:
  - Run `doom sync --rebuild` from your own terminal: packages compiled
    for Emacs 30 need rebuilding, and the run script only syncs when
    `init.el`/`packages.el` change
  - `emacs-plus@31` depends on the regular `tree-sitter` formula, so the
    `tree-sitter@0.25, link: true` workaround can probably go
  - Check the emacs-plus `PATH` workaround in `config.el`
    (`ns-emacs-plus-injected-path`) still applies
- Doom cleanup (low risk):
  - `packages.el`, remove `graphql-mode` and its `use-package!` in
    `config.el` (the `:lang graphql` module installs it); `anzu`
    (`:ui modeline` installs it; keep the `after!` in `config.el` that turns
    it on, nothing else does without evil); `ag` (not installed, nothing uses
    it); `jsonrpc` (nothing installed requires it; Doom only adds it for
    `lsp +eglot`); `claude-code-ide` (unused, `agent-shell` is the one
    configured)
  - Replace `(package! restclient)` with `rest` under `:lang` in `init.el`
    (Doom pins it and maps `*.http` files; restclient is maintained under
    emacsorphanage, not archived)
  - Markdown preview: `config.el` sets `markdown-command` to pandoc, so the
    `+grip` flag, `grip` (Brewfile) and the `marked`, `js-beautify`,
    `stylelint` npm packages are unused (apheleia formats with prettier)
- `EDITOR`/`core.editor`: `emacsclient -t -a ""` instead of `emacs -nw`,
  to reuse a running Emacs instead of starting Doom each time
- Doom modules, when there's slack: `(company +childframe)` →
  `(corfu +orderless)`; consider `(lsp +eglot)` (built into Emacs, but the
  `lsp-mode` settings in `config.el` need porting) and whether
  `(undo +tree)` is still wanted over the default undo-fu

### 4. Larger changes, when there's slack

- Manage macOS defaults (key repeat, Dock, Finder, screenshot location) with
  a `run_onchange_after_*` script
- Declare GUI apps installed outside Homebrew (browser, Slack, 1Password app)
  as casks or `mas` entries, so `brew bundle cleanup` sees all drift
- Hammerspoon: try macOS's built-in window tiling (Fn+Ctrl+arrows); drop
  Hammerspoon if it covers enough
