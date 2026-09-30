# Working in this repo

## Applying changes

`chezmoi apply` is safe to run from anywhere, including agent-shell or a
Claude Code session. Its run scripts are written to be environment-independent.

## Never run a bare `doom sync`

Doom's `doom sync` snapshots the calling process's environment into Emacs's
envvar file. Run from inside an agent session, that file picks up the
session's `CLAUDE*` variables, and the next Claude started in agent-shell
believes it is a nested session.

Let `chezmoi apply` handle it (the doom-sync run script runs it from a
scrubbed login shell). If a resync is needed without a Doom config change,
for example after a shell PATH change, tell the user to run `doom sync` from
their own terminal rather than running it yourself.
