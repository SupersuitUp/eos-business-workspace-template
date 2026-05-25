---
name: eos-ids-single-issue
description: Run a structured IDS on one issue outside of an L10. Agent enforces Identify (Who, Who, 1-Sentence), bounded Discuss (5-10 min), and Solve (one owner, one due date). Use when the operator says "let's IDS this", "we need to solve X", "run an IDS on this issue", "single-issue IDS", or invokes /eos-ids-single-issue. Expects access to the Issues List and the Accountability Chart (to confirm the accountable seat).
---

> **Workspace root.** Every relative path in this SKILL.md (`vto.md`, `accountability-chart.md`, `issues-list.md`, `BOOTSTRAP.md`, `BOOTSTRAP-COMPLETE.md`, `meeting-notes/`, `rocks/`, `scorecards/`, `people-analyzer/`, `processes/`, `quarterly-conversations/`, `snapshots/`, `.agents/skills/`, `scripts/`) is resolved against the EOS workspace root — the directory that contains `BOOTSTRAP.md`, `AGENTS.md`, and `.agents/skills/`. Before doing anything else, find that directory and `cd` into it. Do not write artifacts to the operator's current working directory if it isn't the workspace root.
>
> Discovery, in order:
>
> 1. **cwd test.** If `./BOOTSTRAP.md` and `./.agents/skills/` both exist, cwd IS the workspace root. Done.
> 2. **Global-install lookup.** Otherwise the skill was invoked globally via a `~/.claude/skills/<prefix>eos-ids-single-issue` symlink. Resolve the workspace root with:
>    ```bash
>    LINK=$(find -L ~/.claude/skills -maxdepth 1 -type l -lname "*/.agents/skills/eos-ids-single-issue" 2>/dev/null | head -1)
>    [ -n "$LINK" ] && WORKSPACE_ROOT=$(cd "$(readlink -f "$LINK")/../../.." && pwd)
>    ```
> 3. **Multi-workspace tiebreak.** If step 2 finds multiple symlinks (operator runs more than one EOS workspace), match the slash-command prefix the operator just used. Example: `/acme-eos-ids-single-issue` → pick the symlink named `acme-eos-ids-single-issue`. If you can't tell, ask the operator which workspace to run against.
> 4. **No workspace found.** Halt and tell the operator to `cd` into their EOS workspace, or to run `bash scripts/install-global-skills.sh [prefix]` from inside that workspace to register it for global invocation.
>
> Then `cd "$WORKSPACE_ROOT"` and proceed with the rest of this skill.

# IDS a Single Issue

IDS (Identify, Discuss, Solve) belongs inside the L10. That is where it works best, with the full team present and a bounded 60-minute IDS segment.

Sometimes, though, an issue needs to be resolved outside the L10: a customer escalation that cannot wait until Monday, a hallway conversation that turned into a real issue, a side-meeting with the Integrator and one function head. This skill is for those cases.

The agent runs the same three-step discipline. The risk of doing IDS outside the L10 is skipping Identify and going straight to Discuss, then drifting forever without a Solve. The agent's job is to enforce the order, box the time, and produce the same artifact the L10 would produce: a resolved issue, a To-Do, and (if needed) a Cascading Message.

## Inputs

Before starting, locate or ask for:

