---
name: eos-design-scorecard
description: Design a company or department Scorecard. Agent runs the workshop, surfaces candidate metrics from each leader, pressure-tests every candidate against the six-question filter, sets owners and weekly goals, and writes the 13-week tracking template. Use when the operator says "build the scorecard", "design a scorecard", "we need a scorecard", "set up our weekly metrics", or invokes /eos-design-scorecard. Expects access to the operator's V/TO file (for the 1-Year Plan) and any prior Scorecard.
---

> **Workspace root.** Every relative path in this SKILL.md (`vto.md`, `accountability-chart.md`, `issues-list.md`, `BOOTSTRAP.md`, `BOOTSTRAP-COMPLETE.md`, `meeting-notes/`, `rocks/`, `scorecards/`, `people-analyzer/`, `processes/`, `quarterly-conversations/`, `snapshots/`, `.agents/skills/`, `scripts/`) is resolved against the EOS workspace root — the directory that contains `BOOTSTRAP.md`, `AGENTS.md`, and `.agents/skills/`. Before doing anything else, find that directory and `cd` into it. Do not write artifacts to the operator's current working directory if it isn't the workspace root.
>
> Discovery, in order:
>
> 1. **cwd test.** If `./BOOTSTRAP.md` and `./.agents/skills/` both exist, cwd IS the workspace root. Done.
> 2. **Global-install lookup.** Otherwise the skill was invoked globally via a `~/.claude/skills/<prefix>eos-design-scorecard` symlink. Resolve the workspace root with:
>    ```bash
>    LINK=$(find -L ~/.claude/skills -maxdepth 1 -type l -lname "*/.agents/skills/eos-design-scorecard" 2>/dev/null | head -1)
>    [ -n "$LINK" ] && WORKSPACE_ROOT=$(cd "$(readlink -f "$LINK")/../../.." && pwd)
>    ```
> 3. **Multi-workspace tiebreak.** If step 2 finds multiple symlinks (operator runs more than one EOS workspace), match the slash-command prefix the operator just used. Example: `/acme-eos-design-scorecard` → pick the symlink named `acme-eos-design-scorecard`. If you can't tell, ask the operator which workspace to run against.
> 4. **No workspace found.** Halt and tell the operator to `cd` into their EOS workspace, or to run `bash scripts/install-global-skills.sh [prefix]` from inside that workspace to register it for global invocation.
>
> Then `cd "$WORKSPACE_ROOT"` and proceed with the rest of this skill.

# Design Scorecard

The Scorecard is the Data Component's master tool: 5-15 weekly activity-based leading indicators with owners, goals, and 13 weeks of history. It is what ends opinion-based arguments about whether the business is healthy. The team looks at the Scorecard, sees on track or off track per metric, and moves on.

This skill turns the agent into the Scorecard-design workshop facilitator. The agent collects candidate metrics from each leader, runs every candidate through the six-question filter, names one owner per metric, sets the weekly goal tied to the 1-Year Plan, and stands up the 13-week tracking template. The output is a live Scorecard the team reviews in next week's L10.

The skill works for the company Scorecard, a departmental Scorecard, or both (the company first, then a cascade plan).

## Inputs

Before starting, locate or ask for:

- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer), specifically the 1-Year Plan section (the weekly goals anchor here).
- The prior Scorecard, if one exists, with its 13-week history.
- Each leader's pre-work: 3-5 candidate metrics for their function, written as *metric name, owner, weekly goal, why it matters*.
- The list of every dashboard, KPI report, or "we track this in a spreadsheet" artifact currently in use. The workshop will mostly cut from this list, not add to it.

In the business-instance repo:

- `vto.md`
- `scorecards/company.md` (or `scorecard.md`, prior version)
- Any existing departmental Scorecards at `scorecards/<department>.md`

If no prior Scorecard exists, this is a first-time build. If one exists, the skill is either a quarterly retire-and-add pass or a fresh rebuild after a business model shift.

## The Session

The agent runs the workshop in five passes. Half a day for a company Scorecard. 60-90 minutes for a department.

### Pass 1: Open and Frame (15 min)

The agent states the two disciplines out loud:

1. **Leading, not lagging.** Each metric must be something the team can influence this week. "Revenue this week" is lagging. "Discovery meetings booked this week" is leading.
2. **Activity-based, not outcome-based.** Activity is what the team controls. Outcomes are downstream of activity plus market conditions.

The agent sets the constraint: 5-15 metrics. No more. The agent says: "Most first attempts overshoot. We will end with fewer metrics than we started with."

### Pass 2: Surface Candidate Metrics (45 min)

Each leader walks through their candidate metrics, in turn. 5-10 minutes per function. The agent (as scribe) captures every candidate on a shared list. No filtering yet.

By the end of this segment, the list typically has 25-50 candidates. The next pass cuts.

### Pass 3: Pressure-Test Each Candidate (90 min)

For each candidate, the agent runs the six-question filter out loud:

1. **Leading?** "Is this influenceable this week?"
2. **Activity-based?** "Is this something the team does, or is this an outcome downstream of the team's actions?"
3. **Weekly-trackable?** "Will this number be available every Monday for last week's review?"
4. **Owned?** "Who specifically owns this number? One name, not a team."
5. **Goal-set?** "What is the weekly target?"
6. **Predictive?** "Does hitting this correlate with the business getting healthier?"

For each candidate, the proposing leader defends the answer to each question. The agent cuts ruthlessly.

A common pattern the agent should expect: the team proposes "revenue this week." The agent surfaces it as lagging and not activity-based. The agent asks: "What activities produce that revenue? Let's put one of those on the Scorecard instead." The team converges on "outbound sales touches" or "discovery meetings booked."

By the end of this pass, the list has 8-15 candidates that passed all six questions.

