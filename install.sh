#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE_DEFAULT=""
RAW_BASE="${1:-$REPO_RAW_BASE_DEFAULT}"

if [[ -z "${RAW_BASE}" ]]; then
  echo "Usage:"
  echo "  bash install.sh https://raw.githubusercontent.com/<user>/<repo>/<branch>"
  echo
  echo "Example:"
  echo "  bash install.sh https://raw.githubusercontent.com/ronnie/vim-setup/main"
  exit 1
fi

echo "[1/7] Installing directories..."
mkdir -p ~/.vim/autoload ~/.vim/undodir

echo "[2/7] Installing vim-plug..."
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  -o ~/.vim/autoload/plug.vim

echo "[3/7] Installing .vimrc..."
curl -fsSL "${RAW_BASE}/.vimrc" -o ~/.vimrc

echo "[4/7] Checking dependencies..."
need() { command -v "$1" >/dev/null 2>&1 || echo "  - missing: $1"; }
echo "Dependencies status:"
need vim
need curl

echo "[5/7] Installing fzf binary (best effort)..."
if ! command -v fzf >/dev/null 2>&1; then
  if command -v git >/dev/null 2>&1; then
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin --no-zsh --no-fish --no-bash >/dev/null
    echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> ~/.bashrc 2>/dev/null || true
    echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> ~/.zshrc 2>/dev/null || true
  else
    echo "  git not found; skip fzf binary install."
  fi
fi

echo "[6/7] Installing ripgrep (best effort notice)..."
if ! command -v rg >/dev/null 2>&1; then
  echo "  ripgrep (rg) not found. Install it for :Rg to work."
fi

echo "[7/7] Installing Vim plugins..."
vim +'PlugInstall --sync' +qa || true

echo
echo "Done."
echo "- Open Vim and run :PlugStatus"
echo "- For autocomplete/LSP, install Node.js and then in Vim run e.g.:"
echo "    :CocInstall coc-json coc-tsserver coc-pyright"
