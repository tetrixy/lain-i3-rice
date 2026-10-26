#!/usr/bin/env bash
# ============================================================================
# lock.sh — Screen locker with Lain theme
# Requires: i3lock-color (AUR)
# ============================================================================
set -euo pipefail

# Lain color palette
BG="0d0f14"        # Deep blue-gray
RING="4a7c59"      # Dim green
RING_VER="39ff14"  # Signal green
TEXT="b8c0cc"      # Foreground
WRONG="6b2d3c"     # Blood red
LAYOUT="6b7280"    # Dim text

# Check if i3lock is available
if ! command -v i3lock &>/dev/null; then
  echo "[lain-rice] ERROR: i3lock not found." >&2
  echo "[lain-rice] Install: sudo pacman -S i3lock" >&2
  echo "[lain-rice] For themed version (AUR): yay -S i3lock-color" >&2
  echo "[lain-rice] ОШИБКА: i3lock не найден." >&2
  exit 1
fi

# Lock screen with Lain colors
# Source: i3lock-color man page for option syntax
i3lock \
  --color="$BG" \
  --insidever-color="$BG" \
  --ringver-color="$RING_VER" \
  --inside-color="$BG" \
  --ring-color="$RING" \
  --line-color="$BG" \
  --separator-color="$RING" \
  --keyhl-color="$RING_VER" \
  --bshl-color="$WRONG" \
  --verif-color="$TEXT" \
  --wrong-color="$WRONG" \
  --layout-color="$LAYOUT" \
  --time-color="$TEXT" \
  --date-color="$LAYOUT" \
  --time-str="%H:%M:%S" \
  --date-str="%a %d.%m.%Y" \
  --time-font="JetBrains Mono" \
  --date-font="JetBrains Mono" \
  --font="JetBrains Mono" \
  --radius=80 \
  --ring-width=8 \
  --pointer=default \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-power-keys \
  --pass-volume-keys \
  --nofork

echo "[lain-rice] Screen locked. / Экран заблокирован."
