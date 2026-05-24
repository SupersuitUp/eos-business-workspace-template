---
name: eos-bootstrap-business
description: One-shot orchestrator that walks a new operator through their first week running EOS in this workspace. Calls eos-update-vto (Day 1-2), eos-build-accountability-chart (Day 3-4), schedules the first Level 10 Meeting (Day 5), and runs the first eos-people-analyzer round (Day 6-7). Writes BOOTSTRAP-COMPLETE.md when done; refuses to re-run after that file exists. Use when the operator says "let's set up the business", "bootstrap the business", "first day with EOS", or invokes /eos-bootstrap-business. Expects a freshly-forked private repo (not the public template).
---

# eos-bootstrap-business

The one-shot first-week orchestrator. Run once per business. Calls the other EOS skills in sequence. Produces a fully-set-up workspace: V/TO, Accountability Chart, first L10 scheduled, first People Analyzer baseline.

## Inputs

- The empty (or near-empty) repo this skill is running inside. Specifically the placeholder versions of:
  - `vto.md`
  - `accountability-chart.md`
  - `meeting-notes/L10-TEMPLATE.md`
- The operator's leadership team (interview the operator for names + roles at the start).

## Refuse to re-run

Before doing anything, check for `BOOTSTRAP-COMPLETE.md` at the repo root. If it exists, refuse:

> "This business has already been bootstrapped (see BOOTSTRAP-COMPLETE.md). Individual skills (eos-update-vto, eos-build-accountability-chart, eos-people-analyzer, etc.) can be run any time, but the bootstrap orchestrator only runs once. If you want to start over, delete BOOTSTRAP-COMPLETE.md and re-invoke me."

## Phases

### Day 0: Welcome + visibility check

1. **Confirm the repo is named for the operator's business.** Run `gh repo view --json name | jq -r .name`. If the name is still "eos-business-workspace-template", halt and instruct the operator to rename via `gh repo rename <their-business-name>`.

2. **Confirm the repo is PRIVATE.** Run `gh repo view --json visibility | jq -r .visibility`. If "PUBLIC", halt and instruct the operator to change visibility before continuing:

   ```bash
   gh repo edit --visibility private --accept-visibility-change-consequences
   ```

3. **Confirm the operator has read `BOOTSTRAP.md`.** Ask out loud.

4. **Offer optional global skill install.** The repo already ships `.claude/skills -> ../.agents/skills`, so EOS skills work as slash-commands when the operator opens Claude Code IN THIS REPO. The optional next step is making them work globally (any Claude Code session anywhere on the machine).

   Ask:

   **"Want the EOS skills available as slash-commands from anywhere on your machine, not just when you are in this business folder?"**

   If they say no: skip. Project-local discovery is enough for most operators.

   If they say yes: ask the prefix question:

   **"Do you have (or plan to have) other EOS workspaces — one per business you operate or advise? If yes, namespace this clone's skills with a prefix so they don't collide. For your only business, leave blank."**

   - Single business: `bash scripts/install-global-skills.sh` (no prefix). Skills become `/eos-run-level-10`, `/eos-bootstrap-business`, etc.
   - Multiple businesses: pick a short business-slug prefix. Run `bash scripts/install-global-skills.sh <prefix>`. Skills become `/<prefix>eos-run-level-10`, e.g., `/acme-eos-run-level-10`.

   Confirm what got installed before continuing.

5. **Interview for leadership team.** Ask:

   > "Who is on the leadership team? List names and current titles. We need this for the V/TO and Accountability Chart."

   Capture this list. It threads through the rest of the bootstrap. Default cap: 7 leaders. More than 7 and the team is too big to make decisions; surface this to the operator as something to address in the Accountability Chart phase.

### Day 1-2: V/TO draft

Invoke the `eos-update-vto` skill. Pass the leadership team list as context.

The eos-update-vto skill walks the eight V/TO questions:

1. Core Values (3-7)
2. Core Focus (Purpose + Niche)
3. 10-Year Target
4. Marketing Strategy (Target Market, 3 Uniques, Proven Process, Guarantee)
5. 3-Year Picture
6. 1-Year Plan
7. Quarterly Rocks (placeholder for the upcoming quarter)
8. Issues List

The operator (ideally with their leadership team present) answers each.

Writes `vto.md`.

Confirm with the operator before moving on: "Is the V/TO signed off by every leadership team member?"

