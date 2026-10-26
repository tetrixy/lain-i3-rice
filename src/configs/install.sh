#!/usr/bin/env bash
# ============================================================================
# lain-i3-rice installer
# Idempotent installation script for Serial Experiments Lain i3wm rice.
# Source: Arch Wiki (https://wiki.archlinux.org/title/I3), i3wm.org/docs
# ============================================================================
set -euo pipefail

# --- Configuration ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$DOTFILES_DIR/config"
SCRIPTS_SRC="$DOTFILES_DIR/scripts"
WALLPAPER_URL="https://rare-gallery.com/thumbs/1119968-anime-blue-Serial-Experiments-Lain-Lain-Iwakura-color-darkness-image-snapshot-screenshot.png"
DRY_RUN=false
BACKUP_SUFFIX=".bak.$(date +%s)"

# --- Color output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[lain-rice]${NC} $*"; }
warn()  { echo -e "${YELLOW}[lain-rice]${NC} $*"; }
error() { echo -e "${RED}[lain-rice]${NC} $*" >&2; }

# --- Parse arguments ---
for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      info "Dry-run mode enabled. No changes will be made."
      ;;
    --help|-h)
      echo "Usage: ./install.sh [--dry-run]"
      echo "  --dry-run  Show what would be done without making changes"
      exit 0
      ;;
    *)
      error "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

# --- Refuse root ---
if [[ $EUID -eq 0 ]]; then
  error "Do not run this script as root. Run as a regular user."
  error "Запускать от имени обычного пользователя, не root."
  exit 1
fi

# --- Helper: run or dry-run ---
run_cmd() {
  if $DRY_RUN; then
    info "[dry-run] $*"
  else
    "$@"
  fi
}

# --- Helper: install package if not present ---
install_pkg() {
  local pkg="$1"
  if pacman -Q "$pkg" &>/dev/null; then
    info "Package '$pkg' already installed — skipping."
  else
    info "Installing package: $pkg"
    run_cmd sudo pacman -S --noconfirm --needed "$pkg"
  fi
}

# --- Helper: install AUR package if not present (requires yay or paru) ---
install_aur_pkg() {
  local pkg="$1"
  if pacman -Q "$pkg" &>/dev/null; then
    info "AUR package '$pkg' already installed — skipping."
    return
  fi

  local aur_helper=""
  if command -v yay &>/dev/null; then
    aur_helper="yay"
  elif command -v paru &>/dev/null; then
    aur_helper="paru"
  else
    error "AUR helper not found. Install yay or paru first:"
    error "  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    error "  Или: git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si"
    exit 1
  fi

  info "Installing AUR package via $aur_helper: $pkg"
  run_cmd "$aur_helper" -S --noconfirm "$pkg"
}

# --- Helper: deploy config file idempotently ---
deploy_config() {
  local src="$1"
  local dest="$2"
  local dest_dir
  dest_dir="$(dirname "$dest")"

  # Create destination directory
  if [[ ! -d "$dest_dir" ]]; then
    info "Creating directory: $dest_dir"
    run_cmd mkdir -p "$dest_dir"
  fi

  # Check if destination already matches source
  if [[ -f "$dest" ]] && diff -q "$src" "$dest" &>/dev/null; then
    info "Config already up-to-date: $dest"
    return
  fi

  # Backup existing file if it differs
  if [[ -f "$dest" ]]; then
    warn "Config differs — backing up: $dest -> ${dest}${BACKUP_SUFFIX}"
    run_cmd cp "$dest" "${dest}${BACKUP_SUFFIX}"
  fi

  # Copy new config
  info "Deploying config: $dest"
  run_cmd cp "$src" "$dest"
}

# --- Helper: create symlink idempotently ---
deploy_symlink() {
  local target="$1"
  local link="$2"
  local link_dir
  link_dir="$(dirname "$link")"

  if [[ ! -d "$link_dir" ]]; then
    run_cmd mkdir -p "$link_dir"
  fi

  # Check if symlink already points to correct target
  if [[ -L "$link" ]] && [[ "$(readlink -f "$link")" == "$(readlink -f "$target")" ]]; then
    info "Symlink already correct: $link -> $target"
    return
  fi

  # Backup if regular file exists
  if [[ -f "$link" ]] && [[ ! -L "$link" ]]; then
    warn "Regular file exists at $link — backing up"
    run_cmd cp "$link" "${link}${BACKUP_SUFFIX}"
  fi

  info "Creating symlink: $link -> $target"
  run_cmd ln -sfn "$target" "$link"
}

# ============================================================================
# MAIN INSTALLATION
# ============================================================================

info "=========================================="
info "  lain-i3-rice installer"
info "  Serial Experiments Lain — i3wm rice"
info "=========================================="
echo ""