- A one-line description of what someone wants to discuss.
- The list of attendees (usually 2-4 people; never more than 5 outside the L10).
- The current [Issues List](https://traction.wiki/concepts/issues-list) (so the agent can confirm whether this issue is already on it, escalate to an existing line, or add a new one).
- The [Accountability Chart](https://traction.wiki/tools/accountability-chart) (to identify which seat owns the underlying area).

In the business-instance repo:

- `issues-list.md`
- `accountability-chart.md`
- `to-dos.md` (or the per-person To-Do tracker)

If the issue is already on the Issues List, the agent references the existing line. If it is not, the agent will add it.

## The Session

The agent runs IDS in three timed steps. Total time: 10-20 minutes. If the discussion needs more than 20 minutes, the issue belongs in the L10 IDS segment, not in a side conversation.

### Step 1: Identify (1-3 min)

The agent enforces [Who, Who, 1-Sentence](https://traction.wiki/concepts/who-who-one-sentence) before any discussion happens.

Prompt 1: "Who is raising this issue?"

The person who put the item on the Issues List, or who just brought it up. Capture the name.

Prompt 2: "Who is accountable to solve it?"

The person whose seat on the Accountability Chart owns the underlying area. The agent cross-references the chart and names the seat. If no seat owns it, the agent flags: "No accountable seat. That is the issue. The fix is structural, not tactical." The conversation either moves to a structural Issue for the next L10, or the team decides which seat will own it going forward.

Prompt 3: "State the actual issue in one sentence."

The agent drills until the one-sentence statement is specific enough to act on. A few examples the agent enforces:

- "Sales is missing target" → "Our top-of-funnel volume is half what it was six months ago."
- "Customer support is bad" → "Median response time has been over 8 hours for the last three weeks."
- "The new hire is not working out" → "The new operations coordinator has missed two of three weekly hand-offs in their first month."

If two attendees disagree about the one-sentence, the agent treats that as the Identify step working. The team has not yet agreed on what the issue actually is. The agent resolves the disagreement before moving to Discuss.

If the one-sentence keeps coming out as multiple issues ("we are losing customers AND onboarding is broken AND pricing is off"), the agent picks one and puts the others back on the Issues List.

### Step 2: Discuss (5-10 min)

The agent sets a timer. The accountable person speaks first. Then anyone with relevant context.

The agent's job during Discuss:

- Keep the conversation on the identified one-sentence. The agent calls "Tangent Alert" if discussion drifts.
- Make sure quiet voices speak.
- Box the time. At 10 minutes, force the Solve.

The agent does not let Discuss become a search for the right answer. Discuss is for mutual understanding, so the accountable person can make the decision. If the team needs more information than is available in the room, the Discuss ends and the Solve becomes a research To-Do.

### Step 3: Solve (1-3 min)

The agent enforces three parts:

1. **What.** "What is the action that will be taken?"
2. **Who.** "Who is accountable for the action? One name."
3. **When.** "When is it due? Specific date."

The agent rejects "we agreed to look into it." That is not a Solve. "Maria will draft the new pricing structure and have it ready for review by next Monday" is a Solve.

If the Solve affects people outside the room, the agent asks: "Is there a Cascading Message? Who tells whom what, via what channel, by when?"

## Outputs

The agent produces two updates:

### 1. Append the resolved issue to `issues-list.md`

```markdown
## Resolved: <one-sentence issue>

- **Resolved on**: YYYY-MM-DD
- **Raised by**: <name>
- **Accountable seat**: <seat name>, <name>
- **Discussion summary**: <2-4 line summary of key points>
- **Solve**: <action>, owned by <name>, due <date>
- **Cascading Message** (if any): <owner> tells <audience> <message> via <channel> by <when>
```

If the issue was already on the Issues List, the agent moves it to a "Resolved" section of the file (or strikes it through, depending on the team's convention) and adds the resolution metadata above.

### 2. Append the To-Do to `to-dos.md` (or per-person tracker)

```markdown
- [ ] <owner>: <action> (due <date>, from IDS YYYY-MM-DD on <issue>)
```

The To-Do gets reviewed in the next L10's To-Do Review segment. If the team has a per-person To-Do tracker, the agent appends there as well.

### 3. If a Cascading Message was decided, append it for tracking

```markdown
- [ ] <owner> tells <audience> <message> via <channel> by <when> (from IDS YYYY-MM-DD on <issue>)
```

## Failure Modes the Agent Should Catch

- **Skipping Identify.** The team starts Discussing without a one-sentence Identify. The agent interrupts: "Hold on. Who, Who, One Sentence first."
- **Multi-sentence "1-sentence."** "We are losing customers because onboarding is bad and the new hire didn't shadow anyone and pricing is also off." That is three issues. The agent picks one and puts the others back on the Issues List.
- **Naming a symptom instead of the issue.** "Customer complaints are up" is a symptom. The agent drills: "What is the underlying issue? Is it staffing, training, the product, the onboarding flow?" Force the team to name the root.
- **No accountable seat.** If no seat on the Accountability Chart owns the area, the agent surfaces that as a structural Issue. The fix is to assign accountability, not to debate the tactical question in a vacuum.
- **Discussing forever.** Discuss is bounded at 5-10 minutes. If the team needs more information to decide, the agent ends Discuss and the Solve becomes a research To-Do: "<owner> gathers <information> by <date>; we IDS again at next L10."
- **Solving without ownership.** "Let's all be more careful with that" is not a Solve. The agent forces one name and one due date.
- **Solving the symptom.** Surface fixes feel productive and fail quietly. The agent drills during Identify so the Solve targets the root, not the surface.
- **Doing IDS in a hallway with too many people.** More than 5 attendees outside the L10 is not a focused IDS, it is a meeting. The agent flags it and recommends moving to the L10 Issues List.

## When To Stop

The skill is done when:

- The one-sentence Identify is captured.
- The accountable seat is named (or its absence is flagged as a structural Issue).
- The Solve has a single owner and a specific due date.
- The Issues List is updated.
- The To-Do is appended to `to-dos.md`.
- Any Cascading Message is captured.

The agent reports back: "IDS complete. Issue: <one sentence>. Solve: <action>, <owner>, due <date>. Cascading Message: <yes/no>."

If the agent had to flag any of the failure modes (no accountable seat, multi-issue, root vs symptom), the agent surfaces those flags explicitly so the team can address them at the next L10.

## References

- [IDS](https://traction.wiki/tools/ids) — the canonical tool page.
- [Who, Who, 1-Sentence](https://traction.wiki/concepts/who-who-one-sentence) — the Identify discipline.
- [Identify](https://traction.wiki/concepts/identify), [Discuss](https://traction.wiki/concepts/discuss), [Solve](https://traction.wiki/concepts/solve) — the three steps.
- [Issues List](https://traction.wiki/concepts/issues-list) — where issues live before and after IDS.
- [To-Dos](https://traction.wiki/concepts/to-dos) — the artifact every Solve produces.
- [Cascading Message](https://traction.wiki/concepts/cascading-message) — the communication artifact.
- [Tangent Alert](https://traction.wiki/concepts/tangent-alert) — the redirect when Discuss drifts.
- [Level 10 Meeting](https://traction.wiki/tools/level-10-meeting) — where IDS normally runs.
- [Issues Component](https://traction.wiki/components/issues) — the component this strengthens.
