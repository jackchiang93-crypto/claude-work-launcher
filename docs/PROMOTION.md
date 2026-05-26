# Promotion drafts

Pick one or two channels. Avoid cross-posting the same text everywhere on the same day — looks spammy.

---

## Hacker News

**Title** (under 80 chars, no hype, just describes what it is):

```
Show HN: Claude Work – Run two Claude Desktop accounts on macOS
```

**URL field**: `https://github.com/jackchiang93-crypto/claude-work-launcher`

**Comment to post immediately as the OP** (HN guidelines: leave a first-comment context):

```
Author here. I had a personal Claude account and a work account, and wanted
to run both Desktop apps at the same time on macOS — same way you might run
two Slack workspaces. The official app uses Electron's single-instance lock
keyed on the user-data directory, so two instances with different
--user-data-dir flags coexist fine. The annoying part was that a naive
wrapper launches the universal binary under Rosetta and pegs CPU at ~100%;
forcing `arch -arm64` fixes it.

The whole thing is a 7KB .app: a shell script that execs the official
Claude binary with a separate data dir, plus an Info.plist. No Electron
repack, no patching the official app, no helper daemons. Auto-updates of
Claude.app keep working.

I'd love to hear if anyone has a cleaner approach. Source under MIT.
```

**When to post**: Tue–Thu, 8–10 AM Pacific time gives the best front-page odds.

---

## Reddit — r/ClaudeAI

**Title**:

```
I made a 7KB wrapper to run two Claude Desktop accounts on macOS — open source
```

**Body**:

```
Hey everyone,

If you've ever wanted to run two Claude Desktop accounts at the same time on
macOS (personal + work, two orgs, etc.), the official app's single-instance
lock blocks you. I wrote a tiny wrapper .app that gets around it cleanly —
it just launches the official Claude binary with a separate --user-data-dir,
forcing native arm64 execution to avoid a Rosetta perf trap.

You get full feature parity — cowork, computer use, file system access, MCP
servers — because under the hood it IS the official app, just pointed at a
different data folder.

Repo: https://github.com/jackchiang93-crypto/claude-work-launcher

Install:
- git clone the repo
- ./install.sh
- Spotlight → "Claude Work" → sign in with your second account

Rate limits are per-account so this also genuinely doubles your daily quota
if you have two accounts.

The original /Applications/Claude.app is never modified. MIT licensed.

Happy to answer questions. Curious if there's a Windows or Linux equivalent
that anyone's done — the same trick should work on Linux with --user-data-dir
but I haven't tested.
```

**Subreddits to consider** (rank order):
1. **r/ClaudeAI** — most on-topic, allows tool/repo posts
2. **r/macapps** — Mac-focused, loves small useful tools
3. **r/MacOS** — broader audience, mostly fine with tools
4. **r/programming** — possible if you frame it as "Electron single-instance lock workaround"

**Skip**: r/Anthropic (low traffic), r/artificial (too off-topic).

---

## Twitter / X (optional)

```
Made a 7KB macOS wrapper that lets you run two Claude Desktop accounts at
once — personal + work, two orgs, doubled rate limit, whatever.

Full feature parity (cowork, computer use, MCP). No Electron repack.

https://github.com/jackchiang93-crypto/claude-work-launcher
```

---

## Tips

- **Add the screenshot first.** Posts with images get 2-3× the engagement.
- **Don't lie about who you are.** "Author here" on HN is fine; pretending
  to be a third-party recommending it is against guidelines and easy to
  spot.
- **Reply to comments for the first few hours.** HN especially values OP
  engagement; it's a ranking factor.
- **Don't ask for upvotes** anywhere. Insta-flag on most subs and a
  shadowban risk on HN.
