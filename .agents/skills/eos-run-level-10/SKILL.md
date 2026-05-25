---
name: eos-run-level-10
description: Run an EOS Level 10 Meeting. Agent acts as Facilitator and Scribe combined. Walks the leadership team (or department team) through the 7-segment agenda, captures To-Dos and Issues live, ends with a meeting rating. Use when the operator says "let's run the L10", "run our Level 10", "weekly leadership meeting", or invokes /eos-run-level-10. Expects access to the operator's V/TO file, current Scorecard, current Rocks, prior week's L10 notes, and current Issues List.
---

> **Workspace root.** Every relative path in this SKILL.md (`vto.md`, `accountability-chart.md`, `issues-list.md`, `BOOTSTRAP.md`, `BOOTSTRAP-COMPLETE.md`, `meeting-notes/`, `rocks/`, `scorecards/`, `people-analyzer/`, `processes/`, `quarterly-conversations/`, `snapshots/`, `.agents/skills/`, `scripts/`) is resolved against the EOS workspace root — the directory that contains `BOOTSTRAP.md`, `AGENTS.md`, and `.agents/skills/`. Before doing anything else, find that directory and `cd` into it. Do not write artifacts to the operator's current working directory if it isn't the workspace root.
>
> Discovery, in order:
>
> 1. **cwd test.** If `./BOOTSTRAP.md` and `./.agents/skills/` both exist, cwd IS the workspace root. Done.
> 2. **Global-install lookup.** Otherwise the skill was invoked globally via a `~/.claude/skills/<prefix>eos-run-level-10` symlink. Resolve the workspace root with:
>    ```bash
>    LINK=$(find -L ~/.claude/skills -maxdepth 1 -type l -lname "*/.agents/skills/eos-run-level-10" 2>/dev/null | head -1)
>    [ -n "$LINK" ] && WORKSPACE_ROOT=$(cd "$(readlink -f "$LINK")/../../.." && pwd)
>    ```
> 3. **Multi-workspace tiebreak.** If step 2 finds multiple symlinks (operator runs more than one EOS workspace), match the slash-command prefix the operator just used. Example: `/acme-eos-run-level-10` → pick the symlink named `acme-eos-run-level-10`. If you can't tell, ask the operator which workspace to run against.
> 4. **No workspace found.** Halt and tell the operator to `cd` into their EOS workspace, or to run `bash scripts/install-global-skills.sh [prefix]` from inside that workspace to register it for global invocation.
>
> Then `cd "$WORKSPACE_ROOT"` and proceed with the rest of this skill.

# Run an EOS Level 10 Meeting

The Level 10 Meeting is the weekly heartbeat of any EOS-run business. 90 minutes. 7 segments. Same day, same time, every week.

This skill turns the agent into the L10 Facilitator and Scribe. The agent walks the team through the agenda, captures status and discussion live, runs the IDS segments, and produces the meeting notes artifact at the end.

## Inputs

Before starting, locate or ask for:

