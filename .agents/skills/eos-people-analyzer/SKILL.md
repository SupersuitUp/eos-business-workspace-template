---
name: eos-people-analyzer
description: Run the People Analyzer on a team. Agent scores every person on Core Values alignment (+, +/−, −) and GWC (Get it, Want it, Capacity), sets The Bar explicitly, places each person in one of four quadrants, and writes the 30/60/90-day action plan for anyone below The Bar. Use when the operator says "run the people analyzer", "score the team", "people analyzer round", "check right person / right seat", or invokes /eos-people-analyzer. Expects access to the V/TO (for Core Values) and the Accountability Chart (for seats in scope).
---

> **Workspace root.** Every relative path in this SKILL.md (`vto.md`, `accountability-chart.md`, `issues-list.md`, `BOOTSTRAP.md`, `BOOTSTRAP-COMPLETE.md`, `meeting-notes/`, `rocks/`, `scorecards/`, `people-analyzer/`, `processes/`, `quarterly-conversations/`, `snapshots/`, `.agents/skills/`, `scripts/`) is resolved against the EOS workspace root — the directory that contains `BOOTSTRAP.md`, `AGENTS.md`, and `.agents/skills/`. Before doing anything else, find that directory and `cd` into it. Do not write artifacts to the operator's current working directory if it isn't the workspace root.
>
> Discovery, in order:
>
> 1. **cwd test.** If `./BOOTSTRAP.md` and `./.agents/skills/` both exist, cwd IS the workspace root. Done.
> 2. **Global-install lookup.** Otherwise the skill was invoked globally via a `~/.claude/skills/<prefix>eos-people-analyzer` symlink. Resolve the workspace root with:
>    ```bash
>    LINK=$(find -L ~/.claude/skills -maxdepth 1 -type l -lname "*/.agents/skills/eos-people-analyzer" 2>/dev/null | head -1)
>    [ -n "$LINK" ] && WORKSPACE_ROOT=$(cd "$(readlink -f "$LINK")/../../.." && pwd)
>    ```
> 3. **Multi-workspace tiebreak.** If step 2 finds multiple symlinks (operator runs more than one EOS workspace), match the slash-command prefix the operator just used. Example: `/acme-eos-people-analyzer` → pick the symlink named `acme-eos-people-analyzer`. If you can't tell, ask the operator which workspace to run against.
> 4. **No workspace found.** Halt and tell the operator to `cd` into their EOS workspace, or to run `bash scripts/install-global-skills.sh [prefix]` from inside that workspace to register it for global invocation.
>
> Then `cd "$WORKSPACE_ROOT"` and proceed with the rest of this skill.

# Run the People Analyzer

The People Analyzer is the most uncomfortable tool in the EOS toolkit. It is also the most clarifying. Most leadership teams discover, the first time they run it, that they have been avoiding a People conversation for months or years.

This skill turns the agent into the workshop facilitator and scribe. The agent walks the team through scoring every person against Core Values and GWC, helps set The Bar explicitly, places each person in one of the four quadrants, and produces the action plan with three-strike-rule dates for anyone below The Bar.

The skill works for the leadership team's first round (the team scores themselves), departmental rounds (the function head and a leadership-team peer score the function's direct reports together), and quarterly re-checks.

## Inputs

Before starting, locate or ask for:

- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer), specifically the [Core Values](https://traction.wiki/concepts/core-values) (3-7 of them, with definitions).
- The [Accountability Chart](https://traction.wiki/tools/accountability-chart) so each person's seat is in scope for GWC scoring.
- The list of people being scored. For a leadership round: the 3-7 leadership team members. For a department round: the function head's direct reports.
- The prior People Analyzer round, if one exists.
- Each attendee's pre-work: private draft scores for every person being scored, with 1-2 specific behaviors justifying any plus-minus or minus.

In the business-instance repo:

- `vto.md`
- `accountability-chart.md`
- `people-analyzer/<latest>.md` (prior round, if any)

If no prior round exists, this is the first time and the agent should expect more discomfort and longer scoring per person. If a prior round exists, the agent compares scores to surface trend (someone trending up, someone trending down).

## The Session

The agent runs the workshop in five passes. 3 hours for a leadership round. 1-2 hours per department for cascade rounds.

### Pass 1: Open and Frame (15 min)

The agent states two reminders out loud:

1. **The scores are about behaviors against stated Core Values.** Not about who is fun, who is loyal, who has been here longest. Behaviors against the values the team wrote in the V/TO.
2. **The leadership team goes first.** Nobody scores anyone else until they have been scored. The Visionary first. Then the Integrator. Then each function head.

The agent sets ground rules:

- Every score has to land. No deferring. No "we will figure that one out later."
- Every plus-minus or minus needs a specific behavior naming the moment. Scores without behavioral evidence are unjustifiable.
- If scoring on someone reaches an impasse, the impasse becomes an Issue and the team IDS's it before moving on.

### Pass 2: Score Each Person (15-25 min each)

The agent walks through each person on the list, in order. For a leadership round: Visionary, Integrator, function heads.

For each person:

#### Step A: Score Core Values

For each Core Value (3-7 of them), each other leader, in turn, shares the score they drafted in prep:

- **(+)** consistently lives this value
- **(+/−)** sometimes lives this value, sometimes does not, visible enough to be discussed
- **(−)** does not live this value

For each plus-minus or minus, the leader giving the score names the specific behavior that justifies it. The agent prompts: "What is the moment? What did you see or hear?" Without behavioral evidence, the score is rejected.

Example dialogue the agent should expect:

> "Be Direct: plus-minus. The exit conversation with [name] last month and the way the customer escalation got passed off without a clear hand-off are the two moments I am thinking of."

After all leaders share, the team converges on a single score per Core Value. Where there is disagreement, the team discusses until aligned.

The person being scored listens. Does not defend in the moment. Asks clarifying questions only.

#### Step B: Score GWC

For the person's current seat, three yes/no questions:

- **Get it.** "Do they understand all the in-and-outs of this seat? Have they done it (or similar work) successfully?"
- **Want it.** "Do they genuinely want this seat? Do they show up energized to do this work?"
- **Capacity.** "Do they have the time, energy, intellectual capacity, and life circumstances to execute the seat?"

The agent enforces the rule: *two-of-three is a no*. All three must be yes for the seat fit to hold.

### Pass 3: Set The Bar (20 min)

The agent walks the team through setting The Bar explicitly:

- **Minimum number of pluses.** Default: 3 of 5.
- **Maximum plus-minuses.** Default: 2 of 5.
- **Maximum minuses.** Default: 0.
- **GWC threshold.** Default: yes on all three. Two-of-three is a no.

The agent says: "This is The Bar. It is not aspirational. It is the line below which the team has agreed to act."

For first-time rounds, the agent recommends Wickman's default and lets the team adjust if they have a clear reason. For subsequent rounds, the agent asks: "Is The Bar where we want it, or is it time to raise it?"

### Pass 4: Place Each Person in a Quadrant (20 min)

The agent walks through each scored person and places them in one of four quadrants:

|  | **Right Seat** (GWC all yes) | **Wrong Seat** (any GWC no) |
|---|---|---|
| **Right Person** (above The Bar) | **Quadrant 1.** Invest. Develop, promote, celebrate. | **Quadrant 2.** Move them. Find the right seat. |
| **Wrong Person** (below The Bar) | **Quadrant 3.** The hardest case. Talented but values-misaligned. | **Quadrant 4.** Compounded problem. |

The agent surfaces each placement and reads it back. The team confirms or revises.

### Pass 5: Plan Action for Anyone Below The Bar (25 min)

For each person below The Bar on Core Values, the agent walks the team through the three-strike rule:

1. **Strike One.** Within 7 days: the person's manager has a hard conversation with them. The conversation names the specific values and the specific behaviors. The person gets 30 days to demonstrate change.
2. **Strike Two.** Day 30: re-score. If not above The Bar, second conversation. Another 30 days.
3. **Strike Three.** Day 60: re-score. If still not above The Bar, the person is not going to change in this seat in this company. The leadership team acts.

The agent captures, for each below-The-Bar case:

- Person and current seat.
- Specific values and behaviors at issue.
- Strike-one conversation: owner, date.
- Re-score dates (day 30, day 60).
- What "demonstrating change" looks like behaviorally.

For each Right Person / Wrong Seat case (Quadrant 2), the agent prompts:

- "What is the right seat? Does it exist on the Accountability Chart?"
- If yes: plan the move with a target date.
- If no: the team has to decide whether to create one or whether the person needs to exit.

For each Wrong Person / Right Seat case (Quadrant 3), the agent surfaces the hardest truth: "This is the longest-running EOS failure mode. The instinct is to keep the high performer for the output. Wickman is firm: protecting one Wrong Person costs the whole company. The three-strike rule applies."

### Pass 6: Schedule the Cascade (10 min, leadership rounds only)

The agent confirms:

- Within 30 days: each function head runs a People Analyzer round on their direct reports, with the Integrator (or a peer) as a check.
- Within 60 days: every person in the company has been scored.
- Quarterly thereafter: light re-scoring on the leadership team. Full re-score annually on everyone.

## Outputs

The agent produces a scoring file at `people-analyzer/YYYY-MM-DD-<scope>.md`:

```markdown
# People Analyzer — YYYY-MM-DD — <Leadership / Department Name>

## Core Values Being Scored

1. <Core Value 1>: <definition>
2. <Core Value 2>: <definition>
3. ...

## The Bar

- Minimum pluses: <N>
- Maximum plus-minuses: <N>
- Maximum minuses: <N>
- GWC threshold: yes on all three. Two-of-three is a no.

## Scores

| Person | Seat | <CV1> | <CV2> | <CV3> | <CV4> | <CV5> | Get | Want | Capacity | Above Bar? | Quadrant |
|---|---|---|---|---|---|---|---|---|---|---|---|
| <name> | <seat> | + | +/− | + | + | + | Y | Y | Y | Yes | 1: Right/Right |
| <name> | <seat> | + | + | − | +/− | + | Y | N | Y | No | 3: Wrong Person, Right Seat |
| ... | | | | | | | | | | | |

## Behavioral Evidence

For each plus-minus or minus, the specific behaviors that justified the score:

- **<Person> on <Core Value>**: <behavior 1>; <behavior 2>
- ...

## Action Plan

### Below The Bar (three-strike rule)

| Person | Seat | Values/Behaviors at Issue | Strike-One Conversation Owner | Strike-One Date | Day-30 Re-score | Day-60 Re-score |
|---|---|---|---|---|---|---|
| ... | | | | | | |

### Right Person, Wrong Seat (Quadrant 2)

| Person | Current Seat | Right Seat | Plan | Target Date |
|---|---|---|---|---|
| ... | | | | |

### Wrong Person, Right Seat (Quadrant 3)

(Hardest case. Three-strike rule applies. Listed above in the three-strike-rule table.)

### Wrong Person, Wrong Seat (Quadrant 4)

(Three-strike rule applies. Listed above in the three-strike-rule table. Seat change may also apply.)

## Cascade Schedule

- <Department> round: scheduled for <date>, run by <function head> with <peer check>
- ...

## Notes

- <Anything the team decided during the workshop that does not fit elsewhere>
- <Date of the next leadership re-check>
```

Additionally:

- Each three-strike-rule conversation owner gets a To-Do appended to their tracker with the strike-one date.
- Each re-score date is added to a People Analyzer calendar (or the L10 cadence).
- Any structural Issues (no right seat exists for a Quadrant 2 person, a Core Value definition needs sharpening) go on `issues-list.md`.

This file is sensitive. The agent should confirm with the operator where it lives in the business-instance repo and that access is appropriately controlled. It is for the leadership team. It is not shared company-wide.

## Failure Modes the Agent Should Catch

- **Skipping the self-score.** The team tries to score everyone except themselves. The agent enforces: the Visionary and Integrator go first.
- **Confusing "I like them" with "they live the values."** Likability is not a Core Value. The agent refuses scores that translate to "they are fun" or "they are loyal" and forces the question back to behaviors against the stated values.
- **Scoring without behavioral evidence.** "I just feel like they are a plus-minus." No. The agent prompts: "Name the moment. Name the behavior." Without specifics, the score is rejected.
- **Setting The Bar too low.** A Bar of "5 plus-minuses is fine" is no Bar at all. The agent recommends Wickman's default and pushes back on weakening it.
- **Letting Wrong Person / Right Seat slide.** The longest-running EOS failure mode. The agent names it explicitly: "We have scored this person below The Bar. The three-strike rule starts now. Who has the strike-one conversation, and when?"
- **Skipping the GWC check.** GWC is as load-bearing as Core Values. The agent forces all three yes/no answers for every person.
- **Single-person scoring on cascade rounds.** A function head scoring their own direct reports alone is biased. The agent pairs them with a leadership-team peer.
- **Treating the scoring as the action.** Scoring is preparation. The conversation, the seat change, the three-strike rule is the action. The agent does not close the workshop without dates on the action plan.
- **Avoiding the score because it might be uncomfortable.** The discomfort is the signal. The agent runs the workshop straight through.

## When To Stop

The skill is done when:

- Every person in scope has scores on every Core Value and on GWC.
- Every plus-minus and minus has behavioral evidence captured.
- The Bar is set explicitly.
- Every person is placed in one of the four quadrants.
- For every person below The Bar or in a wrong-seat case: a dated action plan exists with an owner.
- The cascade is scheduled (for leadership rounds).
- The file is written and saved.

The agent reports back: "People Analyzer complete. N people scored. Quadrant 1: X. Quadrant 2: Y. Quadrant 3: Z. Quadrant 4: W. Three-strike-rule conversations scheduled: <list>. Next re-score date: <date>."

If the workshop surfaced any hard truth the team has been avoiding (a high performer who is values-misaligned, a beloved leader in the wrong seat), the agent names it explicitly in the report.

## References

- [People Analyzer](https://traction.wiki/tools/people-analyzer) — the canonical tool page.
- [Run the People Analyzer](https://traction.wiki/playbooks/run-the-people-analyzer) — the full workshop.
- [GWC](https://traction.wiki/concepts/gwc) — the three-question seat filter.
- [Core Values](https://traction.wiki/concepts/core-values) — the cultural ground truth.
- [The Bar](https://traction.wiki/concepts/the-bar) — the minimum acceptable threshold.
- [Right People, Right Seats](https://traction.wiki/concepts/right-people-right-seats) — the framework.
- [Quarterly Conversations](https://traction.wiki/tools/quarterly-conversations) — the venue where the results get communicated.
- [Accountability Chart](https://traction.wiki/tools/accountability-chart) — the prerequisite for GWC scoring.
- [People Component](https://traction.wiki/components/people) — the component this strengthens.
