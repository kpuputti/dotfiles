# Kimmo's dotfiles

Declarative machine setup, managed with [chezmoi](https://www.chezmoi.io/):

- **Dotfiles**: zsh, git, Ghostty, Hammerspoon — files in this repo, applied
  to `$HOME`
- **Homebrew packages**: `dot_Brewfile` → `~/.Brewfile`, applied with
  `brew bundle --global`
- **Language runtimes**: [mise](https://mise.jdx.dev/) (node, terraform)
  via `dot_config/mise/config.toml`; per-project versions from
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
7. macOS settings, by hand in System Settings / Finder:
   - Keyboard: key repeat rate and delay until repeat both at the fastest;
     Keyboard Shortcuts → Modifier Keys: Caps Lock → Control (set per
     keyboard)
   - Keyboard → Text Input → Edit: auto-correct, auto-capitalisation,
     double-space full stop, smart quotes and dashes all off
   - Appearance: Auto
   - Desktop & Dock: automatically hide the Dock; Hot Corners: bottom right
     off
   - Finder settings: show all filename extensions, new windows open the
     Desktop; list view as the default (View → as List, then View → Show
     View Options → Use as Defaults)

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

- Move global npm tools from `dot_default-npm-packages` to mise's npm
  backend (`"npm:prettier" = "latest"` in the mise config): shared across
  Node versions, updated by `mise upgrade`/topgrade, and the npm install step
  in `run_onchange_after_20` can go. Install pnpm as its own mise tool
  (`pnpm = "10"`), since corepack isn't bundled from Node 25 on. Emacs
  currently finds the tools via `~/.local/share/mise/installs/node/24/bin` in
  the `PATH` Doom saved at the last `doom sync`, so after the move run
  `doom sync` from a terminal (not an agent session) and check that the
  formatters and agent-shell (`claude-agent-acp`) still work
- Remove the duplicate global npm tools installed with Homebrew's Node
  (`/opt/homebrew/lib/node_modules`: prettier, pnpm, claude-agent-acp etc.).
  Homebrew's Node itself stays as a `gemini-cli` dependency

### 2. Daily-use improvements

- 1Password SSH agent and SSH commit signing. Not urgent, and it touches
  the 1Password app the work setup relies on, so do it when there's time to
  test:
  - Agent: the GitHub SSH key moves into 1Password, so
    there's no key file on disk for malware to copy, use needs Touch ID
    approval, and the key syncs to new machines. Import the key, enable the
    agent (Settings → Developer), set `IdentityAgent` to 1Password's
    `agent.sock` in `~/.ssh/config` (drop `IdentityFile`/`UseKeychain`;
    bring the file into this repo), then delete the key file
  - Signing: GitHub shows commits as Verified. In the gitconfig set
    `gpg.format = ssh`, `gpg "ssh".program` to
    `/Applications/1Password.app/Contents/MacOS/op-ssh-sign`,
    `user.signingkey` to the public key and `commit.gpgsign = true`, and add
    the key on GitHub as a signing key

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
- Postgres queries from Emacs instead of DataGrip: `sql-postgres` (psql) for
  running queries, `\d` for schemas and `\copy ... csv header` for export,
  plus [sqls](https://github.com/sqls-server/sqls) via `lsp-mode` for
  table/column completion and `JOIN ... ON` completion (needs foreign keys).
  Connections in a machine-local file loaded from `config.el`, passwords
  fetched with `op read` at connect time and passed to both psql and sqls.
  sqls has no stable release yet; check whether Homebrew packages it
- `EDITOR`/`core.editor`: `emacsclient -t -a ""` instead of `emacs -nw`,
  to reuse a running Emacs instead of starting Doom each time
- Doom modules, when there's slack: `(company +childframe)` →
  `(corfu +orderless)`; consider `(lsp +eglot)` (built into Emacs, but the
  `lsp-mode` settings in `config.el` need porting) and whether
  `(undo +tree)` is still wanted over the default undo-fu

### 4. Declare GUI apps in the Brewfile

Apps installed by hand need a one-time
`brew install --cask --adopt <token>` before `brew bundle` manages them.
If macOS blocks the adopt (`chmod ... Operation not permitted`), move the
app to the Trash and run `brew install --cask <token>` instead; app data in
`~/Library` is kept.
`brew bundle cleanup` also offers to uninstall undeclared `mas` apps.

- `cask "google-chrome"`
- `cask "1password"`
- `cask "wire"` (replaces the App Store copy and its `mas "Wire"` line:
  delete the App Store app, then install the cask). The message history is
  already backed up. On hold: Homebrew disabled the `wire` cask on 2026-09-01
  (fails Gatekeeper), so keep the App Store copy until the cask is re-enabled
- `cask "datagrip"`
- `cask "tailscale-app"` (the installed standalone build, not the App Store
  one)
- Not declarable: Chrome and Firefox extensions (use browser sync)
