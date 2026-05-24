---
name: eos-update-vto
description: Refresh the Vision/Traction Organizer at the annual planning day. Agent walks the leadership team through all eight V/TO questions top to bottom, scores the prior year, runs the team-health exercise, converts a SWOT into the new Issues List, throws out the old 3-Year Picture and builds a fresh one, sets the new 1-Year Plan with 3-7 SMART annual goals, and highlights what changed. Use when the operator says "annual planning day", "refresh the V/TO", "update the V/TO", "annual off-site", or invokes /eos-update-vto. Expects access to the current V/TO, prior-year financials, last quarter's Rocks, and any prior People Analyzer round.
---

# Update the V/TO (Annual Planning Day)

The Annual is the once-a-year stop. Two days off-site. The leadership team reviews the year that just ended, throws out the old 3-Year Picture and builds a new one, sets next year's plan, and walks out with the next quarter's Rocks committed.

The discipline is that *nothing in the V/TO is sacred for two days*. Core Values, Core Focus, 10-Year Target, Marketing Strategy: every question gets re-examined. Most years the answers hold. Some years one of them breaks open. The Annual is where that surfaces.

This skill turns the agent into the day-one facilitator and scribe. The agent walks the leadership team through the prior-year review, the team-health exercise, the SWOT-to-Issues conversion, and the V/TO top-to-bottom refresh. It updates the `vto.md` file in place and produces a clear diff: what changed, what held, what got rewritten.

Day two (the new quarterly Rocks) is handled by the `eos-set-quarterly-rocks` skill. This skill ends after day one.

## Inputs

Before starting, locate or ask for:

