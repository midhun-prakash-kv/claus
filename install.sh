#!/usr/bin/env bash
# One-liner: curl -fsSL https://raw.githubusercontent.com/YOURNAME/claus/main/install.sh | bash
# Dev mode:  ./install.sh --dev   (symlinks local source so changes are live instantly)

set -e

REPO="YOURNAME/claus"
INSTALL_DIR="${CLAUS_INSTALL_DIR:-$HOME/.local/bin}"
RAW="https://raw.githubusercontent.com/$REPO/main/claus"
DEV=false

for arg in "$@"; do
  [[ "$arg" == "--dev" ]] && DEV=true
done

mkdir -p "$INSTALL_DIR"

if $DEV; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  SOURCE="$SCRIPT_DIR/claus"
  if [[ ! -f "$SOURCE" ]]; then
    echo "Error: $SOURCE not found. Run --dev from the repo root." >&2
    exit 1
  fi
  ln -sf "$SOURCE" "$INSTALL_DIR/claus"
  echo "✓ claus (dev) → $INSTALL_DIR/claus symlinked to $SOURCE"
  echo "  Changes to $SOURCE are live immediately."
else
  echo "Installing claus..."
  curl -fsSL "$RAW" -o "$INSTALL_DIR/claus"
  chmod +x "$INSTALL_DIR/claus"
  echo "✓ claus installed → $INSTALL_DIR/claus"
fi

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "⚠  $INSTALL_DIR is not in your PATH."
  echo "   Add this to your shell profile (~/.zshrc or ~/.bashrc):"
  echo ""
  echo '   export PATH="$HOME/.local/bin:$PATH"'
  echo ""
fi

echo "  Run: claus"
