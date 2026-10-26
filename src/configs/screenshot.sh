#!/usr/bin/env bash
# ============================================================================
# screenshot.sh — Screenshot utility with region selection
# Usage: screenshot.sh [--full|--region|--window] [--clipboard]
# ============================================================================
set -euo pipefail

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="screenshot_${TIMESTAMP}.png"
FILEPATH="${SCREENSHOT_DIR}/${FILENAME}"
CLIPBOARD=false
MODE="region"

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --full)
      MODE="full"
      ;;
    --region)
      MODE="region"
      ;;
    --window)
      MODE="window"
      ;;
    --clipboard)
      CLIPBOARD=true
      ;;
    --help|-h)
      echo "Usage: screenshot.sh [--full|--region|--window] [--clipboard]"
      echo "  --full       Capture entire screen"
      echo "  --region     Select region to capture (default)"
      echo "  --window     Capture focused window"
      echo "  --clipboard  Copy to clipboard instead of saving"
      exit 0
      ;;
    *)
      echo "[lain-rice] ERROR: Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

# Ensure directory exists
mkdir -p "$SCREENSHOT_DIR"

# Check if maim is installed
if ! command -v maim &>/dev/null; then
  echo "[lain-rice] ERROR: maim not found. Install: sudo pacman -S maim" >&2
  exit 1
fi

# Take screenshot based on mode
case "$MODE" in
  full)
    maim "$FILEPATH"
    ;;
  region)
    maim -s "$FILEPATH"
    ;;
  window)
    maim -i "$(xdotool getactivewindow)" "$FILEPATH"
    ;;
esac

# Handle clipboard
if $CLIPBOARD; then
  if command -v xclip &>/dev/null; then
    xclip -selection clipboard -t image/png -i "$FILEPATH"
    echo "[lain-rice] Screenshot copied to clipboard"
    echo "[lain-rice] Скриншот скопирован в буфер обмена"
    rm "$FILEPATH"
  else
    echo "[lain-rice] WARNING: xclip not found, saving to file instead" >&2
    echo "[lain-rice] Saved to: $FILEPATH"
  fi
else
  echo "[lain-rice] Screenshot saved to: $FILEPATH"
  echo "[lain-rice] Скриншот сохранён: $FILEPATH"
fi
