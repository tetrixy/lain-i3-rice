#!/usr/bin/env bash
# ============================================================================
# setup-theme.sh — Apply Lain theme to GTK, Xresources, cursor
# Usage: setup-theme.sh [--all|--gtk|--xresources|--cursor]
# ============================================================================
set -euo pipefail

info() { echo "[lain-rice] $*"; }
error() { echo "[lain-rice] ERROR: $*" >&2; exit 1; }

apply_xresources() {
  info "Applying Xresources..."
  if command -v xrdb &>/dev/null; then
    xrdb -merge ~/.Xresources
    info "Xresources applied"
  else
    error "xrdb not found. Install: sudo pacman -S xorg-xrdb"
  fi
}

apply_gtk() {
  info "Applying GTK theme..."

  # GTK 3.0
  mkdir -p ~/.config/gtk-3.0
  if [[ -f ~/.config/gtk-3.0/settings.ini ]]; then
    info "GTK 3.0 settings already exist"
  else
    error "~/.config/gtk-3.0/settings.ini not found. Run install.sh first."
  fi

  # GTK 4.0 (same settings)
  mkdir -p ~/.config/gtk-4.0
  cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini 2>/dev/null || true

  info "GTK theme applied: Arc-Dark + Papirus-Dark"
}

apply_cursor() {
  info "Applying cursor theme..."

  # Create ~/.icons/default if not exists
  mkdir -p ~/.icons/default

  # Create index.theme for cursor
  cat > ~/.icons/default/index.theme << 'EOF'
[Icon Theme]
Inherits=Bibata-Modern-Classic
EOF

  info "Cursor theme applied: Bibata-Modern-Classic"
}

apply_all() {
  apply_xresources
  apply_gtk
  apply_cursor
  info "All themes applied successfully!"
  info "Все темы применены успешно!"
}

# Parse arguments
if [[ $# -eq 0 ]]; then
  apply_all
  exit 0
fi

case "$1" in
  --all)
    apply_all
    ;;
  --gtk)
    apply_gtk
    ;;
  --xresources)
    apply_xresources
    ;;
  --cursor)
    apply_cursor
    ;;
  --help|-h)
    echo "Usage: setup-theme.sh [--all|--gtk|--xresources|--cursor]"
    echo "  --all          Apply all themes (default)"
    echo "  --gtk          Apply GTK theme only"
    echo "  --xresources   Apply Xresources only"
    echo "  --cursor       Apply cursor theme only"
    exit 0
    ;;
  *)
    error "Unknown argument: $1"
    ;;
esac
