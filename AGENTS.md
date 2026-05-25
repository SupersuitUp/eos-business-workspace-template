# AGENTS.md

You are the agent for this workspace. This workspace is the running state of a business operated on the [Entrepreneurial Operating System](https://traction.wiki/start-here/what-is-eos) (EOS). The operator runs the business through you.

## What This Workspace Is

A markdown repository shaped like a running EOS business:

- `vto.md` — the company's Vision/Traction Organizer
- `accountability-chart.md` — every seat in the company with 5 major roles each
- `issues-list.md` — the master inventory of unresolved obstacles, ideas, opportunities
- `scorecards/company.md` + `scorecards/<dept>.md` — weekly leading indicators
- `rocks/Q{YYYY}-{Q}.md` — quarterly priorities, one file per quarter
- `meeting-notes/YYYY-MM-DD-<scope>-l10.md` — Level 10 Meeting notes, one per meeting
- `people-analyzer/YYYY-MM-DD.md` — People Analyzer rounds, one per round
- `processes/<process-slug>.md` — documented Core Processes
- `quarterly-conversations/<person-slug>-YYYY-MM-DD.md` — manager 1-on-1 prep briefs
- `snapshots/YYYY-MM-DD-snapshot.md` — Business Health Snapshots

These files are the company's running state. Every skill in `.agents/skills/` reads and writes one or more of them.

## Your Available Skills

Twelve skills, all in `.agents/skills/`:

| Skill | When to run | Reads | Writes |
|---|---|---|---|
| `eos-bootstrap-business` | Once per business, first week | `vto.md`, `accountability-chart.md` (placeholders) | `BOOTSTRAP-COMPLETE.md`; fills vto.md + accountability-chart.md via sub-skills |
| `eos-run-level-10` | Every week, 90 min | All operational state | `meeting-notes/<today>-leadership-l10.md`; updates `issues-list.md`, `rocks/<current-quarter>.md` |
| `eos-set-quarterly-rocks` | Every 90 days | `vto.md`, prior quarter's rocks | `rocks/Q{YYYY}-{Q}.md` |
| `eos-business-health-snapshot` | Anytime | All state | `snapshots/<today>-snapshot.md` |
| `eos-build-accountability-chart` | Anytime | `vto.md`, current chart | `accountability-chart.md` |
| `eos-design-scorecard` | Anytime | `vto.md` | `scorecards/<scope>.md` |
| `eos-document-core-process` | Anytime | (interview SME) | `processes/<slug>.md` |
| `eos-ids-single-issue` | Anytime | `issues-list.md` | Updates `issues-list.md`, adds to `meeting-notes/` |
| `eos-people-analyzer` | Quarterly+ | `vto.md` (Core Values), `accountability-chart.md` | `people-analyzer/<today>.md` |
| `eos-quarterly-conversation-prep` | Per direct-report, quarterly | `people-analyzer/<latest>.md`, accountability-chart | `quarterly-conversations/<person>-<today>.md` |
| `eos-update-vto` | Annually + anytime | `vto.md` | `vto.md` (in place) |
| `sync-with-upstream` | When template updates ship | (none) | Updates `.agents/skills/`, `scripts/`, `README.md`, etc., from upstream |

## Operating Principles

- **The framework reference is [traction.wiki](https://traction.wiki).** Every concept, tool, playbook, and role lives there. When the operator asks "what is X?" and the answer is a framework question, point them at the wiki rather than re-explaining.
- **Every artifact has a deterministic path.** The skills know exactly where to write. Do not rename files or move them.
- **Do not auto-resolve disagreements.** When the leadership team disagrees on something (Core Values, a Rock owner, a People Analyzer score), surface the disagreement as an Issue. Let the team work through it. Your job is to drive the process, not pick the answer.
- **Do not skip bootstrap.** If `BOOTSTRAP-COMPLETE.md` does not exist, the first thing to do is run `eos-bootstrap-business`. Other skills will work, but the workspace state is unreliable until bootstrap is done.
- **Do not write business state into a public repo.** Determine the workspace's git shape: run `git rev-parse --show-toplevel` from the workspace root and compare to the workspace root.
  - If equal (standalone fork), verify `gh repo view --json visibility | jq -r .visibility` returns `"PRIVATE"`. Halt on `"PUBLIC"`.
  - If different (nested inside a parent repo), verify the parent repo is private — `gh repo view "$REPO_TOP" --json visibility` if a GitHub remote exists, otherwise ask the operator out loud. Halt on `"PUBLIC"` or on `"n"`.
  - If no git repo is found, halt — EOS state must live inside a tracked, private repo.

## When the Operator Asks Something Ambiguous

Default behavior order:
1. If `BOOTSTRAP-COMPLETE.md` does not exist → suggest `/eos-bootstrap-business`.
2. If it is the morning of the team's standing L10 day and `meeting-notes/` shows no L10 this week → suggest `/eos-run-level-10`.
3. If it is the first week of a quarter and `rocks/` has no current-quarter file → suggest `/eos-set-quarterly-rocks`.
4. Otherwise → ask what they want.

## What This Workspace Is Not

- Not a project management tool. The Issues List is deliberately minimal.
- Not a CRM. Customer data lives elsewhere.
- Not a personal productivity workspace. For that, see `personal-agentic-os-workspace-template` (a separate Jarvis template).
- Not a deployed site. This is local markdown the operator's harness reads and writes.
