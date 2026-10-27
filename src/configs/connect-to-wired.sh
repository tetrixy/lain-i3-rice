#!/usr/bin/env bash
# ============================================================================
# connect-to-wired.sh — Ritual of connecting to the Wired
# Usage: connect-to-wired.sh
# ============================================================================
set -euo pipefail

# Lain color palette
GREEN='\033[0;32m'
DIM='\033[0;90m'
NC='\033[0m'

# Terminal animation speed (seconds)
SPEED=0.8

# Function to print with delay
slow_print() {
  local text="$1"
  local delay="${2:-$SPEED}"
  echo -e "${GREEN}${text}${NC}"
  sleep "$delay"
}

# Function to print dim text
dim_print() {
  local text="$1"
  echo -e "${DIM}${text}${NC}"
}

# Check if running in terminal
if [[ ! -t 1 ]]; then
  echo "[lain-rice] ERROR: This script must be run in a terminal" >&2
  exit 1
fi

# Clear screen
clear

# Start connection ritual
slow_print "╔══════════════════════════════════════════════════════════╗" 0.1
slow_print "║                                                          ║" 0.1
slow_print "║              CONNECTING TO THE WIRED                     ║" 0.1
slow_print "║                                                          ║" 0.1
slow_print "╚══════════════════════════════════════════════════════════╝" 0.5

echo ""
slow_print "Layer 01: Initializing protocol..." 0.8
dim_print "  > Establishing connection to localhost:6600"
sleep 0.5

echo ""
slow_print "Layer 02: Loading consciousness..." 0.8
dim_print "  > Memory allocation: OK"
dim_print "  > Identity verification: PENDING"
sleep 0.5

echo ""
slow_print "Layer 03: Syncing with network..." 0.8
dim_print "  > Signal strength: ██████████ 100%"
dim_print "  > Latency: 0ms"
sleep 0.5

echo ""
slow_print "Layer 04: You are now connected." 1.0

echo ""
slow_print "╔══════════════════════════════════════════════════════════╗" 0.1
slow_print "║                                                          ║" 0.1
slow_print "║   \"No matter where you go, everyone's connected.\"        ║" 0.1
slow_print "║                                                          ║" 0.1
slow_print "╚══════════════════════════════════════════════════════════╝" 0.5

echo ""
dim_print "Press any key to enter the Wired..."
read -rs -n1

# Clear and exit
clear
