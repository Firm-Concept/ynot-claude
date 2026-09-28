<img src="assets/ynotone-logo.png" alt="YnotOne" width="96" align="right">

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
| **Commands** | `report <question>` · `cadence [campaign] [period]` · `weekly [campus] [week]` — type `/` in Claude (`/ynot:report` etc. in Claude Code) |

You need a YnotOne account. Without one the connector has nothing to show.

## Claude (claude.ai, the desktop app and Cowork)

Plugins work on every paid Claude plan.

1. **Install the plugin.** Customize → Plugins → *Add marketplace* → enter
   `Firm-Concept/ynot-claude` → install **YnotOne**.
2. **Connect.** Open the plugin's *Connectors* tab, click **reporting** → **Connect**, and
   sign in with your YnotOne account. You stay signed in after that.
3. **Ask.** In any chat: *"How many leads did we get last month, by source?"* ·
   *"Is our speed-to-lead cadence being followed?"* · *"Which campus has the slowest first
   call this week?"* — or type `/` for the `report`, `cadence` and `weekly` commands.

**For an organization** (Team or Enterprise): an owner can add the plugin under
Organization settings → Plugins & skills and make it available, installed by default or
required for everyone. Organization marketplaces sync only from private repositories, so
upload the plugin instead: `ynotone-plugin.zip` from the
[latest release](https://github.com/Firm-Concept/ynot-claude/releases/latest). Each member
still connects with their own YnotOne sign-in and sees only their own data.

**Without the plugin:** add the connector alone (Settings → Connectors → *Add custom
connector*, URL `https://mcp.ynotlms.com`, OAuth client ID `claude`, no secret), and upload
`ynot-reporting.zip` from the latest release under Customize → Skills.

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
- **claude.ai:** plugins from the marketplace update themselves; an uploaded zip is
  replaced by uploading the new one from the latest release.

## Maintainers

- The skill lives in `plugins/ynot/skills/ynot-reporting`. Its report reference is checked
  against the live report catalog by a test in the YnotOne reporting service, which fails
  when a report is added, removed or gains a required filter without the skill following.
- Examples use invented names (Fernhill, Westmoor, Oakvale). This repository is public and
  the skill runs in every agency's Claude: never put a real agency, campus or person name
  in it.
- To release: bump `version` in `plugins/ynot/.claude-plugin/plugin.json`, then tag
  `vX.Y.Z`. The release workflow attaches `ynotone-plugin.zip` (the plugin, for upload) and
  `ynot-reporting.zip` (the skill alone) to the release.

## Privacy and support

- Privacy policy: <https://ynotone.com/privacy-policy> · Terms: <https://ynotone.com/terms-of-service>
- The connector reads reports only. It returns totals and breakdowns for your own agency —
  never individual lead records — and cannot change anything in YnotOne.
- Support: <support@ynotlms.com>

## License

The plugin and skill in this repository are released under the [MIT License](LICENSE).
It covers these files only; YnotOne itself and the data the connector returns are not
licensed by it and need a YnotOne account.
