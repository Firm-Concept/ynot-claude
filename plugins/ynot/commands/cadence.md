---
description: Review how well a call campaign's day-by-day cadence is being followed
argument-hint: '[campaign name] [period, e.g. "last 30 days"]'
allowed-tools: mcp__plugin_ynot_reporting__list_reports, mcp__plugin_ynot_reporting__run_report, mcp__plugin_ynot_reporting__list_filter_values, mcp__plugin_ynot_reporting__resolve_filter_value
---

Review call-cadence adherence with the YnotOne reporting connector, following the
ynot-reporting skill and its call-cadence reference. Request: $ARGUMENTS

1. Find the campaign: `list_filter_values` with `dim: cadence_campaign`. If no name was
   given or several match, list the campaigns and ask which one.
2. Period: the one given, else `last 30 days`.
3. Run `reports_callcadence` with the campaign filter four times: `breakdown: day`,
   `block` (weeks), `location` (campuses) and `rep`.
4. Write the review:
   - **Headline:** Cadence Followed, Day 1 Goal Met, Median First Call, leads in cadence.
   - **Where it breaks:** the planned days with the lowest % Met Goal, each with Calls Made
     against Calls Needed; day 1 by arrival window.
   - **Campuses and reps:** where adherence is notably higher or lower.
   - **Contact limits:** leads over 3 contacts in 24 hours, if any.
   - **What to check:** two or three concrete, operational next steps drawn only from
     these figures (e.g. first-call timing on multi-call days, the campus that lags).
   - **Scope:** campaign, period, and that a lead counts only while it is in the queue.
