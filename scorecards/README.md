<!-- See https://traction.wiki/tools/scorecard for the canonical framework reference. -->

# Scorecards

Weekly activity-based leading indicators. One file per scope:

- `company.md`: leadership-team scorecard, reviewed in the leadership L10.
- `<dept-slug>.md`: departmental scorecards (e.g., `sales.md`, `operations.md`, `marketing.md`), reviewed in each department's L10.

## The Cascade Pattern

Company metrics drive departmental metrics drive individual measurables.

- Company scorecard has 5-15 metrics.
- Each function head owns a slice of one or more company metrics.
- Each function head's departmental scorecard has 3-5 metrics that, when hit, predict the company-level metrics will be hit.
- Each individual on a department has at least one measurable cascading from the departmental scorecard.

## Adding a Departmental Scorecard

Use the `eos-design-scorecard` skill, passing the department name. Output goes here as `<dept-slug>.md`. Follow the same shape as `company.md`.

---

## Further Reading

- [Scorecard on traction.wiki](https://traction.wiki/tools/scorecard) — the framework reference.
- [Build the Scorecard playbook](https://traction.wiki/playbooks/build-the-scorecard) — the workshop for first-time use.
- [Data Component](https://traction.wiki/components/data) — the component this artifact strengthens.
