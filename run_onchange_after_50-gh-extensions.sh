#!/bin/sh
set -eu
export PATH="/opt/homebrew/bin:$PATH"

extensions="
github/gh-stack
"

installed=$(gh extension list | cut -f2)
for ext in $extensions; do
	printf '%s\n' "$installed" | grep -qxF "$ext" && continue
	gh extension install "$ext"
done
