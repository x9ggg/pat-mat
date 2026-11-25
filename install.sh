#!/usr/bin/env bash
# pat&mat one-command install: clone (or update) the repository, then install into every supported CLI on this machine.
#   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
# PATMAT_HOME changes the install directory (default ~/pat-mat); PATMAT_REPO changes the repository URL (for forks).
set -euo pipefail

dir=${PATMAT_HOME:-$HOME/pat-mat}
repo=${PATMAT_REPO:-https://github.com/x9ggg/pat-mat}

command -v git >/dev/null 2>&1 || {
  echo "pat&mat: git is required" >&2
  exit 1
}

if [ -d "$dir/.git" ]; then
  git -C "$dir" pull --ff-only
elif [ -e "$dir" ]; then
  echo "pat&mat: $dir exists but is not a pat-mat repository. Set PATMAT_HOME=<dir> to use another location and retry." >&2
  exit 1
else
  git clone "$repo" "$dir"
fi

exec "$dir/scripts/patmat" install
