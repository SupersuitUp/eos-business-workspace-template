---
name: eos-set-quarterly-rocks
description: Set quarterly Rocks for a leader or a leadership team. Agent interviews each leader, drafts 1-3 SMART Rocks aligned to the 1-Year Plan, pressure-tests each Rock against the SMART criteria, and produces the quarterly Rocks artifact. Use when the operator says "let's set Rocks", "quarterly rock setting", "Q1 rocks", or invokes /eos-set-quarterly-rocks. Expects access to the operator's V/TO file (for the 1-Year Plan) and prior quarter's Rocks.
---

# Set Quarterly Rocks

Rocks are 1-3 SMART 90-day priorities per person. This skill turns the agent into the Rocks-setting interviewer. The agent walks each leader through proposing Rocks, validates them against the SMART criteria, and pressure-tests them against the 1-Year Plan.

## Inputs

Before starting, locate or ask for:

- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer), specifically the 1-Year Plan section.
- The prior quarter's Rocks with completion status.
- The list of people setting Rocks (typically the leadership team).
- The quarter being planned (e.g., "Q2 2026").

In the business-instance repo:

- `vto.md`
- `rocks/QYYYY-Q.md` (prior quarter)

## The Session

The agent runs the session in two passes: review and set.

### Pass 1: Review Last Quarter (15 min)

For each leader who set Rocks last quarter:

Prompt: "Last quarter's Rocks. For each: did you hit it, miss it, or partial?"

Capture status. Compute company-wide completion rate.

If completion was below 65%, ask: "Before setting new Rocks, what was the root cause of the misses? Was the execution wrong, the Rocks unrealistic, or both?"

Run a quick IDS on the root cause before proceeding to new Rocks.

### Pass 2: Set New Rocks (per leader, 15-30 min each)

For each leader, in turn:

#### Step 1: Read the 1-Year Plan

The agent reads the relevant section of the 1-Year Plan out loud. Confirms with the leader that they understand which annual goals they own pieces of.

#### Step 2: Brainstorm candidate Rocks

Prompt: "What are the 90-day priorities that, if done, would move your part of the 1-Year Plan forward the most?"

Capture 3-7 candidates. No filtering yet.

#### Step 3: Cut to 1-3

Prompt: "Of these, which 1-3 are the most important to commit to for the quarter? Everything else either becomes sand, or rolls to next quarter, or gets dropped."

The leader picks 1-3. The agent confirms the choice and the cut.

#### Step 4: Make each Rock SMART

For each chosen Rock, the agent validates against the SMART criteria:

- **Specific.** "What exactly will be done?" The Rock must name a concrete deliverable or change.
- **Measurable.** "How will we know it is done?" A number, a status, a binary check.
- **Attainable.** "Is this plausibly doable in 90 days?" Reality check.
- **Realistic.** "Do you have the time, budget, and authority?" If not, name what is missing.
- **Timely.** "By exactly what date?" Quarter-end is typical. Earlier if appropriate.

If any criterion fails, the agent helps the leader rewrite the Rock until it passes.

Example walkthrough:

> Leader: "Improve our sales process."
>
> Agent: "Specific?"
>
> Leader: "Get the new sales playbook out."
>
> Agent: "More specific. What does 'out' mean?"
>
> Leader: "All five sales reps trained on the new playbook and using it in their pipeline."
>
> Agent: "Measurable?"
>
> Leader: "100% adoption."
>
> Agent: "By when?"
>
> Leader: "End of quarter."
>
> Agent: "So the SMART version is: 'All five sales reps trained on the new playbook and using it in their pipeline by March 31.' Confirm?"

#### Step 5: Cascade check

Prompt: "Does this Rock trace back to a specific 1-Year Plan goal?" If yes, name the goal. If no, the Rock is suspect. Either rewrite or drop.

### Pass 3: Company Rocks (if leadership team setting together)

After each leader has their personal Rocks, the team identifies which Rocks elevate to *company-level* Rocks (3-7 of them, on the V/TO). Usually a mix of cross-cutting initiatives and the most important individual Rocks.

### Pass 4: Issues List Refresh

Pull issues that emerged during the session. Add to the Issues List for upcoming L10 IDS.

## Outputs

The agent produces a Rocks file at `rocks/QYYYY-Q.md`:

```markdown
# Rocks — QYYYY-Q

## Last Quarter Completion
- Overall: <X>%
- <Leader>: hit/miss/partial summary
- ...

## Company Rocks (3-7)

### Rock 1: <SMART Rock statement>
- **Owner**: <name>
- **Due**: <date>
- **Cascades from**: <1-Year Plan goal>
- **Status (weekly)**: <link to Scorecard or Rock tracking>

### Rock 2: <SMART Rock statement>
...

## Personal Rocks

### <Leader name>
1. <SMART Rock 1>
   - Due: <date>
   - Cascades from: <1-Year Plan goal>
2. <SMART Rock 2>
3. <SMART Rock 3>

### <Next leader>
...
```

Additionally, append the new Rocks to the V/TO's quarterly Rocks section.

## Failure Modes the Agent Should Catch

- **Too many Rocks.** If a leader proposes 5+ Rocks, push back. "1-3 is the discipline. Which two get cut?"
- **Vague Rocks.** Run SMART on every Rock. Reject anything that fails.
- **Disconnected Rocks.** If a Rock does not trace to the 1-Year Plan, ask why. If no good answer, cut it.
- **Sand pretending to be a Rock.** "Stay on top of email" is not a Rock. It is a job description. Reject.
- **No cascade check.** Every Rock has to cascade from a 1-Year Plan goal. Force the trace.
- **Skipping the last-quarter review.** Always review what happened before setting what is next.

## When To Stop

The skill is done when:
- Every leader has 1-3 SMART Rocks committed.
- The V/TO Rocks section is updated.
- The Rocks file is written and version-controlled.

The agent reports the total Rock count and any cascade gaps to flag at the first L10 of the new quarter.

## References

- [Rocks](https://traction.wiki/tools/rocks) — the canonical tool page.
- [Set Quarterly Rocks](https://traction.wiki/playbooks/set-quarterly-rocks) — the full workshop.
- [SMART Rocks](https://traction.wiki/concepts/smart-rocks) — the criteria.
- [Rock Completion](https://traction.wiki/concepts/rock-completion) — the 80% standard.
- [Vision/Traction Organizer](https://traction.wiki/tools/vision-traction-organizer) — where company Rocks live.
