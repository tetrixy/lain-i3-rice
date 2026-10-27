#!/usr/bin/env bash
# ============================================================================
# dissociation.sh — Temporary glitch mode (visual only, no sound)
# Usage: dissociation.sh [duration]
# ============================================================================
set -euo pipefail

# Default duration: 8 seconds
DURATION="${1:-8}"

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

# Function to generate random glitch text
glitch_text() {
  local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
  local length=$((RANDOM % 20 + 10))
  local result=""
  for ((i=0; i<length; i++)); do
    result+="${chars:RANDOM%${#chars}:1}"
  done
  echo "$result"
}

# Function to show glitch screen
show_glitch() {
  clear
  
  # Random number of lines
  local lines=$((RANDOM % 15 + 10))
  
  for ((i=0; i<lines; i++)); do
    # Random color
    local colors=("$GREEN" "$DIM" "$BLOOD")
    local color="${colors[RANDOM%${#colors[@]}]}"
    
    # Print glitch text
    echo -e "${color}$(glitch_text)${NC}"
  done
  
  # Sometimes show a message
  if ((RANDOM % 3 == 0)); then
    local messages=("WHERE AM I?" "WHO ARE YOU?" "DISCONNECTED" "ERROR 404" "LAYER 7" "PROTOCOL FAILURE")
    local msg="${messages[RANDOM%${#messages[@]}]}"
    echo ""
    echo -e "${BLOOD}>>> $msg <<<${NC}"
  fi
}

# Main loop
start_time=$(date +%s)
end_time=$((start_time + DURATION))

while [[ $(date +%s) -lt $end_time ]]; do
  show_glitch
  sleep 0.3
done

# Clear screen at the end
clear
echo -e "${DIM}Connection restored.${NC}"
sleep 1
clear
