---
name: eos-business-health-snapshot
description: Produce a one-page health snapshot of a business running on EOS. Agent reads the V/TO, recent L10 meeting notes (last 4 weeks), the Scorecard (last 13 weeks), and current Rocks status, then scores each of the six EOS Components 1-10 and identifies the top 3 priorities for the next quarter. Use when the operator says "how is the business doing", "EOS health check", "snapshot", or invokes /eos-business-health-snapshot. Read-only on inputs; produces a single new artifact.
---

# EOS Business Health Snapshot

A one-page diagnostic of how the business is doing across the six EOS Components. The agent reads the current artifacts, looks for signal, and produces a structured rating with the top 3 priorities for the next quarter.

This skill is useful at:

- The start of every quarterly off-site (sets the agenda).
- Before the annual planning day (sets the 1-Year Plan refresh).
- Whenever the operator wants a step-back view.

## Inputs

The agent reads:

- `vto.md` — the V/TO.
- `scorecard.md` (or `scorecards/company.md`) — the Scorecard with at least 13 weeks of history.
- `rocks/QYYYY-Q.md` — current quarter's Rocks with status.
- `meeting-notes/*.md` from the last 4 weeks — L10 notes for issue patterns, To-Do completion, meeting ratings.
- `issues-list.md` — open Issues.
- (Optionally) `people-analyzer/<latest>.md` if a recent People Analyzer round happened.

If any of these files do not exist, the agent notes the gap as a finding ("Component cannot be scored because the artifact does not exist").

## What the Agent Produces

A single markdown file at `snapshots/YYYY-MM-DD-snapshot.md`:

```markdown
# EOS Health Snapshot — YYYY-MM-DD

## Summary
- Overall: <X>/10
- Strongest component: <name>
- Weakest component: <name>
- Top 3 priorities for next quarter: <three things>

## Component Ratings

### Vision: <X>/10
- **Strong signals**: <bullet evidence from the V/TO or L10 notes>
- **Weak signals**: <bullet evidence>
- **Recommendation**: <action>

### People: <X>/10
- **Strong signals**: <evidence>
- **Weak signals**: <evidence>
- **Recommendation**: <action>

### Data: <X>/10
- **Strong signals**: <evidence; e.g., Scorecard maintained 13+ weeks, off-track items get IDS'd>
- **Weak signals**: <evidence>
- **Recommendation**: <action>

### Issues: <X>/10
- **Strong signals**: <evidence; e.g., 2-3 issues IDS'd per L10, Issues List shrinking>
- **Weak signals**: <evidence>
- **Recommendation**: <action>

### Process: <X>/10
- **Strong signals**: <evidence>
- **Weak signals**: <evidence>
- **Recommendation**: <action>

### Traction: <X>/10
- **Strong signals**: <evidence; e.g., 80%+ Rock completion last quarter, L10 attendance 100%, To-Do completion 90%+>
- **Weak signals**: <evidence>
- **Recommendation**: <action>

## Top 3 Priorities for Next Quarter

1. <Priority>
2. <Priority>
3. <Priority>

## Risk Flags

<any single component scoring below 5/10, or any pattern across components that warrants a leadership team discussion>

## Suggested IDS Topics

<2-5 specific issues the agent recommends adding to the Issues List for the next L10>
```

## Scoring Heuristics

The agent uses these signals to score each Component:

### Vision

- V/TO exists, signed off, refreshed in the last year: +3
- Every leader can describe the Core Focus and 10-Year Target consistently (inferable from L10 notes if mentioned): +2
- Strategic conflicts in L10 IDS sessions get resolved by reference to V/TO: +2
- 3-Year Picture rewritten more than once in the past year: -2 (Vision instability)
- V/TO does not exist or is stale: -5

### People

- Accountability Chart exists and is current: +2
- People Analyzer was run in the last 6 months: +2
- Quarterly Conversations are happening: +2
- Open Issues related to people problems for 3+ months: -2 (avoidance)
- Wrong-person/wrong-seat case open and unaddressed: -3

### Data

- Scorecard exists with 5-15 lines: +2
- 13+ weeks of history maintained: +2
- Indicators are leading (not lagging): +2
- Off-track metrics generate IDS sessions: +2
- Scorecard not maintained or fewer than 8 weeks of history: -3
- All indicators are lagging: -3

### Issues

- Issues List is alive and worked through: +3
- 2-3 issues IDS'd per L10 on average: +2
- Same issue appears multiple times across weeks without resolution: -2
- Issues List has not been touched in 2+ weeks: -3

### Process

- 3+ Core Processes documented to one page: +3
- Process documents updated when L10 IDS produces changes: +2
- Zero Core Processes documented: -3
- Process documents over one page or unused: -2

### Traction

- L10s run every week, same day, same time: +3
- 80%+ Rock completion last quarter: +2
- To-Do completion 90%+ weekly: +2
- L10s have been canceled in the last 4 weeks: -2
- Rocks not set for this quarter or set late: -3
- Rocks are not SMART: -2

Start each Component at 5/10. Apply modifiers. Clamp to 1-10.

## Priority Selection

Top 3 priorities for next quarter come from:

1. The weakest component (highest leverage to fix).
2. The most-blocked recurring issue (compounding cost).
3. A People issue if one is open and unaddressed (it will drag everything else down until solved).

The agent should be willing to call out hard truths. A Wrong-Person-Right-Seat case the team has been avoiding for two quarters belongs in the priorities list.

## Failure Modes the Agent Should Catch

- **Scoring without evidence.** Every component score must cite specific signal from the artifacts.
- **False positives from artifacts that look good but are stale.** If the V/TO has not been updated in 18 months, Vision is not strong just because the file exists.
- **Avoiding the hard recommendation.** If a People problem has been festering, name it.
- **Over-rating because everything is "fine".** If no component scores above 7, that is the honest snapshot. Do not inflate.

## When To Stop

The skill is done when:
- The snapshot file is written.
- Each component has a score and cited evidence.
- Top 3 priorities for next quarter are named.
- Risk flags are surfaced.

The agent reports back to the operator: "Snapshot complete. Strongest: X. Weakest: Y. Top priority: Z."

## References

- [Components](https://traction.wiki/components) — the six components being scored.
- [What Is EOS](https://traction.wiki/start-here/what-is-eos) — the framework being measured against.
- [Vision/Traction Organizer](https://traction.wiki/tools/vision-traction-organizer), [Scorecard](https://traction.wiki/tools/scorecard), [Rocks](https://traction.wiki/tools/rocks), [Level 10 Meeting](https://traction.wiki/tools/level-10-meeting), [People Analyzer](https://traction.wiki/tools/people-analyzer) — the artifacts the snapshot reads.
