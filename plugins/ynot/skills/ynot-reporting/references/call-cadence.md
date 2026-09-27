# Reading the Call Cadence report

A call campaign can carry a **day-by-day plan**: how many calls each lead should get on
day 1, day 2, … of its life in the campaign (e.g. 3 calls on days 1–3, then 1 call a day).
Day 1 can be split by **arrival window** — say 3 calls for a lead arriving before 2 pm,
2 calls from 2 pm, 1 call in the last hour before close.

The report asks, for every lead and every planned day: *was the lead owed calls that day,
and did it get them?*

## How it is scored

The report follows the LMS dialer's own rules for who is callable, so a "miss" is a call
the dialer was supposed to make:

- **Day 1** is the arrival date — or the next day for a lead that arrives after the
  campaign's closing time; that lead then falls in the first arrival window.
- **Calls counted** are the dialer's calls (prospect and Five9 dials) from any campaign,
  dated by when they started. A lead called from another campaign still had its call.
- **A lead is due on a day** only if it was in the campaign's queue at the day's opening:
  not excluded by a restricted call outcome, status or flag; in one of the campaign's
  allowed statuses; not held by a scheduled callback or an upcoming appointment (when the
  campaign excludes those); and under the campaign's lifetime call cap.
- **Leaving during a day** — booked, disqualified, moved to a status the campaign does not
  allow — ends what the lead is owed. That day counts only if it already had its calls.
- **The settings in force that day** are used, not today's: a status added to the
  campaign last week does not re-score the weeks before it.
- Only **completed days** are scored; today is not.
- Only valid leads in an available status are in the cohort.

## Columns

| Column | Meaning |
|---|---|
| Goal per Lead | Calls the plan asks for, per lead, that day ("No calls" on a rest day). |
| Leads Due | Leads owed that day's calls. On week and total rows, a lead counts once per day. |
| Calls Needed | Goal × Leads Due. |
| Calls Made | The dialer's calls to those leads that day. |
| Met Goal / Missed Goal | Leads that got every planned call / fewer (some or none). |
| % Met Goal | Met Goal ÷ Leads Due. |

Headline figures: **Cadence Followed** (% of all due lead-days that met their goal — the
campaign's overall adherence), **Day 1 Goal Met**, **Median First Call** (arrival to first
call), **Reached**, **Appointments** (within 30 days of arrival), **Calls Made**, and
**Over 3 Contacts in 24h** (leads that got more than three calls plus texts inside any
24 hours — the Florida telemarketing limit; worth flagging where it applies).

## How to read it

- **Lead with the weakest planned days.** Adherence usually collapses on multi-call days
  (a 3-call day needs a first call by early afternoon when calls must be hours apart) and
  holds on 1-call days. Say which days, with their % Met Goal and Calls Made vs Needed.
- **Split day 1 by arrival window** before judging it: late arrivals have little of the
  day left.
- **Campus and rep breakdowns** show where the misses concentrate; a campus far below the
  others is an operational finding, one that matches the others points at the plan or its
  settings.
- **Missed is not "no call".** Missed Goal includes leads that got some calls; compare
  Calls Made with Calls Needed for how short the day fell.
- **Settings shape the numbers.** Allowed statuses, restricted outcomes, the lifetime cap
  and the calling hours all decide who is due. If a result looks off, ask whether the
  campaign's settings changed during the period.
- For a single lead's history, or the leads behind a number, send the user to the report
  on ynotone.io — the connector returns counts only.
