#!/usr/bin/env bash
# Build the release zips:
#   dist/ynotone-plugin.zip   the whole plugin (manifest at the zip's top level), for uploading
#                             under Organization settings → Plugins & skills, or Customize → Plugins
#   dist/ynot-reporting.zip   the skill alone, for Customize → Skills (folder at the top level)
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/dist"
rm -f "$ROOT/dist/ynotone-plugin.zip" "$ROOT/dist/ynot-reporting.zip"
(cd "$ROOT/plugins/ynot" && zip -qr -X "$ROOT/dist/ynotone-plugin.zip" . -x '*.DS_Store')
(cd "$ROOT/plugins/ynot/skills" && zip -qr -X "$ROOT/dist/ynot-reporting.zip" ynot-reporting -x '*.DS_Store')
for z in "$ROOT"/dist/*.zip; do echo "== $z"; unzip -Z1 "$z"; done