### Day 3-4: Accountability Chart

Invoke `eos-build-accountability-chart`. Pass the leadership team list and the V/TO Core Focus.

The skill maps every seat top to bottom (Visionary, Integrator, function heads, their teams) with 5 major roles per seat. Surfaces:

- Gaps (seats with no name → planned hires)
- Over-fills (seats with two names → split or pick)
- Founders sitting in multiple seats → name them all, plan to hire out

Writes `accountability-chart.md`.

### Day 5: L10 scheduling

1. Ask: "What day and time will the weekly Level 10 Meeting run? Pick once. Same day, same time, every week. 90 minutes."

2. Compute the first L10 date (the next instance of the chosen day-of-week).

3. Copy `meeting-notes/L10-TEMPLATE.md` to `meeting-notes/<first-l10-date>-leadership-l10.md` with the operator's leadership team names filled in.

4. Tell the operator to put the recurring L10 on every leadership team member's calendar before adjourning the bootstrap.

5. Explain how to use `eos-run-level-10` for the first L10 (it's a different skill they invoke on the day of).

### Day 6-7: First People Analyzer

Invoke `eos-people-analyzer`. Run on the **leadership team only** (not the whole company yet).

The skill scores every leader against each Core Value (from the V/TO) and against GWC for their current seat. Sets The Bar. Identifies any wrong-person or wrong-seat cases.

Writes `people-analyzer/<today>.md`.

### Wrap-up

1. Compute the date of the first quarterly off-site: today + ~90 days, aligned to the start of the next calendar quarter.

2. Write `BOOTSTRAP-COMPLETE.md` at the repo root:

   ```markdown
   # Bootstrap Complete

   **Business:** <operator's business name from gh repo view>
   **Operator:** <name>
   **Leadership team:**
   - <name 1> — <seat>
   - <name 2> — <seat>
   - ...

   **Milestones:**
   - V/TO signed off: <date>
   - Accountability Chart drawn: <date>
   - First L10 scheduled: <date>
   - First People Analyzer round: <date>

   **Next milestones:**
   - First quarterly off-site: <date>
   - First annual planning day: <date one year out>

   **The rhythm from here:**
   - **Weekly:** `/eos-run-level-10` every <weekday> at <time>.
   - **Quarterly:** `/eos-set-quarterly-rocks` and `/eos-people-analyzer` at the off-site.
   - **Annually:** `/eos-update-vto` at the annual planning day.
   - **Anytime:** `/eos-ids-single-issue` for hot issues that cannot wait, `/eos-business-health-snapshot` for a step-back diagnostic.

   Run individual EOS skills as needed. Do not re-run `eos-bootstrap-business`.
   ```

3. Commit:

   ```bash
   git add BOOTSTRAP-COMPLETE.md
   git commit -m "chore: bootstrap complete"
   ```

4. Tell the operator: "Bootstrap done. Your first L10 is on <date>. Run `/eos-run-level-10` on the morning of."

## Failure Modes the Agent Should Catch

- **Repo is still public.** Halt at Day 0. Do not write business data to a public repo.
- **Repo is still named "eos-business-workspace-template".** The fork was never renamed. Halt and instruct.
- **Operator wants to skip the V/TO.** Push back. Everything else cascades from the V/TO; skipping it means EOS is not running.
- **Operator wants to add the whole company to the first People Analyzer.** Push back. Leadership team only for the bootstrap. Roll out to the rest of the company in subsequent rounds.
- **Leadership team disagrees on V/TO answers.** Surface the disagreement as an Issue on the V/TO's Issues List. Do not auto-resolve. Continue with the draft they can agree on.
- **Operator wants to bootstrap solo (no leadership team).** Acceptable if they are a solo founder, but flag it: many tools (People Analyzer, Quarterly Conversations) presume more than one person. Adapt or skip those phases.

## When To Stop

The skill is done when `BOOTSTRAP-COMPLETE.md` exists. Hand off to weekly L10 rhythm.

## References

- [What Is EOS](https://traction.wiki/start-here/what-is-eos) — the framework.
- [The First 90 Days](https://traction.wiki/start-here/the-first-90-days) — the prescribed sequence this skill operationalizes.
- The individual sub-skills: `eos-update-vto`, `eos-build-accountability-chart`, `eos-run-level-10`, `eos-people-analyzer`.
