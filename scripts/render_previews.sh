#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCENE="$PROJECT_DIR/scad/source/previews.scad"
RENDER_DIR="$PROJECT_DIR/renders"
mkdir -p "$RENDER_DIR"

for scene in overview port flat angle outer_angle grove uno adapters; do
  openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
    --colorscheme=Tomorrow --csglimit=2000000 -D "SCENE=\"$scene\"" \
    -o "$RENDER_DIR/$scene.png" "$SCENE"
done

for mode in assembly part; do
  openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
    --colorscheme=Tomorrow --camera=0,0,0,65,0,35,100 \
    -D "MODE=\"$mode\"" -o "$RENDER_DIR/esp32_$mode.png" \
    "$PROJECT_DIR/scad/source/esp32_fit.scad"
done

echo "Rendered previews in $RENDER_DIR"