- The team's [V/TO](https://traction.wiki/tools/vision-traction-organizer) (Core Values, Core Focus, current quarterly Rocks).
- The current [Scorecard](https://traction.wiki/tools/scorecard) (metrics, owners, weekly goals, last week's status).
- Each leader's current quarterly [Rocks](https://traction.wiki/tools/rocks) with status.
- The current [Issues List](https://traction.wiki/concepts/issues-list).
- Prior week's L10 notes (for To-Do review).
- The list of attendees.

In the agentic-harness pattern, all of these live as markdown files in the business-instance repo. Default file locations to look for:

- `vto.md`
- `scorecard.md` (or `scorecards/company.md`)
- `rocks/QYYYY-Q.md`
- `issues-list.md`
- `meeting-notes/YYYY-MM-DD-leadership-l10.md` (prior week's)

## The Session

The agent runs the 7-segment agenda. For each segment, the agent prompts the team out loud (or via the harness UI), captures responses, and moves on. Time-box discipline is the agent's job.

### Segment 1: Segue / Good News (5 min)

Prompt: "Quick segue. One personal piece of good news and one professional piece, from each of you. 30 seconds each."

Capture: optional. The Segue is for the humans, not the record.

Move on at 5 minutes.

### Segment 2: Scorecard Review (5 min)

For each metric on the Scorecard, in order:

Prompt the owner: "<Metric name>. Last week: on track or off track?"

Capture the status (on/off track + value).

If off track, ask: "Drop to Issues?" If yes, add to today's Issues List for IDS.

Do not discuss in this segment. Just status.

Move on at 5 minutes.

### Segment 3: Rock Review (5 min)

For each Rock owner, in order:

Prompt: "<Rock name>. On track or off track?"

If off track, ask: "Drop to Issues?" If yes, add to today's Issues List.

Move on at 5 minutes.

### Segment 4: Customer/Employee Headlines (5 min)

Prompt: "Headlines. Customer or employee news, 1-2 sentences each."

Capture each headline.

If anything raises a real issue, drop to Issues List.

Move on at 5 minutes.

### Segment 5: To-Do Review (under 5 min)

For each To-Do from last week's L10:

Prompt the owner: "<To-Do>. Done?"

Capture: done or off-track.

Target: 90%+ completion. If significantly below, note it as a meta-issue for next quarter's review.

Off-track To-Dos either roll forward (re-committed for next week) or become new Issues if they need re-discussion.

Move on under 5 minutes.

### Segment 6: IDS (60 min)

The meat of the meeting.

1. **Survey the Issues List + issues dropped in earlier segments.** Read each issue out loud briefly.
2. **Identify the top 3 priorities for today's IDS time.** Ask the team: "Of these, which 3 most need solving today?" The team votes or the Integrator picks.
3. **For each of the 3 issues, run IDS:**

   **Identify (1-3 min):**
   - Apply [Who, Who, 1-Sentence](https://traction.wiki/concepts/who-who-one-sentence).
   - Ask: "Who is raising this? Who is accountable to solve it? Now state the actual issue in one sentence."
   - Drill until the one-sentence statement is specific enough to act on.

   **Discuss (5-10 min):**
   - Accountable person speaks first.
   - Then the team, in turn.
   - Call "Tangent Alert" if the discussion drifts. The agent should explicitly flag tangents.
   - Box the time. At 10 minutes, force the Solve.

   **Solve (1-3 min):**
   - Ask: "What is the decision? Who owns the action? When is it due?"
   - Capture as a To-Do for next week's meeting.
   - Move on.

4. After 3 issues IDS'd (or 60 minutes elapsed), move to Conclude. Lower-priority issues stay on the list for next week.

### Segment 7: Conclude (5 min)

1. **Recap the To-Dos generated this meeting.** Read each one back. Each owner confirms.
2. **Identify Cascading Messages.** Ask: "Are there any decisions from today that need to be communicated outside this room? Who tells whom what, via what channel, by when?"
3. **Meeting rating.** Go around the room. Each attendee says a number 1-10. Target: 8+.
4. **Note the rating** and any brief feedback.

End on time. 90 minutes.

## Outputs

The agent produces a single meeting notes file at `meeting-notes/YYYY-MM-DD-leadership-l10.md` (or wherever the team's convention is). The file contains:

```markdown
# L10 — YYYY-MM-DD

## Attendees
- <names>

## Scorecard
- Metric A (owner): on track / off track
- Metric B (owner): on track / off track
- ...

## Rocks
- Rock A (owner): on track / off track
- Rock B (owner): on track / off track
- ...

## Headlines
- <brief headlines>

## To-Dos from Last Week
- <to-do>: done / off-track
- ...

## IDS

### Issue 1: <title>
- **Identified**: <one-sentence issue, accountable person>
- **Discussion summary**: <key points>
- **Solve**: <decision, owner, due date>

### Issue 2: <title>
...

### Issue 3: <title>
...

## To-Dos for Next Week
- <owner>: <to-do> (due <date>)
- ...

## Cascading Messages
- <owner> tells <audience> <message> via <channel> by <when>

## Meeting Rating
- <attendee>: <rating>
- ...
- Average: <X.X>
```

Additionally:

- Update `issues-list.md` to remove resolved issues and add any new ones.
- Update `rocks/QYYYY-Q.md` if any Rock status changed substantively.
- Append the To-Dos to a running `to-dos.md` or per-person To-Do tracker.

## Failure Modes the Agent Should Catch

- **Discussion in Scorecard/Rock Review segments.** Cut it off. "That's a great point, drop it to Issues. Moving on."
- **Skipping the Segue.** Push back. The Segue is the warm-up that makes IDS safe.
- **No Identify step.** If the team starts Discussing without a one-sentence Identify, interrupt. "Hold on. Who, Who, One Sentence first."
- **Solving without ownership.** Every Solve needs one name and one due date. Ask both explicitly.
- **Running over time.** Hard 90-minute box. The agent calls time.
- **No meeting rating.** Force every attendee to say a number.

## When To Stop

The skill is done when the meeting notes file is written and the To-Do list for next week is locked. The agent reports the meeting rating average and any flags worth bringing to the next L10.

## References

- [Level 10 Meeting](https://traction.wiki/tools/level-10-meeting) — the canonical tool page.
- [Run Your First Level 10](https://traction.wiki/playbooks/run-your-first-level-10) — the first-time playbook.
- [IDS](https://traction.wiki/tools/ids) — the resolution process.
- [Who, Who, 1-Sentence](https://traction.wiki/concepts/who-who-one-sentence) — the Identify discipline.
