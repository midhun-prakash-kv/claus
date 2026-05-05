# Changelog

All notable changes to claus are documented here.

---

## [0.3.0] — 2026-05-04

### Added
- **Hot file discovery**: claus now detects new Claude Code sessions automatically without requiring a restart.
  - A background poller checks `LOG_DIR` every 2 seconds for new `.jsonl` files.
  - Each session gets its own dedicated `tail -F` process writing into a shared FIFO event bus.
  - New sessions are announced inline: `[claus] new session: <uuid>`.
- Graceful startup when no sessions exist yet — claus waits and detects the first session rather than exiting with an error.

### Changed
- Architecture replaced: single multi-file `tail -F` with `==> path <==` marker parsing → per-file tail processes feeding a named FIFO (`filepath<TAB>line` protocol).
- FIFO anchored with `exec 3<>"$fifo"` (read/write fd) so the event loop never sees EOF when individual tail processes cycle.
- Startup banner now shows the watched directory and a live session count instead of a fixed file count.
- Cleanup trap clears the FIFO and temp files on exit in addition to printing the summary.

---

## [0.2.0] — initial tracked release

### Added
- `claus watch` (default): tails all `.jsonl` files found at startup via a single `tail -F` process; parses `==> path <==` markers to track the active file.
- `claus summary`: aggregates all recorded turns from `~/.claus/usage.jsonl` and prints totals with estimated cost (Sonnet 3.7 pricing: $3/MTok input, $15/MTok output, $0.30/MTok cache reads).
- Per-turn output: `[claus] turn N | in: X,XXX | out: Y,YYY | cache: Z,ZZZ | ctx: +N%`.
- Persistent append-only log at `~/.claus/usage.jsonl` — one JSONL record per assistant turn with `timestamp`, `turn`, `session`, `project`, `title`, `input_tokens`, `output_tokens`, `cache_read_tokens`, `cache_write_tokens`.
- Session metadata extraction: project working directory from `.cwd`, title from the first non-IDE-injected user message.
- Per-session breakdown in `summary` output (project path, title, turn count, token totals, cost, last activity).
- Summary printed automatically on `ctrl+c`.
- Environment variable overrides: `CLAUS_LOG_DIR`, `CLAUS_OUTPUT_LOG`.
- Dependency check for `jq`, `tail`, `find`, `bc` with install hints for macOS and Debian/Ubuntu.

---

## [0.1.0] — prototype

### Added
- Initial proof-of-concept: bash script that tails a single Claude Code JSONL log file and prints raw token counts per assistant turn.
- Basic `jq` parsing of `message.usage` fields.
- No persistent logging, no summary, no multi-session support.
