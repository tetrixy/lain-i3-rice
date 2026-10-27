#!/usr/bin/env bash
# ============================================================================
# lain-i3-rice — Quick start script
# This script launches the actual installer from src/configs/
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="$SCRIPT_DIR/src/configs/install.sh"

if [[ ! -f "$INSTALLER" ]]; then
  echo "[lain-rice] ERROR: Installer not found at $INSTALLER" >&2
  echo "[lain-rice] Please ensure the repository is complete." >&2
  exit 1
fi

# Make installer executable
chmod +x "$INSTALLER"

# Run installer
exec "$INSTALLER" "$@"
