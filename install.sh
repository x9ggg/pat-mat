#!/usr/bin/env bash
# pat&mat 一键安装：克隆（或更新）仓库，再装进本机每家已适配的 CLI。
#   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
# PATMAT_HOME 改安装目录（默认 ~/pat-mat），PATMAT_REPO 改仓库地址（用于 fork）。
set -euo pipefail

dir=${PATMAT_HOME:-$HOME/pat-mat}
repo=${PATMAT_REPO:-https://github.com/x9ggg/pat-mat}

command -v git >/dev/null 2>&1 || {
  echo "pat&mat: 需要 git" >&2
  exit 1
}

if [ -d "$dir/.git" ]; then
  git -C "$dir" pull --ff-only
elif [ -e "$dir" ]; then
  echo "pat&mat: $dir 已存在但不是 pat-mat 仓库。用 PATMAT_HOME=<目录> 指定别处后重试。" >&2
  exit 1
else
  git clone "$repo" "$dir"
fi

exec "$dir/scripts/patmat" install
