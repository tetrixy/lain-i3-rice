#!/usr/bin/env bash
# ============================================================================
# brightness.sh — Brightness control utility
# Usage: brightness.sh [--up|--down|--set VALUE]
# ============================================================================
set -euo pipefail

# Default step (percentage)
STEP=5

# Check if brightnessctl is installed
if ! command -v brightnessctl &>/dev/null; then
  echo "[lain-rice] ERROR: brightnessctl not found. Install: sudo pacman -S brightnessctl" >&2
  exit 1
fi

# Get current brightness
get_brightness() {
  brightnessctl get | awk '{printf "%.0f", ($1/255)*100}'
}

# Show help
show_help() {
  echo "Usage: brightness.sh [--up|--down|--set VALUE]"
  echo "  --up          Increase brightness by ${STEP}%"
  echo "  --down        Decrease brightness by ${STEP}%"
  echo "  --set VALUE   Set brightness to VALUE (0-100)"
  echo "  --get         Show current brightness"
  exit 0
}

# Parse arguments
if [[ $# -eq 0 ]]; then
  show_help
fi

case "$1" in
  --up)
    brightnessctl set +${STEP}%
    echo "[lain-rice] Brightness increased to $(get_brightness)%"
    ;;
  --down)
    brightnessctl set ${STEP}%-
    echo "[lain-rice] Brightness decreased to $(get_brightness)%"
    ;;
  --set)
    if [[ -z "${2:-}" ]]; then
      echo "[lain-rice] ERROR: --set requires a value (0-100)" >&2
      exit 1
    fi
    brightnessctl set ${2}%
    echo "[lain-rice] Brightness set to $(get_brightness)%"
    ;;
  --get)
    echo "$(get_brightness)"
    ;;
  --help|-h)
    show_help
    ;;
  *)
    echo "[lain-rice] ERROR: Unknown argument: $1" >&2
    exit 1
    ;;
esac
