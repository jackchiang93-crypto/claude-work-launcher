# Claude Work — Run a Second Claude Desktop Account on macOS

A 7 KB wrapper `.app` that lets you run **two Claude Desktop instances side-by-side** with independent accounts, sessions, and rate limits. No Electron repackaging, no patches to the official Claude.app.

> Works with the official [Claude Desktop](https://claude.ai/download) for macOS. Full feature parity — cowork, computer use, file system access, MCP servers — because under the hood it *is* the official Claude binary, just launched with an isolated user-data directory.

繁體中文說明請見下方 [中文](#中文).

---

## How it works

```
~/Applications/Claude Work.app           ← 7 KB wrapper (this project)
  └─ Contents/MacOS/ClaudeWork           ← shell script that execs:
                                            arch -arm64 Claude.app/.../Claude \
                                              --user-data-dir=~/.../ClaudeWork

/Applications/Claude.app                 ← official, untouched (669 MB)
~/Library/Application Support/Claude      ← account #1 data
~/Library/Application Support/ClaudeWork  ← account #2 data
```

Electron's `requestSingleInstanceLock()` is keyed on the `--user-data-dir`. Different data dirs → different locks → two instances coexist peacefully.

The `arch -arm64` is critical on Apple Silicon: without it the wrapper may launch the universal binary under Rosetta translation, which pegs CPU at ~100%.

## Requirements

- macOS 11+ (tested on macOS 26.3)
- Apple Silicon or Intel (Apple Silicon recommended)
- [Claude Desktop](https://claude.ai/download) already installed at `/Applications/Claude.app`

## Install

```bash
git clone https://github.com/jackchiang93-crypto/claude-work-launcher.git
cd claude-work-launcher
chmod +x install.sh uninstall.sh
./install.sh
```

That's it. The installer:
1. Creates `~/Applications/Claude Work.app`
2. Copies Claude's official icon into it
3. Ad-hoc signs it so macOS will launch it

## Usage

1. **Open Spotlight** (`⌘Space`) and type `Claude Work`, hit Return.
2. **Sign in** with your second Claude account.
3. **First launch takes ~40 seconds** — it's building caches in the new data dir. Subsequent launches are normal (5-10 s).
4. (Optional) Right-click the Dock icon → **Options → Keep in Dock**.

Both Claudes now run independently — `⌘Tab` switches between them, each has its own conversations, projects, and rate limit.

## Uninstall

```bash
./uninstall.sh
```

The script removes the wrapper `.app`. It will *ask* before deleting `~/Library/Application Support/ClaudeWork` (your second account's local data), so you can reinstall later without re-logging-in.

The original `/Applications/Claude.app` is never touched by this project.

## Troubleshooting

**"Claude Work hangs at 100% CPU"**
You're not on the latest version of this wrapper. The `arch -arm64` flag in `src/launcher.sh` fixes a Rosetta-translation issue. Re-run `./install.sh`.

**"Google sign-in says 'browser may be unsafe'"**
This wrapper uses the official Claude binary, so this shouldn't happen. If it does, sign in with email/password instead, or check that you're actually launching `Claude Work.app` and not some other tool.

**"Two icons look identical, I can't tell them apart"**
Both use Claude's official icon. To differentiate, you can swap `~/Applications/Claude Work.app/Contents/Resources/app.icns` with a tinted version (e.g. via [Image2Icon](https://img2icnsapp.com/)). Then run `touch "~/Applications/Claude Work.app"` and restart the Dock (`killall Dock`).

**"Claude.app auto-updated and Claude Work broke"**
Auto-updates can change paths inside Claude.app. Re-run `./install.sh` to refresh the wrapper.

**"Three or more accounts?"**
Duplicate the project, change `APP_NAME` and the data dir path in `src/launcher.sh`, run `APP_NAME="Claude Personal" ./install.sh` etc. Each needs its own `--user-data-dir`.

## Why not just use Chrome PWA?

Chrome PWAs for `claude.ai` work fine for chat, but lose desktop-only features:
- Cowork (file system access)
- Computer use
- MCP server integration
- Native file picker / drag-drop

This wrapper keeps all of that because it *is* the official desktop app.

## Why not Nativefier / Electron repack?

- Nativefier ships ancient Electron versions that crash on recent macOS
- Google blocks OAuth from non-Chromium-fingerprinted browsers (including Nativefier)
- Repacking with newer Electron loses Anthropic's app code anyway

Wrapping the official app is the only approach that gives you the real Claude Desktop experience with isolated accounts.

## License

MIT. Do whatever.

---

## 中文

讓你在 macOS 上同時跑**兩個 Claude Desktop**，各自登入不同帳號，rate limit 獨立。完整 Desktop 功能（cowork、computer use、檔案存取、MCP）一個都不少——因為底層就是官方 Claude 二進制，只是換了個 user-data 資料夾。

### 原理

Electron 的 single-instance lock 是綁在 `--user-data-dir` 上，不同資料夾就各自有鎖，兩個 instance 可以共存。`arch -arm64` 強制原生執行，避免 Apple Silicon 上跑成 Rosetta（會吃滿 CPU）。

### 安裝

```bash
git clone https://github.com/jackchiang93-crypto/claude-work-launcher.git
cd claude-work-launcher
chmod +x install.sh uninstall.sh
./install.sh
```

需先安裝官方 [Claude Desktop](https://claude.ai/download)。

### 使用

1. Spotlight 打 `Claude Work` → Enter
2. 用第二個帳號登入
3. **第一次啟動約 40 秒**（建快取），之後就快
4. 想釘到 Dock：右鍵 Dock icon → 選項 → 保留在 Dock

兩個 Claude 完全獨立，`⌘Tab` 切換。

### 移除

```bash
./uninstall.sh
```

會問你要不要保留第二帳號的本地資料。原版 `/Applications/Claude.app` 完全不會動。
