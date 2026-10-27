#!/usr/bin/env bash
# ============================================================================
# ending.sh — Cinematic exit from i3
# Usage: ending.sh
# ============================================================================
set -euo pipefail

# Lain color palette
GREEN='\033[0;32m'
DIM='\033[0;90m'
BLOOD='\033[0;31m'
NC='\033[0m'

# Check if running in terminal
if [[ ! -t 1 ]]; then
  echo "[lain-rice] ERROR: This script must be run in a terminal" >&2
  exit 1
fi

# Function to show disconnect dialog
show_dialog() {
  clear
  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║                                                          ║${NC}"
  echo -e "${GREEN}║        Disconnect from the Wired?                        ║${NC}"
  echo -e "${GREEN}║                                                          ║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${DIM}[Y]${NC} Yes, I'm done."
  echo -e "${DIM}[N]${NC} No, I'll stay."
  echo ""
  echo -e "${DIM}Choice: ${NC}"
}

# Show dialog and get choice
while true; do
  show_dialog
  read -rs -n1 choice
  
  case "$choice" in
    [Yy])
      # User chose to disconnect
      clear
      echo ""
      echo -e "${DIM}Disconnecting...${NC}"
      sleep 1
      
      clear
      echo ""
      echo -e "${DIM}Closing connections...${NC}"
      sleep 1
      
      clear
      echo ""
      echo -e "${DIM}Saving memories...${NC}"
      sleep 1
      
      clear
      echo ""
      echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
      echo -e "${GREEN}║                                                          ║${NC}"
      echo -e "${GREEN}║              Goodbye, Lain.                              ║${NC}"
      echo -e "${GREEN}║                                                          ║${NC}"
      echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
      echo ""
      echo -e "${DIM}See you in the Wired...${NC}"
      sleep 2
      
      # Exit i3
      i3-msg exit
      exit 0
      ;;
    [Nn])
      # User chose to stay
      clear
      echo ""
      echo -e "${DIM}Connection maintained.${NC}"
      sleep 1
      clear
      exit 0
      ;;
    *)
      # Invalid choice, show dialog again
      continue
      ;;
  esac
done
