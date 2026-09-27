#!/usr/bin/env bash
# Package the ynot-reporting skill as a zip for claude.ai (Customize → Skills → Upload).
# The zip holds the skill folder at its top level, as claude.ai expects.
#   ./scripts/package-skill.sh        → dist/ynot-reporting.zip
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/dist/ynot-reporting.zip"
mkdir -p "$ROOT/dist"
rm -f "$OUT"
(cd "$ROOT/plugins/ynot/skills" && zip -qr -X "$OUT" ynot-reporting -x '*.DS_Store')
echo "wrote $OUT"
unzip -l "$OUT"