### Pass 4: Set Goals and Owners (45 min)

For each surviving metric:

- **Owner.** Prompt: "One name. Not a team. Who reports this number every Monday and answers when it goes red?"
- **Weekly goal.** Prompt: "What is the specific weekly target? Trace it backward from the 1-Year Plan. If the annual goal is $5M in new sales, how many deals at what average size, how many discovery meetings per deal, how many discovery meetings per week?"
- **Threshold.** Hitting the goal is on track (green). Missing is off track (red). No yellow. Binary.

If two candidates compete for one of the last 15 slots, the agent prompts: "Pick the one whose owner is most clearly accountable and whose goal is most clearly tied to the 1-Year Plan."

### Pass 5: Stand Up the Template and Cadence (20 min)

The agent confirms or sets:

- **Where the Scorecard lives.** A single shared document. Markdown table in `scorecards/company.md`, a spreadsheet, or a dashboard. Whatever the team will actually open every Monday.
- **The 13-week template.** Columns: Metric | Owner | Goal | W1 | W2 | ... | W13. As week 14 lands, week 1 rolls off into an archive.
- **Data drop cadence.** Whoever collects the numbers has them in the document by Monday 9am.
- **Review cadence.** Scorecard Review at the Monday L10. 5 minutes. Each owner reports on track or off track. Off-track items go to the Issues List.
- **Three-reds rule.** Three consecutive weeks off-track on any metric triggers an IDS at the L10 to dig into root cause.

### Pass 6 (if company Scorecard): Schedule the Cascade (10 min)

The agent confirms: each department head will run the same workshop with their team in the next 2-4 weeks. Each department Scorecard has 3-5 metrics cascading from the company Scorecard. Each individual contributor ends up with at least one weekly Measurable they own.

## Outputs

The agent produces a Scorecard file at `scorecards/company.md` (or `scorecards/<department>.md` for departmental rounds):

```markdown
# Scorecard — YYYY-MM-DD

*Reviewed every Monday L10. Three reds in a row triggers IDS. Data lands by Monday 9am.*

| Metric | Owner | Weekly Goal | W1 | W2 | W3 | W4 | W5 | W6 | W7 | W8 | W9 | W10 | W11 | W12 | W13 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| <Metric name> | <Owner> | <Goal> | | | | | | | | | | | | | |
| <Metric name> | <Owner> | <Goal> | | | | | | | | | | | | | |
| <Metric name> | <Owner> | <Goal> | | | | | | | | | | | | | |

## Notes

- 1-Year Plan link: <each metric ties to which annual goal>
- Data collector: <name>, drops numbers by Monday 9am
- Owners: <list of owners and their metrics>

## Retired Candidates (from this workshop)

| Candidate | Why Cut |
|---|---|
| <metric> | <which of the six questions it failed> |
| ... | ... |

## Cascade Plan

- <Department>: workshop scheduled for <date>, will produce <N> departmental metrics
- ...
```

Additionally:

- Update the V/TO to reference the new Scorecard.
- Any issues that surfaced during the workshop (e.g., "we cannot weekly-track customer NPS, that needs a new system") get added to `issues-list.md`.
- If this is a quarterly retire-and-add pass, archive the prior 13-week history in `scorecards/archive/YYYY-Q-company.md` before overwriting.

## Failure Modes the Agent Should Catch

- **Lagging indicators creep in.** "Revenue this week" feels objective and important. It is also lagging. The agent forces every candidate through the leading-vs-lagging filter. Lagging metrics can live on the financial dashboard. They do not belong on the Scorecard.
- **Dashboard sprawl.** If the team is heading toward 20+ metrics, the agent pushes back hard. "5-15 is the box. 8-10 is usually the sweet spot. Which five are getting cut?"
- **Ownerless rows.** "Sales owns this." No. *Who* in Sales? One name per row. The agent does not let the workshop end with any row missing an owner.
- **Goals disconnected from the 1-Year Plan.** Every weekly goal traces backward to an annual goal. If a leader cannot make the trace, the agent asks: "What 1-Year Plan number does this serve?" If no good answer, the metric is suspect.
- **No data-collection process.** The Scorecard requires that someone actually pulls the numbers every Monday. If that person is undefined, the Scorecard stops working by week three. The agent names the collector and schedules the data drop.
- **Tracking precision over insight.** "Average customer support response time, 4.12 hours, to two decimal places" is precision theater. The agent rounds to whole hours and moves on.
- **Skipping the cascade.** A company Scorecard with no plan to cascade through the departments leaves only the top of the org data-driven. The agent does not close the workshop without a cascade schedule.

## When To Stop

The skill is done when:

- 5-15 metrics are on the Scorecard.
- Every metric has one owner, a weekly goal, and ties to the 1-Year Plan.
- The 13-week template is set up and saved.
- The data-collection cadence is named (who, when, where).
- The three-reds-triggers-IDS rule is documented.
- For a company Scorecard: the cascade schedule is set.

The agent reports back: "Scorecard live. N metrics. Owners assigned. First L10 review on <date>. Cascade workshops scheduled <list>."

## References

- [Scorecard](https://traction.wiki/tools/scorecard) — the canonical tool page.
- [Build the Scorecard](https://traction.wiki/playbooks/build-the-scorecard) — the full workshop.
- [Measurable](https://traction.wiki/concepts/measurable) — the unit of individual accountability.
- [On Track / Off Track](https://traction.wiki/concepts/on-track-off-track) — the binary status language.
- [Scorecard Review](https://traction.wiki/concepts/scorecard-review) — the L10 segment where this gets reviewed.
- [Level 10 Meeting](https://traction.wiki/tools/level-10-meeting) — where the Scorecard is used every week.
- [Data Component](https://traction.wiki/components/data) — the component this strengthens.
