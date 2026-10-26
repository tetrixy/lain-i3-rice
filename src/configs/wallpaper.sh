#!/usr/bin/env bash
# ============================================================================
# wallpaper.sh — Download and set Lain wallpaper
# Usage: wallpaper.sh [--download]
# ============================================================================
set -euo pipefail

WALLPAPER_URL="https://rare-gallery.com/thumbs/1119968-anime-blue-Serial-Experiments-Lain-Lain-Iwakura-color-darkness-image-snapshot-screenshot.png"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
WALLPAPER_PATH="$WALLPAPER_DIR/lain.png"

# Ensure directory exists
mkdir -p "$WALLPAPER_DIR"

# Download if requested or if file doesn't exist
if [[ "${1:-}" == "--download" ]] || [[ ! -f "$WALLPAPER_PATH" ]]; then
  echo "[lain-rice] Downloading wallpaper..."
  echo "[lain-rice] Загрузка обоев..."
  curl -L -o "$WALLPAPER_PATH" "$WALLPAPER_URL"
  if [[ $? -ne 0 ]]; then
    echo "[lain-rice] ERROR: Failed to download wallpaper" >&2
    echo "[lain-rice] ОШИБКА: Не удалось загрузить обои" >&2
    exit 1
  fi
  echo "[lain-rice] Wallpaper downloaded to: $WALLPAPER_PATH"
fi

# Set wallpaper
if command -v feh &>/dev/null; then
  feh --bg-fill "$WALLPAPER_PATH"
  echo "[lain-rice] Wallpaper set successfully."
  echo "[lain-rice] Обои установлены."
else
  echo "[lain-rice] ERROR: feh not found. Install with: sudo pacman -S feh" >&2
  echo "[lain-rice] ОШИБКА: feh не найден. Установите: sudo pacman -S feh" >&2
  exit 1
fi
