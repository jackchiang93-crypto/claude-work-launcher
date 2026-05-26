#!/bin/bash
# Launch Claude.app as a second instance with isolated user data.
# Forces native arm64 to avoid Rosetta translation overhead on Apple Silicon.

CLAUDE_BIN="/Applications/Claude.app/Contents/MacOS/Claude"
DATA_DIR="$HOME/Library/Application Support/ClaudeWork"

if [ ! -x "$CLAUDE_BIN" ]; then
  osascript -e 'display dialog "Claude.app not found at /Applications/Claude.app\n\nInstall Claude Desktop first from https://claude.ai/download" buttons {"OK"} default button 1 with icon stop'
  exit 1
fi

mkdir -p "$DATA_DIR"

# arch -arm64 forces native execution; without it macOS may launch via Rosetta
# and the main process pegs CPU.
if [ "$(uname -m)" = "arm64" ]; then
  exec arch -arm64 "$CLAUDE_BIN" --user-data-dir="$DATA_DIR" "$@"
else
  exec "$CLAUDE_BIN" --user-data-dir="$DATA_DIR" "$@"
fi
