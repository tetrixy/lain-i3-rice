#!/usr/bin/env bash
# ============================================================================
# quotes.sh — Show random quotes from Serial Experiments Lain
# Usage: quotes.sh [--notify|--terminal]
# ============================================================================
set -euo pipefail

# Lain color palette
GREEN='\033[0;32m'
DIM='\033[0;90m'
NC='\033[0m'

# Quotes from Serial Experiments Lain
quotes=(
  "No matter where you go, everyone's connected."
  "If you aren't remembered, you don't exist."
  "Let's all love Lain."
  "I don't need to stay in a place like this."
  "Close your eyes and unfold your wings."
  "The Wired is an upper layer of the real world."
  "There's no boundary between the real world and the Wired."
  "Everyone has their own reality."
  "The real world is just a reflection of the Wired."
  "I am Lain. I am you."
  "Who are you? Who have you always been?"
  "The boundary between the real world and the Wired is not that distinct."
  "You don't need to be afraid. You're connected to everyone."
  "If you aren't remembered, you don't exist."
  "I don't understand. I don't understand at all."
  "The Wired is a layer of human communication."
  "Even in the real world, you're connected to everyone."
  "I want to be loved. I want to be remembered."
  "The body is just a terminal."
  "Reality is just a perception."
  "You can't escape from the Wired."
  "The Wired is an extension of the real world."
  "Everyone has a shadow. Even in the Wired."
  "I am not who you think I am."
  "The connection is everything."
)

# Function to show quote in terminal
show_terminal() {
  local quote="${quotes[RANDOM%${#quotes[@]}]}"
  
  clear
  echo ""
  echo -e "${DIM}╔══════════════════════════════════════════════════════════╗${NC}"
  echo -e "${DIM}║${NC}"
  echo -e "${DIM}║${NC}  ${GREEN}${quote}${NC}"
  echo -e "${DIM}║${NC}"
  echo -e "${DIM}╚══════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${DIM}Press any key to continue...${NC}"
  read -rs -n1
  clear
}

# Function to show quote as notification
show_notify() {
  local quote="${quotes[RANDOM%${#quotes[@]}]}"
  
  if command -v notify-send &>/dev/null; then
    notify-send "Signal from the Wired" "$quote" -t 10000
  else
    echo "[lain-rice] WARNING: notify-send not found, showing in terminal instead" >&2
    show_terminal
  fi
}

# Parse arguments
mode="${1:---terminal}"

case "$mode" in
  --notify|-n)
    show_notify
    ;;
  --terminal|-t)
    show_terminal
    ;;
  --help|-h)
    echo "Usage: quotes.sh [--notify|--terminal]"
    echo "  --notify, -n    Show as desktop notification"
    echo "  --terminal, -t  Show in terminal (default)"
    exit 0
    ;;
  *)
    echo "[lain-rice] ERROR: Unknown argument: $mode" >&2
    exit 1
    ;;
esac