- The current [V/TO](https://traction.wiki/tools/vision-traction-organizer) (all 8 questions).
- Prior-year financials: revenue, profit, gross margin, the V/TO's key measurable.
- Last quarter's [Rocks](https://traction.wiki/tools/rocks) with hit/miss status.
- Prior-year goals from the V/TO's 1-Year Plan, with done/not-done status.
- The current [Accountability Chart](https://traction.wiki/tools/accountability-chart).
- The latest [People Analyzer](https://traction.wiki/tools/people-analyzer) round.
- The current [Issues List](https://traction.wiki/concepts/issues-list).
- Each attendee's pre-work: notes on what they think needs revising, their three biggest company-wide accomplishments of the year, their one biggest personal accomplishment, and their expectations for the two days.
- The proposed budget for the coming year (or the inputs to one).

In the business-instance repo:

- `vto.md` (current, will be updated in place)
- `rocks/QYYYY-Q.md` (last quarter)
- `scorecards/company.md` (for prior-year measurables)
- `accountability-chart.md`
- `people-analyzer/<latest>.md`
- `issues-list.md`
- `meeting-notes/` (prior quarterly notes)

If the V/TO does not exist, this skill is the wrong skill. Run the V/TO Build playbook first (a different first-time workshop).

## The Session

Day one of the Annual. 8 hours off-site. The agent runs seven passes.

### Pass 1: Open and Segue (60 min)

The agent prompts the Integrator to open. Then runs the segue:

Each leader, in turn, shares three things from prep:

1. The three biggest things the company accomplished this past year.
2. Their one biggest personal accomplishment.
3. Their expectations for these two days.

The agent captures the accomplishments. This is not throwaway. After hearing each other, the team usually realizes the year was better than the day-to-day memory says it was. That mindset matters for the rest of the session.

### Pass 2: Review the Previous Year (60 min)

The agent walks the team through:

- **Prior-year goals, one at a time.** Each one: done or not done. No partials, no "kinda." The agent computes the percentage.
- **Prior-year financials.** Revenue, profit, gross margin, key measurable. Compare to plan.
- **Last quarter's Rocks.** Hit or miss.
- **For each miss.** Prompt: "What did we learn? Is there an issue here that warrants IDS?" Capture as an Issue if yes.

Target: 80%+ goal completion. If the percentage is below 65%, the agent pauses: "Either the goals were unrealistic or execution broke down. Either way, the team has to understand the root cause before setting next year's plan." Run a quick IDS on the root cause before proceeding.

### Pass 3: Team Health Building (2 hours)

The agent runs Wickman's *One Thing* exercise (or another structured team-health exercise the team prefers).

For each leader, in turn:

- Every other leader shares, out loud, with everyone present:
  1. The leader's single greatest strength or most admirable ability.
  2. The leader's biggest weakness or hindrance to the success of the company.
- The leader hears the feedback. Asks clarifying questions only. Does not defend in the moment.
- After hearing the feedback, the leader commits to one thing they will do differently in the coming year.

The agent captures each leader's One Thing commitment.

The agent reminds the team: this is in the open, with everyone present. Not anonymous. The leadership team is the bottleneck of the company. The Annual is the one time a year the team explicitly works on itself.

### Pass 4: SWOT and Issues List (75 min)

The agent runs a SWOT:

- **Strengths.** Each leader shares.
- **Weaknesses.** Each leader shares.
- **Opportunities.** Each leader shares.
- **Threats.** Each leader shares.

Capture everything. Then extract the issues. Every weakness, every threat, every unconverted opportunity becomes a line on the new [Issues List](https://traction.wiki/concepts/issues-list). This list, plus anything that surfaces over the rest of day one, is what day two's IDS works through.

The agent rewrites `issues-list.md` with the SWOT-generated list and notes which existing issues carry forward.

### Pass 5: V/TO Refresh, Question by Question (3 hours)

The agent walks the V/TO top to bottom. Nothing is sacred. For each question, the agent prompts the team, captures the answer, and diffs old to new.

#### Core Values (30 min)

Prompts:

- "Are they still the right values?"
- "Still 3-7?"
- "Still ones the team would hire and fire on?"

Usually they hold. Occasionally a value gets dropped or sharpened. If a value is dropped or added, the agent captures the reason in the meeting notes.

#### Core Focus (30 min)

Prompts:

- "Is the Purpose still right?"
- "Is the Niche still right?"
- "Has any revenue line drifted outside the Core Focus this year? If yes, what is the decision: cut it, or update the Core Focus to acknowledge it?"

#### 10-Year Target (15 min)

Prompts:

- "Is the 10-Year Target still the right one?"
- "Are we on pace? Ahead? Behind?"

Usually confirm. If revised, the agent captures the reason explicitly. Revising the 10-Year Target is rare and consequential.

#### Marketing Strategy (30 min)

Prompts:

- "Target Market: still right?"
- "3 Uniques: still right?"
- "Proven Process: still right?"
- "Guarantee: still right?"
- "Has the market shifted? Have competitors moved? Have we learned something about who actually buys?"

#### 3-Year Picture (45 min)

The agent enforces the discipline: *throw out the old one and build a fresh one*. Do not edit. Do not anchor.

Prompts:

- "New revenue target for 3 years out?"
- "New profit target?"
- "One key measurable?"
- "5-15 vivid descriptive bullets. What does the company look like? How many people, how many markets, what is the operating cadence, what is the NPS, what is the team mood, what does a Tuesday afternoon look like inside the company?"

The agent captures the new 3-Year Picture and writes the old one to the meeting notes as the diff record.

#### 1-Year Plan (30 min)

Prompts:

- "Revenue for the coming year?"
- "Profit?"
- "Key measurable?"
- "3-7 annual goals. Each one SMART. Each one cascading from the new 3-Year Picture."

If the 1-Year Plan does not finish in this slot, the agent lets it carry into day two. The agenda for day two has room.

### Pass 6: Diff Old to New (15 min)

The agent reads the diff out loud:

- Core Values: <changed / unchanged>. <If changed, what.>
- Core Focus: <changed / unchanged>. <If changed, what.>
- 10-Year Target: <changed / unchanged>.
- Marketing Strategy: <changed / unchanged>.
- 3-Year Picture: rewritten. Old → new.
- 1-Year Plan: replaced. Old goals (hit/miss) → new goals.
- Issues List: replaced with the SWOT-generated list, plus carry-forwards.

The team confirms. The agent rewrites `vto.md` with the new content. Git history preserves the old version.

### Pass 7: Close Day One (15 min)

The agent confirms:

- Day two starts at <time> with the new quarter's Rocks-setting workshop (handed off to the `eos-set-quarterly-rocks` skill).
- The Rocks set on day two cascade from the new 1-Year Plan.
- The Issues List for day two's IDS is the SWOT-generated list.

The agent reminds the team: dinner together tonight, hold the off-site frame, no real-world calls.

## Outputs

### 1. Updated `vto.md` (in place)

```markdown
# Vision/Traction Organizer

*Last refreshed: YYYY-MM-DD (Annual Planning Day)*

## Side One: The Vision

### Core Values
1. <Core Value>: <definition>
2. ...

### Core Focus
- **Purpose**: <statement>
- **Niche**: <statement>

### 10-Year Target
<statement>

### Marketing Strategy
- **Target Market**: <description>
- **3 Uniques**: <list>
- **Proven Process**: <description>
- **Guarantee**: <statement>

## Side Two: The Traction

### 3-Year Picture
- **Date**: <3 years from now>
- **Revenue**: $<amount>
- **Profit**: $<amount>
- **Key Measurable**: <metric and target>
- **5-15 descriptive bullets**:
  - <bullet>
  - <bullet>
  - ...

### 1-Year Plan
- **Date**: <end of next year>
- **Revenue**: $<amount>
- **Profit**: $<amount>
- **Key Measurable**: <metric and target>
- **3-7 Annual Goals** (each SMART):
  1. <goal>
  2. <goal>
  3. ...

### Rocks (this quarter)
*To be set on day two. See `rocks/QYYYY-Q.md` after day two.*

### Issues List
*See `issues-list.md`. Updated with SWOT output from Annual Planning Day YYYY-MM-DD.*
```

### 2. Annual Planning meeting notes at `meeting-notes/YYYY-MM-DD-annual-planning.md`

```markdown
# Annual Planning Day — YYYY-MM-DD

## Attendees
- <leadership team>

## Prior-Year Scorecard

| Goal | Status | Notes |
|---|---|---|
| ... | done / not done | ... |

- **Overall goal completion**: <X>%
- **Prior-year revenue**: $<amount> (plan: $<amount>)
- **Prior-year profit**: $<amount> (plan: $<amount>)
- **Last quarter Rock completion**: <X>%

## Segue Highlights

- Three biggest company accomplishments (synthesis): <list>
- One Thing commitments (one per leader):
  - <Leader>: <commitment>
  - <Leader>: <commitment>
  - ...

## SWOT Output

### Strengths
- ...

### Weaknesses
- ...

### Opportunities
- ...

### Threats
- ...

### Issues extracted (now on the new Issues List)
- ...

## V/TO Diff

### Core Values
- **Changed**: yes / no
- **Old → new**: <if changed>
- **Reason**: <if changed>

### Core Focus
- **Changed**: yes / no
- **Old → new**: <if changed>

### 10-Year Target
- **Changed**: yes / no
- **Old → new**: <if changed>

### Marketing Strategy
- **Changed**: yes / no
- **Old → new**: <if changed>

### 3-Year Picture (rewritten from scratch)
- **Old**: <prior 3-Year Picture, summarized>
- **New**: <link to V/TO section>

### 1-Year Plan (replaced)
- **Prior year goals + status**: <list with hit/miss>
- **New 1-Year Plan**: <link to V/TO section>

## Day Two Agenda
- Quarterly Rocks-setting workshop (see `eos-set-quarterly-rocks` skill output).
- Top 1-2 strategic issues from the SWOT-generated Issues List worked through IDS.
```

### 3. Updated `issues-list.md`

Replaced with the SWOT-generated list, with carry-forward issues from the prior list noted.

## Failure Modes the Agent Should Catch

- **Treating it like another quarterly.** The Annual is the one time a year the V/TO gets re-examined top to bottom and the 3-Year Picture gets thrown out. If the team starts skimming, the agent slows down: "We are throwing out the 3-Year Picture, not editing it. Build it fresh."
- **Skipping the team-health exercise.** "We are too busy for the One Thing exercise this year." The agent pushes back. The team-health work is the only agenda item that explicitly invests in the team itself.
- **Keeping the old 3-Year Picture.** Editing the old one instead of rewriting it. The agent enforces: write the new one from a blank page, then diff after.
- **Reviewing the year defensively.** Each leader explaining why their missed goal was reasonable. The agent redirects: "Score the goals, capture the learnings as issues, move on. The point is to learn, not to litigate."
- **Letting the Annual drift to two long days at the office.** The off-site is part of the tool. If the operator is trying to run the workshop in the conference room down the hall, the agent flags it and recommends the off-site.
- **Setting too many annual goals.** 3-7 in the 1-Year Plan, not 12. The agent holds the line.
- **Skipping day two.** A team that does the Annual but pushes the new Rocks to "next week's planning meeting" loses the energy of the off-site. The agent confirms day two is on the calendar before closing day one.
- **Inviting observers.** Board members, advisors, spouses sitting in. The agent flags this at the start of pass 1 and recommends they not attend.
- **Letting Core Values drift to a marketing list.** If the team is adding a Core Value because it sounds good for recruiting, the agent pushes back: "Would the team hire and fire on this value? If not, it does not belong."
- **Vague 3-Year Picture.** "We will be a leader in our space" is not a Picture. The agent forces specificity: "What does the company look like? Vivid enough that a new hire could draw it."

## When To Stop

The skill is done when:

- Prior-year goals are scored with done/not-done.
- Prior-year financials and Rock completion are captured.
- Each leader's One Thing commitment is captured.
- SWOT is complete and the new Issues List is written.
- All 8 V/TO questions have been walked through and answered.
- The 3-Year Picture is rewritten from scratch.
- The 1-Year Plan has 3-7 SMART annual goals.
- The `vto.md` file is updated.
- The meeting notes file at `meeting-notes/YYYY-MM-DD-annual-planning.md` is written.
- The `issues-list.md` is updated.
- Day two (quarterly Rocks workshop) is scheduled on the calendar.

The agent reports back: "Annual day one complete. Prior-year goal completion: <X>%. V/TO refreshed. 3-Year Picture rewritten. New 1-Year Plan: <N> goals. New Issues List: <M> items from SWOT. One Thing commitments captured. Day two starts <time> with Rocks-setting."

If any V/TO question changed (Core Values, Core Focus, 10-Year Target, Marketing Strategy), the agent surfaces the change explicitly in the report and recommends a [Cascading Message](https://traction.wiki/concepts/cascading-message) to the rest of the company within two weeks.

## References

- [Vision/Traction Organizer](https://traction.wiki/tools/vision-traction-organizer) — the document this refreshes.
- [Annual Planning Day](https://traction.wiki/playbooks/annual-planning-day) — the full two-day playbook.
- [Set Quarterly Rocks](https://traction.wiki/playbooks/set-quarterly-rocks) — day two's agenda (handled by the `eos-set-quarterly-rocks` skill).
- [Build the V/TO](https://traction.wiki/playbooks/build-the-vto) — the first-time version of this work (different skill).
- [Ninety-Day World](https://traction.wiki/concepts/ninety-day-world) — the rhythm this caps.
- [Core Values](https://traction.wiki/concepts/core-values), [Core Focus](https://traction.wiki/concepts/core-focus), [10-Year Target](https://traction.wiki/concepts/ten-year-target), [Marketing Strategy](https://traction.wiki/concepts/marketing-strategy), [3-Year Picture](https://traction.wiki/concepts/three-year-picture), [1-Year Plan](https://traction.wiki/concepts/one-year-plan) — the questions revisited.
- [Cascading Message](https://traction.wiki/concepts/cascading-message) — the communication artifact for any V/TO change.
- [Vision Component](https://traction.wiki/components/vision) — the component this strengthens.
