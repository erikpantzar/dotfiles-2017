# ~/.claude dotfiles

Only the portable config is tracked here — everything else in `~/.claude`
is runtime state and is gitignored on purpose (see `.gitignore`, which
whitelists rather than blacklists, since this repo is public).

## Tracked
- `settings.json` — hooks, statusline, theme.
- `statusline-command.sh` — the statusline script `settings.json` points at.

## Ignored (not tracked, stays local to each machine)
- `.credentials.json` — OAuth token. Never commit this.
- `daemon/`, `daemon.lock`, `daemon.log`, `daemon.status.json` — daemon runtime state.
- `sessions/`, `session-env/`, `history.jsonl`, `file-history/`, `shell-snapshots/` — session state/history.
- `cache/`, `downloads/`, `jobs/`, `tasks/`, `projects/`, `plugins/`, `backups/`, `mcp-needs-auth-cache.json`, `.last-cleanup` — local cache/working data.

## Setup on a new machine
1. Symlink this folder's tracked files into `~/.claude/` (see the repo's
   top-level README for the symlink commands).
2. Run `claude` and log in — this regenerates `.credentials.json` locally.
3. `settings.json` references `~/.local/bin/claude-notify` for desktop
   notifications — that script lives outside this repo; install/symlink it
   separately if you want notifications, otherwise the hooks fail silently.

No `*.example` files exist yet — nothing currently tracked here needs
machine-specific values filled in. If that changes (e.g. a setting that
should differ per machine), add `FILENAME.example` here and gitignore the
real file.
