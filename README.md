# claus

> Passive Claude Code usage tracker. No setup. No workflow changes.

Runs alongside your existing `claude` sessions. Tails Claude Code's local
JSONL logs and prints per-turn token stats directly in your terminal.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOURNAME/claus/main/install.sh | bash
```

Or manually:
```bash
curl -fsSL https://raw.githubusercontent.com/YOURNAME/claus/main/claus \
  -o ~/.local/bin/claus && chmod +x ~/.local/bin/claus
```

**Requires:** `jq`, `bash 4+`, macOS or Linux

## Usage

Open a second terminal tab while Claude Code is running:

```bash
claus
```

Output:
```
claus v0.1.0 — watching 3 session file(s)
  log → ~/.claus/usage.jsonl

[claus] turn 1   | in: 2,841  | out: 312
[claus] turn 2   | in: 5,102  | out: 891   | cache: 540  | ctx: +79%
[claus] turn 3   | in: 5,244  | out: 203   | cache: 540  | ctx: +2%
```

Print session totals and estimated cost:
```bash
claus summary
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUS_LOG_DIR` | `~/.claude/projects` | Claude Code log location |
| `CLAUS_OUTPUT_LOG` | `~/.claus/usage.jsonl` | Where claus writes its log |

## How It Works

Claude Code writes structured JSONL transcripts to `~/.claude/projects/`.
Claus tails those files passively. It never touches your Claude config,
never proxies traffic, never modifies any file except its own log.

## Uninstall

```bash
rm ~/.local/bin/claus
rm -rf ~/.claus
```
