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
- `~/.zshrc.local` — work aliases and functions
- `~/.zshenv.local` — work env vars, secrets

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
  (steps in `dot_config/topgrade.toml`) + dotfiles/Brewfile sync checks
- New global CLI tool: add to `dot_Brewfile` (or `dot_default-npm-packages`
  for npm tools), then `chezmoi apply`
- Emacs: edit `dot_doom.d/`, then `chezmoi apply` (runs `doom sync` when
  `init.el`/`packages.el` changed). `doom upgrade` is deliberately manual —
  it can break the editor, so run it when there's slack to fix fallout
- Containers: `colima status` / `colima stop` / `colima start`. The template
  only applies when the VM is created: tweak a running VM with
  `colima start --edit`, or `colima delete` (wipes all images, containers and
  volumes) and `colima start` to rebuild it from the template

## Follow-ups

- After the mise soak period, decommission the legacy version managers:
  remove the TRANSITION-marked nodenv/pyenv/tfenv entries (Brewfile, zshrc,
  `nodenv-default-packages`, `.chezmoiignore`), then
  `brew uninstall nodenv pyenv tfenv && brew autoremove`,
  `rm -rf ~/.nodenv ~/.pyenv ~/.zsh/pure ~/Library/pnpm`, and the
  `~/.{zshrc,zshenv,zprofile,gitconfig}.bak` backups
- With the same change, consider moving global npm tools from
  `dot_default-npm-packages` to mise's npm backend
  (`"npm:prettier" = "latest"` in the mise config): shared across Node
  versions, updated by `mise upgrade`/topgrade, and any output from
  `npm ls -g` beyond npm/corepack then becomes visible drift
- Optional zsh niceties: zsh-autosuggestions, zsh-history-substring-search
- Modernize the terminal setup from iTerm/zsh/tmux to something modern
  (separate research: e.g. Ghostty/WezTerm, zellij, fish/nushell)
- Dockerize/sandbox some tools where isolation is useful
- Evaluate remaining legacy in the dotfiles; modernize and update
