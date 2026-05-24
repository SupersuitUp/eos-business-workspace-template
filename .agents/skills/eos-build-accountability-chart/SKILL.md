---
name: eos-build-accountability-chart
description: Build or refresh the Accountability Chart. Agent runs the workshop with the leadership team, maps every seat top to bottom, names five major roles per seat, draws clean reporting lines, and surfaces gaps and over-fills. Use when the operator says "build the accountability chart", "draft our org seats", "refresh the seats", "design the accountability chart", or invokes /eos-build-accountability-chart. Expects access to the operator's V/TO file and any prior accountability chart.
---

# Build Accountability Chart

The Accountability Chart is the People Component's master tool. It is not an org chart. An org chart shows who reports to whom. An Accountability Chart shows what seats the company needs to be filled and what each seat is accountable for.

This skill turns the agent into the workshop facilitator and scribe. The agent walks the leadership team through drafting (or refreshing) the chart top to bottom: Visionary, Integrator, function heads, then the seats beneath each function. Every seat gets five major roles. Every seat gets one name (or "OPEN" with a target hire date). Every reporting line is clear.

The output is a chart that surfaces the structural truth: who is in two seats, which seats are empty, which seats two people are fighting over, and where the Visionary / Integrator split actually lives.

## Inputs

Before starting, locate or ask for:

- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer) (for Core Values, Core Focus, and the 1-Year Plan that the chart's structure has to deliver).
- The current Accountability Chart, if one exists.
- The list of every leadership team member and their current title.
- Each leader's pre-work: the list of functions they think the company needs and the seats they personally feel they are sitting in today.
- The 1-Year Plan and 3-Year Picture (the chart is forward-looking; it serves where the company needs to be in 6-12 months).

In the business-instance repo:

- `vto.md`
- `accountability-chart.md` (prior, if it exists)

If no prior chart exists, the skill is a first-time draft. If a prior chart exists, the skill is a refresh and the agent compares old to new.

## The Session

The agent runs the workshop in five passes. Half a day to a full day, depending on company size.

### Pass 1: Open and Frame (15 min)

The agent states three ground rules out loud:

1. **Look forward, not back.** The chart is for where the company needs to be in 6-12 months. Not where it is today. Not where it was a year ago.
2. **Seats first, people second.** Name what the seat is accountable for before naming who sits in it.
3. **One person per seat, one seat per person, no dotted lines.**

Confirm attendees. The workshop is the leadership team only. 3-7 people. Department heads and individual contributors do not attend.

### Pass 2: Draw the Top of the Chart (60 min)

The agent walks the team through three boxes, top to bottom:

1. **Visionary.** Prompt: "Who is the Visionary? What are the five major roles? Start with: ideas generator, owner of culture, owner of major relationships, R&D / problem-solver, public face."
2. **Integrator.** Prompt: "Who is the Integrator? Five major roles: LMA (lead, manage, accountability), P&L owner, executes the business plan, removes obstacles, integrates the leadership team."
3. **Three function heads.** Prompt: "Who heads Sales/Marketing? Operations? Finance? For each, five major roles."

For each box, the agent captures the five major roles. Not three. Not nine. Five.

For the Visionary and Integrator boxes, the agent slows down. The founder is often in both. The team has to decide explicitly:

- One person playing both roles. Note which they spend most of their time on.
- A planned split: founder is Visionary, hiring an Integrator. Note target date.
- A current split: two co-founders, one Visionary, one Integrator.

The decision gets documented. Many founders discover here that they want to hire an Integrator and step into pure Visionary work.

### Pass 3: Cascade Function by Function (90-120 min)

For each function head, in turn:

The agent prompts: "Walk us through the seats beneath you. For each seat: what is the function, what are the five major roles, who is in it today (or OPEN), what is the target hire date if open?"

The scribe (the agent) captures:

- Seat name (function-based, not title-based: "Owns end-to-end revenue: marketing, sales, account management" not "Chief Revenue Officer").
- Five major roles.
- Current occupant or "OPEN".
- Reporting line (every seat reports to exactly one seat above it).

Sales/Marketing typically gets 3-7 seats beneath the function head. Operations 3-10. Finance 2-5.

The agent does not let the team get pulled into the lowest level of the org. The Accountability Chart goes down to the manager level. Below that, the structure within each function is the function head's job to maintain.

### Pass 4: Surface Gaps and Overlaps (60 min)

Walk the chart top to bottom. For each seat:

- **One person, the right person, in the seat?** Note as filled.
- **Two people in the same seat?** Note as over-filled. Either split the seat (two distinct accountabilities) or pick the one person.
- **Empty seat with a hire planned?** Note the target hire date.
- **Wishful seat with no hire plan?** Either commit to the hire or remove the seat.
- **Person in two seats?** Note. Either they grow into both permanently (rare) or one of the two seats gets transferred (usual).

The chart usually surfaces 3-7 structural issues at first draft. Each one becomes an item on the Issues List.

### Pass 5: Ask the Three Questions (30 min)

The agent asks Wickman's three questions, in order:

1. **Is this the right structure to get us to the next level?** If no, the chart needs another pass.
2. **Are all of the right people in the right seats?** If no, surface which people and which seats. Flag them for the [People Analyzer](https://traction.wiki/tools/people-analyzer) workshop.
3. **Does everyone have enough time to do the job well?** If no, surface who is at 120% and flag for Delegate and Elevate.

A "yes" on all three confirms the chart is at 100%. A "no" on any of the three drives next steps captured as Issues.

## Outputs

The agent produces a single file at `accountability-chart.md` in the business-instance repo:

```markdown
# Accountability Chart — YYYY-MM-DD

## Visionary

**Name**: <name> (or "OPEN, target hire <date>")

**Five Major Roles**:
1. <role>
2. <role>
3. <role>
4. <role>
5. <role>

## Integrator

**Name**: <name>

**Five Major Roles**:
1. <role>
2. <role>
3. <role>
4. <role>
5. <role>

## Function Heads (report to Integrator)

### Sales/Marketing

**Seat name**: <function-based name>
**Name**: <name>
**Five Major Roles**: 1. ... 2. ... 3. ... 4. ... 5. ...

### Operations

**Seat name**: <function-based name>
**Name**: <name>
**Five Major Roles**: 1. ... 2. ... 3. ... 4. ... 5. ...

### Finance

**Seat name**: <function-based name>
**Name**: <name>
**Five Major Roles**: 1. ... 2. ... 3. ... 4. ... 5. ...

## Seats Beneath Each Function Head

### Sales/Marketing team (reports to <function head>)

- **<Seat>**: <name or OPEN>. Five roles: ...
- **<Seat>**: <name or OPEN>. Five roles: ...

### Operations team (reports to <function head>)

- **<Seat>**: <name or OPEN>. Five roles: ...

### Finance team (reports to <function head>)

- **<Seat>**: <name or OPEN>. Five roles: ...

## Gaps

| Seat | Reports To | Target Hire Date | Notes |
|---|---|---|---|
| <Seat> | <function head> | <date> | <budget, search firm, etc.> |

## Notes

- <Visionary/Integrator split decision, e.g., "Founder is currently Visionary + Integrator. Hiring Integrator by Q3.">
- <Any structural decision the team made during the workshop>
- <Date this chart was last refreshed>

## Surfaced Issues

These go on the Issues List for the next L10:

- <Issue>
- <Issue>
```

Additionally:

- If the V/TO has an Accountability Chart reference, update it to point at the new version.
- Add any structural Issues surfaced to `issues-list.md`.
- If the workshop surfaced Right Person / Wrong Seat or Wrong Person / Right Seat cases, flag them for the next People Analyzer round.

## Failure Modes the Agent Should Catch

- **Drawing the org chart instead of the Accountability Chart.** If the team is just importing existing titles, push back. The Accountability Chart names functions and accountabilities, not titles. Force the rewrite.
- **Two people in the same seat.** "We co-own this function." No. Pick one or split the seat into two distinct accountabilities. Do not move on until resolved.
- **The founder is in five seats and nobody says it out loud.** Common. The agent names it: "I count five seats with your name in them. Which two are you stepping out of in the next 6-12 months?"
- **Wishful seats.** A seat labeled "VP of Engineering" with no name, no plan, no target date is theater. The agent asks: commit to the hire (date, budget) or remove the seat.
- **Dotted lines.** "She reports to me on operations but to him on the customer side." The agent rejects. One reporting line per person. Communication can flow freely across the chart; accountability cannot.
- **Skipping the five-roles discipline.** Three roles under-specifies the seat. Nine roles means the seat is doing too much. Hold the line at five.
- **Building the chart for today instead of the next 6-12 months.** The agent reminds: the chart is forward-looking. If a seat is needed to deliver the 1-Year Plan, draw it now.

## When To Stop

The skill is done when:

- Every seat from Visionary down to the manager level is drawn.
- Every seat has five major roles listed.
- Every seat has a name or "OPEN" with a target hire date.
- Every reporting line is clear with no dotted lines.
- The three questions have been asked and answered.
- Gaps and over-fills are surfaced as Issues.
- The `accountability-chart.md` file is written.

The agent reports back: "Chart complete. Total seats: X. Filled: Y. Open with hire plan: Z. Structural Issues flagged: N." If the workshop surfaced a Visionary/Integrator decision or any wrong-person/wrong-seat case, the agent names it explicitly.

## References

- [Accountability Chart](https://traction.wiki/tools/accountability-chart) — the canonical tool page.
- [Design the Accountability Chart](https://traction.wiki/playbooks/design-the-accountability-chart) — the full workshop.
- [Seat](https://traction.wiki/concepts/seat) — the unit of the chart.
- [Visionary](https://traction.wiki/roles/visionary), [Integrator](https://traction.wiki/roles/integrator) — the top two seats.
- [GWC](https://traction.wiki/concepts/gwc) — the seat-fit filter for any naming decision.
- [Run the People Analyzer](https://traction.wiki/playbooks/run-the-people-analyzer) — the next workshop after this one.
- [People Component](https://traction.wiki/components/people) — the component this strengthens.
