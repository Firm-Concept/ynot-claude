---
description: One-page weekly summary — leads, speed to lead, call center and conversions
argument-hint: [campus or program, optional] [week, default last 7 days]
allowed-tools: mcp__plugin_ynot_reporting__list_reports, mcp__plugin_ynot_reporting__run_report, mcp__plugin_ynot_reporting__list_filter_values, mcp__plugin_ynot_reporting__resolve_filter_value
---

Build a weekly summary with the YnotOne reporting connector, following the ynot-reporting
skill. Request: $ARGUMENTS

Period: the week given, else `last 7 days`; comparison: the 7 days before it (a custom
`YYYY-MM-DD,YYYY-MM-DD` range). Apply the same filters to every report — resolve any campus
or program named to its id first.

Run, for both periods: `reports_leads` (breakdown `source`), `reports_speed_to_lead`,
`reports_ccreport` (breakdown `location`) and `reports_admissionsconversion`. Skip any
report `list_reports` does not offer this user, and say which were skipped.

Write one page:
- **This week vs last** — leads (total, valid), time to first attempt, contact and
  appointment rates, enrolls and starts: this week, last week, change.
- **Notable moves** — the three biggest changes, with the source, campus or stage behind
  each.
- **Scope** — both periods as inclusive days, filters used, and that the last day's
  figures can still settle.
Report only returned figures; never rank across a truncated row list.
