#!/usr/bin/env bash
# ============================================================================
# mpd-control.sh — MPD control utility
# Usage: mpd-control.sh [--play|--pause|--toggle|--stop|--next|--prev|--status]
# ============================================================================
set -euo pipefail

# Check if mpc is installed
if ! command -v mpc &>/dev/null; then
  echo "[lain-rice] ERROR: mpc not found. Install: sudo pacman -S mpc" >&2
  echo "[lain-rice] ОШИБКА: mpc не найден. Установите: sudo pacman -S mpc" >&2
  exit 1
fi

# Show help
show_help() {
  echo "Usage: mpd-control.sh [--play|--pause|--toggle|--stop|--next|--prev|--status]"
  echo "  --play      Start playback"
  echo "  --pause     Pause playback"
  echo "  --toggle    Toggle play/pause"
  echo "  --stop      Stop playback"
  echo "  --next      Next track"
  echo "  --prev      Previous track"
  echo "  --status    Show current status"
  echo "  --random    Toggle random mode"
  echo "  --repeat    Toggle repeat mode"
  exit 0
}

# Parse arguments
if [[ $# -eq 0 ]]; then
  show_help
fi

case "$1" in
  --play)
    mpc play
    echo "[lain-rice] Playing"
    ;;
  --pause)
    mpc pause
    echo "[lain-rice] Paused"
    ;;
  --toggle)
    mpc toggle
    # Check current state
    if mpc | grep -q "\[playing\]"; then
      echo "[lain-rice] Playing"
    else
      echo "[lain-rice] Paused"
    fi
    ;;
  --stop)
    mpc stop
    echo "[lain-rice] Stopped"
    ;;
  --next)
    mpc next
    echo "[lain-rice] Next track"
    ;;
  --prev)
    mpc prev
    echo "[lain-rice] Previous track"
    ;;
  --status)
    mpc status
    ;;
  --random)
    mpc random
    echo "[lain-rice] Random mode toggled"
    ;;
  --repeat)
    mpc repeat
    echo "[lain-rice] Repeat mode toggled"
    ;;
  --help|-h)
    show_help
    ;;
  *)
    echo "[lain-rice] ERROR: Unknown argument: $1" >&2
    exit 1
    ;;
esac
