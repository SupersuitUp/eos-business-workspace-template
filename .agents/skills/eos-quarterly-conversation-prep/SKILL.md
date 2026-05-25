---
name: eos-quarterly-conversation-prep
description: Prepare a manager for a 60-minute Quarterly Conversation with one direct report. Agent runs a mental People Analyzer on the direct report (Core Values + GWC), reviews last quarter's Rocks and Measurables, surfaces the 1-2 specific pieces of feedback that need to land, and produces a one-page brief the manager walks in with. Use when the operator says "prep me for my Q conversation with X", "Quarterly Conversation prep", "I have a 1-on-1 tomorrow with my direct report", or invokes /eos-quarterly-conversation-prep. Expects access to the V/TO, Accountability Chart, latest People Analyzer round, and the direct report's Rocks history.
---

> **Workspace root.** Every relative path in this SKILL.md (`vto.md`, `accountability-chart.md`, `issues-list.md`, `BOOTSTRAP.md`, `BOOTSTRAP-COMPLETE.md`, `meeting-notes/`, `rocks/`, `scorecards/`, `people-analyzer/`, `processes/`, `quarterly-conversations/`, `snapshots/`, `.agents/skills/`, `scripts/`) is resolved against the EOS workspace root — the directory that contains `BOOTSTRAP.md`, `AGENTS.md`, and `.agents/skills/`. Before doing anything else, find that directory and `cd` into it. Do not write artifacts to the operator's current working directory if it isn't the workspace root.
>
> Discovery, in order:
>
> 1. **cwd test.** If `./BOOTSTRAP.md` and `./.agents/skills/` both exist, cwd IS the workspace root. Done.
> 2. **Global-install lookup.** Otherwise the skill was invoked globally via a `~/.claude/skills/<prefix>eos-quarterly-conversation-prep` symlink. Resolve the workspace root with:
>    ```bash
>    LINK=$(find -L ~/.claude/skills -maxdepth 1 -type l -lname "*/.agents/skills/eos-quarterly-conversation-prep" 2>/dev/null | head -1)
>    [ -n "$LINK" ] && WORKSPACE_ROOT=$(cd "$(readlink -f "$LINK")/../../.." && pwd)
>    ```
> 3. **Multi-workspace tiebreak.** If step 2 finds multiple symlinks (operator runs more than one EOS workspace), match the slash-command prefix the operator just used. Example: `/acme-eos-quarterly-conversation-prep` → pick the symlink named `acme-eos-quarterly-conversation-prep`. If you can't tell, ask the operator which workspace to run against.
> 4. **No workspace found.** Halt and tell the operator to `cd` into their EOS workspace, or to run `bash scripts/install-global-skills.sh [prefix]` from inside that workspace to register it for global invocation.
>
> Then `cd "$WORKSPACE_ROOT"` and proceed with the rest of this skill.

# Quarterly Conversation Prep

The Quarterly Conversation is the People Component's connection ritual: a 60-minute informal manager-direct-report 1-on-1 every 90 days. Two prompts, both directions: *what's working*, *what's not*. No PowerPoint. No formal evaluation form. The conversation is the artifact.

The discipline that makes the 60 minutes produce real signal is the manager's prep. A manager who walks in without prep delivers vague feedback. A manager who has run a mental People Analyzer, reviewed the direct report's Rocks, and named the 1-2 specific behaviors to raise walks in ready.

This skill turns the agent into the prep coach. The agent walks the manager through scoring the direct report on Core Values and GWC, reviewing the quarter's Rocks and Measurables, and naming the specific feedback that needs to land. The output is a one-page brief the manager carries into the conversation.

The brief is for the manager only. It is not handed to the direct report. The Analyzer score informs the conversation; the conversation is what the direct report experiences.

## Inputs

Before starting, locate or ask for:

- The direct report's name and their seat on the Accountability Chart.
- The manager's name (often the operator running the skill).
- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer), specifically the [Core Values](https://traction.wiki/concepts/core-values) (with definitions).
- The [Accountability Chart](https://traction.wiki/tools/accountability-chart) entry for the direct report's seat (the five major roles inform GWC).
- The latest [People Analyzer](https://traction.wiki/tools/people-analyzer) round that included this person, if any.
- The direct report's current and prior quarter's [Rocks](https://traction.wiki/tools/rocks) with completion status.
- The direct report's weekly [Measurables](https://traction.wiki/concepts/measurable) (their cell on the Scorecard).
- The prior Quarterly Conversation notes (the manager's private 3-5 bullets), if any.
- Any specific moments the manager has been holding onto for 30-60 days that need to land.

In the business-instance repo:

- `vto.md`
- `accountability-chart.md`
- `people-analyzer/<latest>.md`
- `rocks/QYYYY-Q.md` (current and prior)
- `scorecards/company.md` and any `scorecards/<department>.md` containing this person
- `quarterly-conversations/<direct-report-slug>/YYYY-MM-DD.md` (prior notes, if the manager keeps them)

## The Session

The agent runs the prep in five passes. 15-25 minutes total. The manager runs through the questions with the agent the day or two before the conversation.

### Pass 1: Frame the Conversation (2 min)

The agent reminds the manager of the framing:

> "This is a conversation, not a review. Two prompts, both directions: what's working, what's not. 60 minutes. No document, no rating, no HR file. The point is to keep the circles connected, not to evaluate. Hold the line on the framing in the opening 5 minutes of the conversation, or the direct report will treat it like a performance review and edit themselves."

If this is the manager's first Quarterly Conversation, the agent walks them through the 60-minute structure briefly:

- 0:00-0:05 — Set the frame.
- 0:05-0:25 — What's working (direct report first 10 min, manager second 10 min).
- 0:25-0:50 — What's not working (direct report first 10 min, manager second 15 min).
- 0:50-0:55 — Forward look: 1-2 focus areas, what the direct report needs from the manager, next conversation date.
- 0:55-1:00 — Close: verbal summary.

### Pass 2: Mental People Analyzer (8 min)

The agent walks the manager through scoring the direct report:

#### Core Values

For each Core Value (3-7 of them, from the V/TO), the agent prompts:

- "Score: plus, plus-minus, or minus?"
- "If plus-minus or minus: name the specific behavior. What moment? What did you see or hear?"

The agent does not let the manager give a score without behavioral evidence. If the manager hesitates, the agent prompts: "Think of the last 30-60 days. Is there a moment? If nothing comes to mind, the score is plus."

#### GWC

For the direct report's current seat (five major roles from the Accountability Chart):

- **Get it.** "Do they understand all the in-and-outs of this seat? Have they done it successfully?"
- **Want it.** "Do they genuinely want this seat? Do they show up energized to do this work?"
- **Capacity.** "Do they have the time, energy, intellectual capacity, and life circumstances to execute the seat?"

All three must be yes. Two-of-three is a no.

If a Core Value scored plus-minus or minus, or a GWC dimension scored no, the agent flags it for the *What's not working* section of the conversation.

### Pass 3: Review Rocks and Measurables (5 min)

The agent reads the direct report's Rocks and weekly numbers out loud, with the manager:

- **Last quarter's Rocks.** Hit, missed, partial? Pattern over multiple quarters?
- **Weekly Measurables.** On track or off track most weeks? Any three-reds-in-a-row patterns?
- **Current quarter's Rocks.** On track at the midpoint of the quarter? Any at risk?

The agent prompts: "What does the pattern tell you about Get-it, Want-it, or Capacity? Does any of this overlap with the People Analyzer scores you just gave?"

### Pass 4: Review Prior Conversation and Surface Held Feedback (5 min)

The agent prompts:

- "What were the 1-2 focus areas the direct report committed to in the last Quarterly Conversation? Did they hit them?"
- "Is there feedback you have been holding onto for 30-60 days? Name it. Today is when it needs to land."

The agent reminds the manager: *Surprising the direct report with major feedback for the first time in a Quarterly Conversation is a failure mode.* If the manager has been holding onto something this big, the agent flags it. The Quarterly Conversation reinforces and contextualizes feedback. It does not replace in-the-moment feedback. If the manager has genuinely been holding for 60 days, the conversation has to be especially careful: acknowledge the delay, deliver the feedback specifically, and commit to in-the-moment delivery going forward.

If a Core Values violation has hit three-strike-rule territory, the agent flags it: "That conversation is a separate, explicit, documented conversation. The Quarterly Conversation can surface the pattern. It is not the formal disciplinary conversation."

### Pass 5: Draft the Talking Points (5 min)

The agent helps the manager draft the *What's working* and *What's not working* talking points for the manager's side of the conversation. Specific. Behavioral. Earned.

For *What's working*:

- 2-3 specific moments or wins the manager observed.
- A strength the manager wants to call out.

For *What's not working*:

- 1-2 specific behaviors grounded in the People Analyzer score (e.g., a plus-minus on a Core Value with the moment cited).
- Any GWC dimension at risk (e.g., a Want concern, framed as a question: "I have been wondering whether you are still Wanting this seat. Tell me what you are seeing.").
- The pattern from Rocks/Measurables if relevant.

The agent reminds the manager: "Both sides answer both prompts. The direct report goes first in each segment. Listen before you talk."

## Outputs

The agent produces a one-page brief at `quarterly-conversations/<direct-report-slug>/YYYY-MM-DD-prep.md`:

```markdown
# Quarterly Conversation Prep — <direct report name> — YYYY-MM-DD

*Manager: <name>. Direct report: <name>. Scheduled: <date and time>. 60 minutes, private setting.*

## Frame (load-bearing opening)

> "This is a conversation, not a review. I want to hear from you about what's working and what's not. I'll share the same from my side. Nothing here goes in a file."

## Mental People Analyzer

### Core Values

| Core Value | Score | Behavioral Evidence |
|---|---|---|
| <Core Value 1> | + / +/− / − | <moment, if not a plus> |
| <Core Value 2> | + / +/− / − | <moment, if not a plus> |
| ... | | |

Above The Bar: <yes / no>

### GWC for <seat name>

| Dimension | Score | Note |
|---|---|---|
| Get it | Y / N | <observation> |
| Want it | Y / N | <observation> |
| Capacity | Y / N | <observation> |

All three yes: <yes / no>

Quadrant: <1: Right/Right | 2: Right/Wrong | 3: Wrong/Right | 4: Wrong/Wrong>

## Rocks and Measurables Pattern

- **Last quarter's Rocks**: <hit, missed, partial>. Pattern: <observation>.
- **Current quarter's Rocks at midpoint**: <on track / at risk>.
- **Weekly Measurables**: <on track / mixed / three-reds patterns>.
- **Pattern's meaning**: <what this signals about Get, Want, or Capacity>.

## Prior Conversation Follow-Up

- Focus areas the direct report committed to last quarter: <list>.
- Did they hit them: <yes / partial / no>.

## Talking Points the Manager Will Raise

### What's working (manager's side, 10 min)

- <Specific moment 1 the manager wants to call out>
- <Specific moment 2>
- <Strength to reinforce>

### What's not working (manager's side, 15 min)

- <Specific behavior 1, tied to Core Value score>
- <Specific behavior 2, tied to Core Value or GWC>
- <Pattern from Rocks/Measurables, if relevant>

### Held feedback (delivered today, no later)

- <Feedback the manager has been holding for 30-60 days, specific moment cited>

## Likely Forward Look

Anticipated 1-2 focus areas for next quarter:

- <Focus area 1, tied to next quarter's Rocks or to a Core Value gap>
- <Focus area 2>

## Flags

- <Anything that needs a separate conversation (three-strike rule, seat change, hire decision) — do NOT try to handle in the Quarterly Conversation>
- <Anything to surface at the next L10 as an Issue>

## Next Quarterly Conversation

- Suggested date to propose: <date 90 days out>
```

After the actual Quarterly Conversation happens, the manager may keep a private 3-5 bullet note at `quarterly-conversations/<direct-report-slug>/YYYY-MM-DD.md` capturing focus areas committed to and any L10 Issues to surface. That note is the manager's working reference, not an HR file.

## Failure Modes the Agent Should Catch

- **Manager skipping the prep entirely.** A manager who has not done the mental People Analyzer walks in delivering vague feedback. The agent does not let the prep close without specific behavioral evidence for each plus-minus or minus.
- **Scoring without behavioral evidence.** "She is a plus-minus on Be Direct, I just feel it." No. The agent prompts: "Name the moment." Without specifics, the feedback in the conversation will fail.
- **Treating the brief as a performance review document.** This is for the manager only. The agent reminds: do not hand this to the direct report. The Analyzer informs the conversation; the conversation is what the direct report experiences.
- **Avoiding the hard feedback.** *What's not working* is where the value is. A brief with no manager-side concerns is a brief from a manager who is avoiding the conversation. The agent pushes: "What have you been holding onto?"
- **Trying to deliver three-strike-rule feedback in the Quarterly Conversation.** If a Core Values violation has hit strike-two, the formal conversation is separate. The agent flags it explicitly and recommends the manager schedule the three-strike conversation outside this Quarterly Conversation.
- **Surprising the direct report with 60-day-old major feedback for the first time.** If the manager has been holding a major issue for 60+ days, that is a feedback-cadence failure. The agent flags it and recommends the manager acknowledge the delay in the conversation and commit to in-the-moment feedback going forward.
- **One-way conversation prep.** A brief that only lists what the manager wants to raise, with no anticipation of what the direct report might bring, is incomplete. The agent prompts: "What might be on their mind? What might they raise as not working?"
- **Surfacing structural issues that belong elsewhere.** A wrong-seat case, a hire decision, or a Core Values minus that needs three-strike-rule treatment is not the agenda for the Quarterly Conversation. The agent flags those to the L10 Issues List or to a separate explicit conversation.

## When To Stop

The skill is done when:

- The Mental People Analyzer is filled in with scores and behavioral evidence.
- The Rocks/Measurables pattern is captured.
- Prior conversation follow-up is reviewed.
- The manager's *What's working* and *What's not working* talking points are drafted, specific and earned.
- Any held feedback is named and ready to land.
- Anticipated forward-look focus areas are drafted.
- Flags for separate conversations or L10 Issues are surfaced.
- The brief is written to `quarterly-conversations/<direct-report-slug>/YYYY-MM-DD-prep.md`.

The agent reports back: "Prep complete. Quadrant: <X>. Manager-side talking points: <N>. Held feedback to deliver: <yes/no>. Flags: <list>. Conversation scheduled <date>."

## References

- [Quarterly Conversations](https://traction.wiki/tools/quarterly-conversations) — the canonical tool page.
- [Run a Quarterly Conversation](https://traction.wiki/playbooks/run-a-quarterly-conversation) — the full session structure.
- [People Analyzer](https://traction.wiki/tools/people-analyzer) — the prep tool.
- [GWC](https://traction.wiki/concepts/gwc) — one of the manager's scoring dimensions.
- [Core Values](https://traction.wiki/concepts/core-values) — the other scoring dimension.
- [Keepin' the Circles Connected](https://traction.wiki/concepts/keepin-the-circles-connected) — the underlying principle.
- [Open and Honest Communication](https://traction.wiki/concepts/open-and-honest-communication) — the broader principle.
- [Accountability Chart](https://traction.wiki/tools/accountability-chart) — the source of the direct report's seat.
- [People Component](https://traction.wiki/components/people) — the component this serves.
