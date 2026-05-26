#!/bin/bash
# install.sh — build & install Claude Work.app into ~/Applications
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="${APP_NAME:-Claude Work}"
APP_PATH="$HOME/Applications/$APP_NAME.app"
CLAUDE_SRC="/Applications/Claude.app"

# --- preflight ---
if [ ! -d "$CLAUDE_SRC" ]; then
  echo "❌ Claude.app not found at $CLAUDE_SRC"
  echo "   Install Claude Desktop first: https://claude.ai/download"
  exit 1
fi

if [ -e "$APP_PATH" ]; then
  echo "⚠️  $APP_PATH already exists. Remove? [y/N]"
  read -r ans
  [ "$ans" = "y" ] || [ "$ans" = "Y" ] || { echo "Aborted."; exit 1; }
  rm -rf "$APP_PATH"
fi

mkdir -p "$HOME/Applications"

# --- build bundle ---
echo "→ Building $APP_PATH"
mkdir -p "$APP_PATH/Contents/MacOS" "$APP_PATH/Contents/Resources"

# Launcher script
cp "$SCRIPT_DIR/src/launcher.sh" "$APP_PATH/Contents/MacOS/ClaudeWork"
chmod +x "$APP_PATH/Contents/MacOS/ClaudeWork"

# Info.plist
cp "$SCRIPT_DIR/src/Info.plist" "$APP_PATH/Contents/Info.plist"

# Icon — reuse Claude's official icon
if [ -f "$CLAUDE_SRC/Contents/Resources/app.icns" ]; then
  cp "$CLAUDE_SRC/Contents/Resources/app.icns" "$APP_PATH/Contents/Resources/app.icns"
elif [ -f "$CLAUDE_SRC/Contents/Resources/electron.icns" ]; then
  cp "$CLAUDE_SRC/Contents/Resources/electron.icns" "$APP_PATH/Contents/Resources/app.icns"
fi

# Ad-hoc sign so macOS will launch it
codesign --force --sign - "$APP_PATH" >/dev/null 2>&1 || true

# Refresh Finder/Dock icon cache
touch "$APP_PATH"

echo ""
echo "✅ Installed: $APP_PATH"
echo ""
echo "Next steps:"
echo "  1. Open Spotlight (Cmd+Space) and type 'Claude Work'"
echo "  2. Sign in with your second Claude account"
echo "  3. First launch takes ~40s to warm caches (one-time)"
echo "  4. Right-click the Dock icon → Options → Keep in Dock (optional)"
echo ""
echo "Data location: ~/Library/Application Support/ClaudeWork"
echo "Uninstall:     ./uninstall.sh"
