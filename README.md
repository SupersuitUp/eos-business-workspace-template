# eos-business-workspace-template

A complete EOS-business workspace, runnable in any agentic harness. Fork to a private repo, open in Claude Code (or Hermes, or Codex), run the `eos-bootstrap-business` skill, and walk through your first week of running on the [Entrepreneurial Operating System](https://traction.wiki/start-here/what-is-eos).

> ## ⚠️ Before You Fork
>
> This template is public. **Your fork should be private.** When you click "Use this template", set Repository Visibility to **Private** before creating the new repo. This repo will hold your company's actual V/TO, Scorecards, Rocks, and confidential personnel data.
>
> *If you forget, change visibility later in Settings → Danger Zone → Change visibility. Anything pushed while public is in the commit history; rotate any sensitive data that was exposed.*

## What This Is

A markdown workspace shaped like a running EOS business. Twelve skill files (`.agents/skills/`) drive the rituals: weekly Level 10 Meetings, quarterly Rocks, annual V/TO refreshes, People Analyzer rounds, IDS sessions. Each ritual produces a markdown artifact in the workspace. The workspace IS the company's running state.

The companion framework reference is **[traction.wiki](https://traction.wiki)** — the full canonical EOS framework. Every artifact in this template links back to its tool page on the wiki.

## Quick Start

1. **Fork this template.** Click "Use this template" → "Create a new repository". Set Repository Visibility to **Private**. Name it for your business (e.g., `acme-eos-workspace`).

2. **Install prerequisites:** [Node.js](https://nodejs.org), [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`), [GitHub CLI](https://cli.github.com) (`brew install gh` on macOS).

3. **Clone locally:**

   ```bash
   mkdir -p ~/github-repos && cd ~/github-repos
   gh repo clone YOUR-ORG/YOUR-BUSINESS-NAME
   cd YOUR-BUSINESS-NAME
   ```

4. **Open in Claude Code** and start a session:

   ```bash
   claude
   ```

5. **Run the bootstrap skill** to walk through Day 0 through Day 7:

   ```
   /eos-bootstrap-business
   ```

   By the end of week 1, you have a signed-off V/TO, a complete Accountability Chart, a scheduled weekly L10, and a People Analyzer baseline.

6. **From here, the rhythm:**
   - **Weekly:** `/eos-run-level-10` for the L10.
   - **Quarterly:** `/eos-set-quarterly-rocks` and `/eos-people-analyzer` at the off-site.
   - **Annually:** `/eos-update-vto` at the annual planning day.

7. **Turn on hourly auto-sync** so your work is backed up to GitHub: `bash scripts/install-sync-cron.sh`

## Repo Layout

```
your-business-eos-workspace/
├── README.md                  # this file
├── BOOTSTRAP.md               # the First-90-Days checklist (eos-bootstrap-business reads this)
├── CLAUDE.md                  # points to AGENTS.md (Claude Code reads this first)
├── AGENTS.md                  # full operating instructions for any agent

├── .agents/skills/            # the 12 EOS skills (10 from traction-wiki + bootstrap + sync)

├── scripts/
│   ├── sync.sh                # git sync helper
│   └── install-sync-cron.sh   # optional hourly auto-sync

├── vto.md                     # SINGLETON: the V/TO
├── accountability-chart.md    # SINGLETON: the Accountability Chart
├── issues-list.md             # SINGLETON: the Issues List

├── scorecards/                # company.md + per-department .md files
├── rocks/                     # one file per quarter: Q{YYYY}-{Q}.md
├── meeting-notes/             # one file per L10: YYYY-MM-DD-<scope>-l10.md
├── people-analyzer/           # one file per round: YYYY-MM-DD.md
├── processes/                 # one file per Core Process
├── quarterly-conversations/   # one file per conversation: <person>-YYYY-MM-DD.md
└── snapshots/                 # one file per business-health snapshot
```

## Pulling Future Template Updates

The template improves over time (new skills, refined SKILL files, updated artifact templates). When you want the latest:

```
/sync-with-upstream
```

The `sync-with-upstream` skill pulls upstream improvements without touching your filled-in artifacts. See `.agents/skills/sync-with-upstream/SKILL.md` for the safety guarantees.

## License

Use this template however you like. No attribution required. EOS is a registered trademark of EOS Worldwide; this template is an operator's reference, not an official EOS Worldwide product.