# --- Step 1: Install packages from packages.txt ---
info "Step 1: Installing packages..."
while IFS= read -r line || [[ -n "$line" ]]; do
  # Skip comments and empty lines
  line="$(echo "$line" | sed 's/#.*//' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  [[ -z "$line" ]] && continue

  install_pkg "$line"
done < "$DOTFILES_DIR/packages.txt"

# Install AUR packages
# Handle conflicts: picom-git conflicts with picom
if pacman -Q picom &>/dev/null; then
  warn "Removing conflicting package: picom (replacing with picom-git)"
  run_cmd sudo pacman -R --noconfirm picom
fi
install_aur_pkg "picom-git"

# Handle conflicts: i3lock-color conflicts with i3lock
if pacman -Q i3lock &>/dev/null; then
  warn "Removing conflicting package: i3lock (replacing with i3lock-color)"
  run_cmd sudo pacman -R --noconfirm i3lock
fi
install_aur_pkg "i3lock-color"

# Install ttf-iosevka from AUR
install_aur_pkg "ttf-iosevka"

# --- Step 2: Deploy configuration files ---
info "Step 2: Deploying configuration files..."

# i3 config
deploy_config "$CONFIG_SRC/i3/config" "$HOME/.config/i3/config"

# Polybar config
deploy_config "$CONFIG_SRC/polybar/config.ini" "$HOME/.config/polybar/config.ini"

# Picom config
deploy_config "$CONFIG_SRC/picom/picom.conf" "$HOME/.config/picom/picom.conf"

# Rofi config
deploy_config "$CONFIG_SRC/rofi/lain.rasi" "$HOME/.config/rofi/lain.rasi"

# Alacritty config
deploy_config "$CONFIG_SRC/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

# Dunst config
deploy_config "$CONFIG_SRC/dunstrc" "$HOME/.config/dunst/dunstrc"

# MPD config
deploy_config "$CONFIG_SRC/mpd.conf" "$HOME/.config/mpd/mpd.conf"

# ncmpcpp config
deploy_config "$CONFIG_SRC/ncmpcpp.conf" "$HOME/.config/ncmpcpp/config"

# --- Step 3: Deploy scripts ---
info "Step 3: Deploying scripts..."
deploy_config "$SCRIPTS_SRC/wallpaper.sh" "$HOME/.local/bin/wallpaper.sh"
deploy_config "$SCRIPTS_SRC/lock.sh" "$HOME/.local/bin/lock.sh"
deploy_config "$SCRIPTS_SRC/screenshot.sh" "$HOME/.local/bin/screenshot.sh"
deploy_config "$SCRIPTS_SRC/brightness.sh" "$HOME/.local/bin/brightness.sh"
deploy_config "$SCRIPTS_SRC/mpd-control.sh" "$HOME/.local/bin/mpd-control.sh"

if ! $DRY_RUN; then
  chmod +x "$HOME/.local/bin/wallpaper.sh"
  chmod +x "$HOME/.local/bin/lock.sh"
  chmod +x "$HOME/.local/bin/screenshot.sh"
  chmod +x "$HOME/.local/bin/brightness.sh"
  chmod +x "$HOME/.local/bin/mpd-control.sh"
fi

# --- Step 4: Download wallpaper ---
info "Step 4: Setting up wallpaper..."
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
WALLPAPER_PATH="$WALLPAPER_DIR/lain.png"

if [[ ! -d "$WALLPAPER_DIR" ]]; then
  run_cmd mkdir -p "$WALLPAPER_DIR"
fi

if [[ -f "$WALLPAPER_PATH" ]]; then
  info "Wallpaper already exists: $WALLPAPER_PATH"
else
  info "Downloading wallpaper..."
  run_cmd curl -L -o "$WALLPAPER_PATH" "$WALLPAPER_URL"
fi

# --- Step 5: Create MPD directories ---
info "Step 5: Creating MPD directories..."
MPD_DIRS=(
  "$HOME/.config/mpd/playlists"
  "$HOME/Music"
)

for dir in "${MPD_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    info "Creating directory: $dir"
    run_cmd mkdir -p "$dir"
  fi
done

# --- Step 6: Enable services ---
info "Step 6: Enabling services..."
# picom, polybar, and mpd are started via i3 exec/exec_always (see i3/config)
# No systemd services needed for i3 rice

info ""
info "=========================================="
info "  Installation complete!"
info "  Установка завершена!"
info "=========================================="
info ""
info "Next steps / Следующие шаги:"
info "  1. Log out of your current session"
info "  2. Start i3 from your display manager or ~/.xinitrc"
info "  3. Press Mod+Enter to open a terminal"
info ""
info "If something went wrong, see README.md"
