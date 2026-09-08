#!/usr/bin/env bash
# build_fonts.sh — regenerate the bundled font set in assets/fonts/.
#
# wabisabi bundles FULL charsets so consumers never depend on system fonts:
#   WabKai-Regular.ttf   LXGW WenKai TC Regular (霞鶩文楷) — 繁簡全覆蓋,
#                        the face for ALL text (SIL OFL 1.1)
#   WabKai-Medium.ttf    LXGW WenKai TC Medium — display / heavier weights
#   WabMono-*.ttf        JetBrains Mono static 400/500 — code, latin labels
#                        (SIL OFL 1.1)
#
# Requirements: curl, python3 with fonttools (`pip install fonttools`).
# Usage: tool/build_fonts.sh   (writes into assets/fonts/, needs network)

set -euo pipefail
cd "$(dirname "$0")/.."
OUT=assets/fonts
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

WENKAI_VER=v1.522
WENKAI=https://github.com/lxgw/LxgwWenKaiTC/releases/download/$WENKAI_VER
GF=https://github.com/google/fonts/raw/main

echo "== download =="
curl -sL -o "$OUT/WabKai-Regular.ttf"      "$WENKAI/LXGWWenKaiTC-Regular.ttf"
curl -sL -o "$OUT/WabKai-Medium.ttf"       "$WENKAI/LXGWWenKaiTC-Medium.ttf"
curl -sL -o "$OUT/OFL-LXGWWenKaiTC.txt"    "https://raw.githubusercontent.com/lxgw/LxgwWenKaiTC/main/OFL.txt"
curl -sL -o "$WORK/JetBrainsMono-var.ttf"  "$GF/ofl/jetbrainsmono/JetBrainsMono%5Bwght%5D.ttf"
curl -sL -o "$OUT/OFL-JetBrainsMono.txt"   "$GF/ofl/jetbrainsmono/OFL.txt"

echo "== instance static weights =="
python -m fontTools.varLib.instancer "$WORK/JetBrainsMono-var.ttf" wght=400 -o "$OUT/WabMono-Regular.ttf"
python -m fontTools.varLib.instancer "$WORK/JetBrainsMono-var.ttf" wght=500 -o "$OUT/WabMono-Medium.ttf"

echo "== done =="
ls -la "$OUT"
