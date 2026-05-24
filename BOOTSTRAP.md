# Bootstrap Your Business on EOS

Read this once. Then run `/eos-bootstrap-business` in your agentic harness and the orchestrator walks you through it interactively.

## Before You Start

- [ ] This repo is your private fork (not the public template). Verify: `gh repo view --json visibility`.
- [ ] The repo is renamed for your business (not "eos-business-workspace-template"). Verify: `gh repo view --json name`.
- [ ] You have read [traction.wiki/start-here/what-is-eos](https://traction.wiki/start-here/what-is-eos).
- [ ] Your leadership team (Visionary + Integrator + function heads) is committed to a 24+ month EOS rollout.
- [ ] You have read or skimmed *What the Heck Is EOS?* (one of the three Wickman books).

## The First Week

### Day 0 — Welcome (15 min, alone)

The bootstrap skill greets you and confirms the prerequisites above.

### Day 1-2 — V/TO Draft (4-8 hours, full leadership team)

Off-site or focused session. The bootstrap skill chains into `/eos-update-vto`, which walks the eight V/TO questions: Core Values, Core Focus, 10-Year Target, Marketing Strategy, 3-Year Picture, 1-Year Plan, Rocks, Issues.

Output: `vto.md`.

Companion: [traction.wiki/playbooks/build-the-vto](https://traction.wiki/playbooks/build-the-vto).

### Day 3-4 — Accountability Chart (2-4 hours, leadership team)

The bootstrap skill chains into `/eos-build-accountability-chart`. Maps every seat with 5 major roles each.

Output: `accountability-chart.md`.

Companion: [traction.wiki/playbooks/design-the-accountability-chart](https://traction.wiki/playbooks/design-the-accountability-chart).

### Day 5 — Schedule the First Level 10 Meeting (15 min)

Pick the day and time. Lock it on every leadership team member's calendar forever. 90 minutes, same day, same time, every week.

The bootstrap skill copies `meeting-notes/L10-TEMPLATE.md` to `meeting-notes/<first-l10-date>-leadership-l10.md` with the leadership team's names pre-filled.

On the day of the L10, run `/eos-run-level-10`.

Companion: [traction.wiki/playbooks/run-your-first-level-10](https://traction.wiki/playbooks/run-your-first-level-10).

### Day 6-7 — First People Analyzer Round (2-3 hours, alone first, then conversations)

Leadership team only for the first round. The bootstrap skill chains into `/eos-people-analyzer`. Scores every leader on Core Values + GWC. Sets The Bar. Identifies any wrong-person or wrong-seat cases.

Output: `people-analyzer/<today>.md`.

Companion: [traction.wiki/playbooks/run-the-people-analyzer](https://traction.wiki/playbooks/run-the-people-analyzer).

### Wrap-up — Schedule Q1 Off-Site, Get to Rhythm

The bootstrap skill computes the date of the first quarterly off-site (~90 days out) and writes `BOOTSTRAP-COMPLETE.md`. You move into the running rhythm.

## After Bootstrap — The Rhythm

| Cadence | Skill | What happens |
|---|---|---|
| **Weekly** (90 min) | `/eos-run-level-10` | Scorecard review, Rock review, IDS on top 3 issues. The L10. |
| **Quarterly** (1 day off-site) | `/eos-set-quarterly-rocks` + `/eos-people-analyzer` | Last quarter reviewed, new quarter's Rocks set, People Analyzer round. |
| **Annually** (2 days off-site) | `/eos-update-vto` | V/TO refreshed, 1-Year Plan reset, prior year reviewed. |
| **Anytime** | `/eos-ids-single-issue` | Hot issue resolution outside an L10. |
| **Anytime** | `/eos-business-health-snapshot` | Step-back diagnostic across all six Components. |
| **Anytime** | `/eos-design-scorecard` | Stand up a new departmental Scorecard. |
| **Anytime** | `/eos-document-core-process` | Document a Core Process. |
| **Anytime** | `/eos-quarterly-conversation-prep` | Manager prep for a 1-on-1. |

## When You Get Stuck

- The framework reference is [traction.wiki](https://traction.wiki). Every tool, concept, playbook, and role has a page.
- Each artifact in this repo opens with an HTML comment pointing to its wiki tool page. Grep `traction.wiki` to find them.
- For framework-level questions a Professional EOS Implementer can answer faster than you can read. [eosworldwide.com](https://www.eosworldwide.com) has the implementer network.
