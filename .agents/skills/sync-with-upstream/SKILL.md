---
name: sync-with-upstream
description: Pull the latest updates from the upstream EOS Business Workspace Template (new skills, refined SKILL files, updated artifact templates, refreshed docs) into this workspace without disturbing the operator's filled-in business data. Use when the operator says "sync with upstream", "pull template updates", "get the latest from the template", or any similar phrasing.
---

# Sync With Upstream

Pull updates from the upstream `SupersuitUp/eos-business-workspace-template` into this workspace. Leave the operator's filled-in business data untouched.

## What Upstream Owns (Safe To Update)

- `.agents/skills/` (default EOS skills the template ships)
- `scripts/` (sync helpers)
- `README.md`, `BOOTSTRAP.md`, `CLAUDE.md`, `AGENTS.md`
- Artifact files that have NOT been filled in yet (see heuristic below)

## What Upstream Never Touches (Operator's Files)

- Any artifact file the operator has filled in. This means the actual `vto.md` with the company's Core Values, the actual `accountability-chart.md` with real names, the actual `scorecards/company.md` with real metrics, every `meeting-notes/YYYY-MM-DD-*.md`, every `rocks/Q{YYYY}-{Q}.md`, every `people-analyzer/*.md`, every `processes/*.md`, every `quarterly-conversations/*.md`, every `snapshots/*.md`.
- `BOOTSTRAP-COMPLETE.md` if it exists (operator state).
- Any custom skill directory the operator added themselves under `.agents/skills/` (upstream only ever modifies the named default skills shipped by this template; custom skill names are left alone).

## The "Has This Artifact Been Touched?" Heuristic

The template ships placeholder versions of `vto.md`, `accountability-chart.md`, `issues-list.md`, `scorecards/company.md`, `rocks/Q1-2026.md`, `meeting-notes/L10-TEMPLATE.md`, `people-analyzer/TEMPLATE.md`, `processes/PROCESS-TEMPLATE.md`, `quarterly-conversations/TEMPLATE.md`.

Once the operator runs `eos-bootstrap-business` or any other skill that writes real content, the placeholders get replaced or new dated files appear alongside them.

**An artifact is "still placeholder" (safe to update from upstream) if:**

1. The file still contains its bracketed `[placeholder]` markers, AND
2. The git log shows only one commit on that file (the initial scaffold), AND
3. The file has NOT been listed in `BOOTSTRAP-COMPLETE.md`'s milestones section.

**An artifact is "operator data" (do NOT touch) if:**

- Any of the above heuristics fail, OR
- The file is a dated instance like `meeting-notes/2026-06-03-leadership-l10.md` (only the `L10-TEMPLATE.md` is upstream-owned), OR
- The file is `rocks/Q{YYYY}-{Q}.md` for any quarter the operator has actually been in (the shipped `Q1-2026.md` is the only one upstream-owned, and only if untouched).

If the heuristic is ambiguous, ALWAYS default to "operator data" and skip.

Merge conflicts are only possible in the upstream-owned files (README, BOOTSTRAP, CLAUDE.md, AGENTS.md, default skills the operator customized, untouched placeholder artifacts).

---

## Workflow

### Step 1: Verify the upstream remote, or add it with a disabled push URL

Run:

```bash
git remote -v
```

If `upstream` is not listed, add it now with a disabled push URL (this prevents any accidental `git push upstream` from ever touching the template):

```bash
git remote add upstream https://github.com/SupersuitUp/eos-business-workspace-template.git
git remote set-url --push upstream DISABLED
```

Confirm the push URL shows as `DISABLED`:

```bash
git remote -v
# origin   https://github.com/OWNER/<business-name>.git (fetch)
# origin   https://github.com/OWNER/<business-name>.git (push)
# upstream https://github.com/SupersuitUp/eos-business-workspace-template.git (fetch)
# upstream DISABLED (push)
```

### Step 2: Ensure a clean working tree

```bash
git status
```

If there are uncommitted changes, commit them first (or stash if truly work in progress). Do not proceed with a dirty working tree. If the operator has changes, tell them and wait for their instruction.

### Step 3: Fetch and preview what's coming

```bash
git fetch upstream
git log --oneline HEAD..upstream/main
git diff --name-only HEAD upstream/main
```

Summarize for the operator in plain language:

- How many new commits are incoming
- What files upstream touched (skills, scripts, artifact templates, README)
- Especially call out:
  - **Any new skill directories** that have appeared in `.agents/skills/` (read each `SKILL.md` frontmatter so you can describe what it does)
  - **Any updated artifact templates** that conflict with files the operator has filled in (these get skipped per the heuristic above)

Ask the operator to confirm before merging.

### Step 4: Apply the "Has This Artifact Been Touched?" heuristic

For each artifact file in the incoming diff:

1. Check whether the file in this workspace still contains bracketed `[placeholder]` markers.
2. Check the git log: `git log --oneline -- <path>`. If more than one commit, it's been touched.
3. Check `BOOTSTRAP-COMPLETE.md` if it exists — if it lists a milestone for this file, the file is filled in.

If "still placeholder" on all three: include in merge.
If "operator data" on any: exclude from merge (use `git checkout --ours <path>` after the merge or pre-stage HEAD's version).

### Step 5: Merge

```bash
git merge upstream/main --no-ff -m "Sync with upstream eos-business-workspace-template"
```

### Step 6: Resolve any conflicts

Conflicts are only likely in `README.md`, `BOOTSTRAP.md`, `CLAUDE.md`, `AGENTS.md`, the default skill files the operator customized, or in untouched placeholder artifacts.

For each conflict:

1. Show the operator the file and explain what they had vs. what upstream changed.
2. Propose a merge strategy:
   - For `README.md` / `BOOTSTRAP.md`: usually accept upstream's version since it is the shared docs.
   - For `CLAUDE.md` / `AGENTS.md`: merge both, preserving any operator-added sections.
   - For a customized default skill: offer to rename the operator's version to `.agents/skills/<skill-name>-custom/` (preserving it as its own discoverable skill) and accept upstream's version at the original path, OR keep the operator's version and discard upstream's changes to that skill.
3. Apply the chosen merge, then `git add <files> && git commit`.

### Step 7: Push to origin

```bash
git push origin main
```

Never `git push upstream` anything. The push URL is `DISABLED`, and the operator is not a collaborator on the template repo, but respect the boundary anyway.

### Step 8: Report what arrived

Tell the operator, in a short clear summary:

- **New skills** (name + one-line description from each SKILL.md frontmatter)
- **Updated skills** (what changed, if anything useful)
- **Script changes** (especially if they affect sync or setup)
- **Doc changes** worth knowing about (README, BOOTSTRAP, CLAUDE, AGENTS)
- **Artifact template updates** (only relevant if the operator hasn't filled in the artifact yet)
- **Anything that needs attention** (new environment requirements, breaking changes)

Invite the operator to try the new skills.

---

## Principles

- **The operator's business data is sacred.** Never touch a filled-in V/TO, scorecard, rocks file, L10 notes, or any other artifact that holds real company state.
- **When in doubt, skip.** The "Has This Artifact Been Touched?" heuristic biases toward NOT updating. False positives (skipping a still-placeholder artifact) are recoverable; false negatives (overwriting real business data) are not.
- **Push URL stays DISABLED.** A typo should never become a template commit.
- **Preview before merging.** The operator deserves to know what is coming before it lands.
- **Be specific about new capabilities.** Do not just report "3 new skills" — say what they do.
