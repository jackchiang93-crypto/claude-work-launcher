#!/bin/bash
# uninstall.sh — remove Claude Work.app and (optionally) its data
set -e

APP_NAME="${APP_NAME:-Claude Work}"
APP_PATH="$HOME/Applications/$APP_NAME.app"
DATA_DIR="$HOME/Library/Application Support/ClaudeWork"

# Quit running instance
pkill -f "user-data-dir=.*ClaudeWork" 2>/dev/null || true
sleep 1

if [ -d "$APP_PATH" ]; then
  rm -rf "$APP_PATH"
  echo "✅ Removed $APP_PATH"
else
  echo "ℹ️  $APP_PATH not found, skipping"
fi

if [ -d "$DATA_DIR" ]; then
  echo ""
  echo "⚠️  Also delete the second account's data (cookies, settings, history)?"
  echo "    $DATA_DIR"
  echo "    [y/N]"
  read -r ans
  if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
    rm -rf "$DATA_DIR"
    echo "✅ Removed $DATA_DIR"
  else
    echo "ℹ️  Keeping $DATA_DIR — you can reuse it if you reinstall"
  fi
fi

echo ""
echo "Done. The original /Applications/Claude.app was not touched."
