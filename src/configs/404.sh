#!/usr/bin/env bash
# ============================================================================
# 404.sh — Show "not found" message in Lain style
# Usage: 404.sh [application_name]
# ============================================================================
set -euo pipefail

# Lain color palette
GREEN='\033[0;32m'
DIM='\033[0;90m'
BLOOD='\033[0;31m'
NC='\033[0m'

# Application name (or "unknown")
app_name="${1:-unknown}"

# Check if running in terminal
if [[ ! -t 1 ]]; then
  echo "[lain-rice] ERROR: This script must be run in a terminal" >&2
  exit 1
fi

# Clear screen
clear

# Show 404 message
echo ""
echo -e "${BLOOD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLOOD}║                                                          ║${NC}"
echo -e "${BLOOD}║                    ERROR 404                             ║${NC}"
echo -e "${BLOOD}║                                                          ║${NC}"
echo -e "${BLOOD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${DIM}Application not found in the Wired:${NC}"
echo -e "${GREEN}  > ${app_name}${NC}"
echo ""
echo -e "${DIM}Perhaps it never existed.${NC}"
echo -e "${DIM}Or perhaps you don't remember it.${NC}"
echo ""
echo -e "${DIM}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${DIM}║                                                          ║${NC}"
echo -e "${DIM}║   \"If you aren't remembered, you don't exist.\"           ║${NC}"
echo -e "${DIM}║                                                          ║${NC}"
echo -e "${DIM}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${DIM}Press any key to return...${NC}"
read -rs -n1

# Clear and exit
clear
