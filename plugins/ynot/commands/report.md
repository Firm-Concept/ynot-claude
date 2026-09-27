---
description: Answer a reporting question from YnotOne data
argument-hint: <question, e.g. "leads by source for the Fernhill campus last month">
allowed-tools: mcp__plugin_ynot_reporting__list_reports, mcp__plugin_ynot_reporting__run_report, mcp__plugin_ynot_reporting__list_filter_values, mcp__plugin_ynot_reporting__resolve_filter_value
---

Answer this question with the YnotOne reporting connector, following the ynot-reporting
skill: $ARGUMENTS

Pick the report that answers it, resolve every name to a filter id, supply any required
filter, and run it. If the question is ambiguous — which campus, which period, which
campaign — ask one short question instead of guessing.

Answer in this shape:
1. The answer in one or two sentences, with the key figures.
2. A small table of the rows that matter (say so if the report's row list was truncated).
3. One line of scope: report, period (inclusive days), filters, breakdown.
