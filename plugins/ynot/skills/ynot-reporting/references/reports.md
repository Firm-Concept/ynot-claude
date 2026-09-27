# Report reference

Every report the connector can run, what it answers, and how to call it. `list_reports`
is the authority on which of these the current user may run and on the exact breakdown
and filter keys; this file adds what each one means.

Common filters (most reports): `client`, `location` (campus), `user` (rep), `program`,
`channel` (lead type — groups sources), `lead_source`. Breakdown keys are not always the
filter keys: `source` groups by lead source, `adrep` / `rep` / `agent` by rep, `block` by
week of the cadence.

## Leads

### `reports_leads` — Leads Report
**Answers:** lead volume — total (gross), valid and invalid — by campus, program, channel,
source, status or rep.
**Breakdowns:** `location` (default), `program`, `channel`, `source`, `status`, `adrep`.
**Filters:** common + `enrollment_status`.
**Read:** "Total" is every lead received; "Valid" excludes duplicates and invalid leads.
Use it for "how many leads", "which sources", "which campus is up".

### `reports_leadflow` — Lead Flow
**Answers:** daily valid-lead volume across one month.
**Filters:** `client`, `location`, `program`, `lead_source`.
**Read:** mostly a calendar heatmap and trend chart on ynotone.io; the connector returns
its totals. For per-day numbers use the Leads Report over a custom range instead.

### `reports_callcadence` — Call Cadence Report
**Answers:** did each lead get the calls its campaign's day-by-day schedule plans?
**Required:** `cadence_campaign` (one; `list_filter_values`).
**Breakdowns:** `day` (default), `block` (week), `location` (campus), `rep`.
**Filters:** `location`, `enrollment_status`, `program`, `channel`, `lead_source`.
**Read:** see [call-cadence.md](call-cadence.md).

### `reports_speed_to_lead` — Speed to Lead Report
**Answers:** how fast leads get their first call — average time to first attempt, how
attempts spread across morning / afternoon / evening, and the last attempt.
**Filters:** common. Defaults to this week.
**Read:** runs with manual dials and re-inquiries excluded (the connector cannot change
those options).

### `reports_datachange` — Data Change Report
**Answers:** which leads had their program, campus, source, created date or owner changed
after they arrived, and how often.
**Breakdowns:** `location` (default), `program`, `source`, `channel`, `adrep`.
**Filters:** common + `enrollment_status`, and the `original_*` / `current_user` pairs to
filter by the value before or after the change.
**Read:** "Changed" counts leads whose attributes changed; a reassignment of owner alone is
reported separately and does not enter the change rate.

## Calls

### `reports_calldispositions` — Call Dispositions Report
**Answers:** inbound and outbound call counts by call outcome (disposition).
**Required:** `client` (one) — not listable through the connector; send the user to
ynotone.io.
**Breakdowns:** `location` (default), `channel`, `source`, `agent`.

### `reports_ccreport` — Call Center Success Report
**Answers:** call-center outcomes — gross, contact, success, warm-transfer and
appointment-set rates.
**Breakdowns:** `location` (default), `channel`, `source`, `adrep`.
**Filters:** common + `disposition`. Defaults to today.

## Pipeline

### `reports_dailyactivity` — Daily Activity Report
**Answers:** what each rep did — leads worked, calls, contacts, emails, texts and pipeline
events — for a day or a short window.
**Filters:** common. Defaults to today; best for `today` / `yesterday`.
**Read:** agency and campus totals; per-rep detail is on ynotone.io.

### `reports_conversion` — Conversion Report
**Answers:** the pipeline funnel — contact → applicant → appointment → interview → enroll
→ start (and cancels) — by rep, campus, source, program or channel.
**Breakdowns:** `adrep` (default), `location`, `source`, `program`, `channel`.
**Filters:** common + `enrollment_status`.

### `reports_admissionsconversion` — Admissions Conversion
**Answers:** gross → valid → appointments → interviews → prospects → enrolls → starts,
with the conversion between each stage.
**Breakdowns:** `adrep` (default), `location`, `channel`.
**Filters:** `client`, `location`, `program`, `channel`, `lead_source`.

### `reports_conversionbystatus` — Conversion by Status Report
**Answers:** how many leads sit in each status (active, enrolled, cancelled…) per channel,
source, campus or rep, with spend.
**Breakdowns:** `channel` (default), `source`, `location`, `rep`.

### `reports_enrolls` — Enrolls
**Answers:** enrollments over time.
**Filters:** `client`, `location`, `program`, `lead_source`.
**Read:** "Enrolls" counts unique enrolled leads; the daily trend (on ynotone.io) counts
enroll events.

### `reports_buildup` — Build-Up Report
**Answers:** for a start cohort, how the enrollment pipeline filled up over time.
**Required:** `start_date` cohort — not listable; omit it for the cohort closest to today.
**Read:** scoped by cohort, not by date range (a `date_range` is ignored).

### `reports_excellence` — Excellence Report
**Answers:** rep performance on enrollment quality — gross and valid leads, appointments,
interviews, prospects, enrolls, future starts, starts, referrals.
**Filters:** common + `enrollment_status`.

### `reports_aaa` — AAA Report
**Answers:** a rep scorecard — leads, appointments, shows and enrolls with conversion rates.
**Filters:** common + `enrollment_status`.

### `reports_assessments` — Assessments Report
**Answers:** assessment pass rates by campus, assessment, program or rep.
**Breakdowns:** `location` (default), `assessment`, `program`, `channel`, `source`, `adrep`.
**Filters:** common + `assessment`. Defaults to this month; the pass/fail and
first-attempt-only options run at their defaults.

## Communications

### `reports_emailreport` — Email Report
**Answers:** email template performance — sent, delivered, opened, hard-bounced,
complaints, unsubscribes, with rates.
**Filters:** common + `template`. Defaults to this month.

### `reports_smsreport` — SMS Report
**Answers:** SMS template performance — sent, delivered, failed, opt-outs, with rates.
**Filters:** common + `template`. Defaults to this month.

## Campaigns

### `reports_campaignspend` — Campaign Spend Report
**Answers:** spend against leads — cost per lead and per valid lead — by channel, source,
program or campus.
**Filters:** `client`, `location`, `program`, `channel`, `lead_source`.

### `reports_pacing` — Pacing Report
**Answers:** lead pacing against allocation by source and campus.
**Required:** `client` (one) — not listable through the connector; send the user to
ynotone.io.
