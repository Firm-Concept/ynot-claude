---
name: ynot-reporting
description: Answers questions about an admissions team's YnotOne (Ynot LMS) data — leads, lead sources and channels, campuses, reps, calls and call outcomes, speed to lead, call cadence adherence, appointments, conversions, enrollments and starts, email and SMS, campaign spend and pacing — using the YnotOne reporting connector. Use whenever a question needs those numbers, names a Ynot report, or asks to compare campuses, reps, sources or periods.
---

# YnotOne reporting

The YnotOne connector runs the same reports as ynotone.io, scoped to the signed-in
user's agency and the campuses their role allows. It is read-only and returns
aggregates only — never individual leads.

## Tools

| Tool | Use it to |
|---|---|
| `list_reports` | See the reports this user can run, with each one's breakdown keys and filter dimensions. Call it once, first. |
| `resolve_filter_value` | Turn a name the user said ("the Fernhill campus", "Lead Aggregator - PPL") into a filter dimension and id. Searches campuses, programs, channels, lead sources, reps and assessments. |
| `list_filter_values` | List one dimension's values with ids — e.g. every campus, or every cadence campaign (`cadence_campaign`, which `resolve_filter_value` does not search). |
| `run_report` | Run one report: `report_id`, optional `date_range`, optional `breakdown`, optional `filters` (`[{dim, ids}]`). |

## Workflow

1. **Pick the report.** Match the question to a report in
   [references/reports.md](references/reports.md). If the user's role cannot run it, it
   will be missing from `list_reports` — say so; do not substitute a different report
   without saying so.
2. **Resolve every name to an id.** Filters take ids, never names. Use
   `resolve_filter_value`; if it returns several matches, ask which one. A name that
   matches nothing is not a filter — do not guess an id.
3. **Supply required filters.** `list_reports` names them as `required_filters`, one id
   each. Leave one out and `run_report` applies it when the agency has only one value
   (the output's `scope` names it), or refuses and lists the choices — ask the user which
   one rather than picking. See the table below.
4. **Choose the date range** (grammar below). Say the period you used in the answer.
5. **Choose a breakdown** only from the keys `list_reports` gave for that report. Without
   one you get the agency-level totals.
6. **Run it** and answer from the returned figures only.

### Required filters

| Report | Needs | How to get it |
|---|---|---|
| `reports_callcadence` | `cadence_campaign` (one) | `list_filter_values` with `dim: cadence_campaign` |
| `reports_buildup` | `start_date` cohort (one) | Not listable through the connector: omit it and the report uses the start cohort closest to today. For another cohort, send the user to the Build-Up report on ynotone.io. |
| `reports_calldispositions`, `reports_pacing` | `client` (one) | `list_filter_values` with `dim: client`, or `resolve_filter_value` on the name the user gave. Applied for you when the agency has one client. |

### Date ranges

- Presets: `today`, `yesterday`, `this week`, `this month`, `last month`, `last 7 days`,
  `last 30 days`, `this quarter`, `this year`.
- Custom: `YYYY-MM-DD,YYYY-MM-DD` — both days included, e.g. `2026-09-01,2026-09-30`.
- Anything else silently becomes "this month". Translate "last week", "Q3", "since the
  15th" into a custom range yourself.
- The response's `date_range` has an exclusive end ("2026-09-01 00:00:00 to
  2026-10-01 00:00:00" is all of September). Report it as the inclusive days it covers.
- Omitting `date_range` uses the report's own default (Daily Activity and Call
  Dispositions default to today; Call Cadence to the last 30 days; most to this month).

## Answering

- **Report only returned figures.** Values arrive formatted ("1,731", "24.4%",
  "16 minutes") — quote them as given. Do not recompute a rate the report returned; if
  you derive one, say how.
- **Rows are capped at 40.** When `truncated` is true, say the list is incomplete, and do
  not rank, total or compare across rows you did not receive. Narrow with a filter or a
  different breakdown instead.
- **Say the scope**: report, period, filters and breakdown. A reader must be able to
  reproduce the number on ynotone.io.
- **Compare like with like.** For "vs last month", run the same report twice with the
  same filters and breakdown, and give both periods' figures.
- **No lead-level answers.** The connector cannot list or export individual leads, and
  must not be asked to. For "which leads…", give the counts and point to the report on
  ynotone.io, where the numbers open to their leads.
- **Recent data can shift.** Figures sync from the LMS continuously and are corrected
  overnight; today's and yesterday's numbers may still move slightly. Mention it when a
  conclusion hinges on the last day.
- **Options are not settable.** Report toggles (Speed to Lead's exclude-manual-dials,
  Assessments' pass/fail filter and similar) run at their defaults through the connector.

## Report-specific guidance

- Per-report purpose, breakdowns, filters and what the metrics mean:
  [references/reports.md](references/reports.md).
- Call Cadence — how "cadence followed" is scored, and how to read a campaign's day
  table: [references/call-cadence.md](references/call-cadence.md).

## Examples

**"How many leads did the Fernhill campus get last month, by source?"**
`resolve_filter_value("Fernhill")` → `location` id; then
`run_report(report_id: "reports_leads", date_range: "last month", breakdown: "source",
filters: [{dim: "location", ids: [<id>]}])`. Answer with the total, the valid share, and
the top sources — noting if the list was truncated.

**"Is our Westmoor speed-to-lead cadence being followed?"**
`list_filter_values(dim: "cadence_campaign")` → pick the Westmoor campaign (ask if
several match); `run_report(report_id: "reports_callcadence", filters:
[{dim: "cadence_campaign", ids: [<id>]}], breakdown: "day")`, then `breakdown: "location"`
for campuses. Read it with references/call-cadence.md.
