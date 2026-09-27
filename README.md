# YnotOne for Claude

Ask Claude about your admissions data in YnotOne — leads, sources, campuses, reps, calls,
speed to lead, call-cadence adherence, conversions, enrollments, email and SMS, spend and
pacing — and get answers from the same reports you see on ynotone.io.

Everything here is **read-only**. Claude signs in as you, sees only your agency and the
campuses your role allows, and gets totals and breakdowns — never individual lead records.
Nothing in this repository can change your data.

## What's in it

| | |
|---|---|
| **Connector** | The YnotOne reporting connector, `https://mcp.ynotlms.com`. It is what fetches the numbers. |
| **Skill** (`ynot-reporting`) | Teaches Claude which report answers which question, which filters each report needs, what the numbers mean, and how to state them without guessing. |
| **Commands** (Claude Code) | `/ynot:report <question>` · `/ynot:cadence [campaign] [period]` · `/ynot:weekly [campus] [week]` |

You need a YnotOne account. Without one the connector has nothing to show.

## Claude (claude.ai and the desktop app)

1. **Add the connector.** Settings → Connectors → *Add custom connector*:
   - URL: `https://mcp.ynotlms.com`
   - OAuth client ID: `claude` (leave the secret empty)

   Click **Connect** and sign in with your YnotOne account.
2. **Add the skill.** Download `ynot-reporting.zip` from the
   [latest release](https://github.com/Firm-Concept/ynot-claude/releases/latest), then
   Customize → Skills → *Upload* and choose the zip. Turn it on.
3. Ask away: *"How many leads did we get last month, by source?"* · *"Is our speed-to-lead
   cadence being followed?"* · *"Which campus has the slowest first call this week?"*

**For an organization** (Team or Enterprise plan): an owner adds the connector for the
organization and uploads the skill once, then publishes it to the organization. Each member
connects with their own YnotOne sign-in, so everyone still sees only their own data.

## Claude Code

```text
/plugin marketplace add Firm-Concept/ynot-claude
/plugin install ynot@ynot
```

Then run `/mcp`, choose **plugin:ynot:reporting**, and sign in to YnotOne in the browser.

To offer it in a project, add to that project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "ynot": { "source": { "source": "github", "repo": "Firm-Concept/ynot-claude" } }
  },
  "enabledPlugins": { "ynot@ynot": true }
}
```

## Updating

- **Claude Code:** `/plugin update ynot@ynot`.
- **claude.ai:** download the new zip from the latest release and upload it again.

## Maintainers

- The skill lives in `plugins/ynot/skills/ynot-reporting`. Its report reference is checked
  against the live report catalog by a test in the YnotOne reporting service, which fails
  when a report is added, removed or gains a required filter without the skill following.
- Examples use invented names (Fernhill, Westmoor, Oakvale). This repository is public and
  the skill runs in every agency's Claude: never put a real agency, campus or person name
  in it.
- To release: bump `version` in `plugins/ynot/.claude-plugin/plugin.json`, then tag
  `vX.Y.Z`. The release workflow builds `ynot-reporting.zip` and attaches it to the release.
