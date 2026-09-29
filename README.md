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

The `run_onchange_after_*` scripts re-run `brew bundle` and `mise install`
automatically whenever their source files change.

## Prerequisites / assumptions

- Apple Silicon Mac — the Homebrew prefix `/opt/homebrew` is hardcoded where
  it must be (`.zprofile` bootstrap, run scripts, libpq/gcloud PATH entries)
- Directory convention: `~/code/projects/` for personal repos (drives the
  personal git identity via `includeIf`), work repos elsewhere
- Emacs config lives in `~/.doom.d` (separate repo for now); `$HOME/.emacs.d/bin`
  is on PATH and `emacs -nw` is the editor — emacs itself comes from the Brewfile
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
   — writes all dotfiles, then cascades: `brew bundle --global` → `mise install`
5. Create the machine-local files (see above), at minimum
   `~/.gitconfig.local` with the git email
6. Open a new terminal.

## Daily use

- Edit configs in this repo, then `chezmoi apply`
- `chezmoi diff` — show drift between repo and live files
- `chezmoi re-add` — pull a live edit back into the repo
- `update` (zsh function) — brew update/upgrade/bundle/cleanup + mise upgrade
- New global CLI tool: add to `dot_Brewfile` (or `dot_default-npm-packages`
  for npm tools), then `chezmoi apply`

## Follow-ups

- Remove the TRANSITION-marked nodenv/pyenv/tfenv entries (Brewfile, zshrc,
  `nodenv-default-packages`, `.chezmoiignore`) after the mise soak period,
  then `brew uninstall nodenv pyenv tfenv && brew autoremove` and
  `rm -rf ~/.nodenv ~/.pyenv ~/.zsh/pure ~/Library/pnpm`
- Migrate `~/.doom.d` into this repo (needs git history migration) as
  `dot_doom.d/`; Doom itself (`~/.emacs.d`) stays an external clone,
  installed by a future `run_once_` script
- Optional zsh niceties: zsh-autosuggestions, zsh-history-substring-search
- Modernize the terminal setup from iTerm/zsh/tmux to something modern
  (separate research: e.g. Ghostty/WezTerm, zellij, fish/nushell)
- Replace Docker Desktop with a lightweight alternative (e.g. colima,
  OrbStack, podman)
- Dockerize/sandbox some tools where isolation is useful
- Evaluate remaining legacy in the dotfiles; modernize and update
