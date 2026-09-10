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
    --colorscheme=Tomorrow --camera=0,0,0,45,0,35,100 \
    -D "MODE=\"$mode\"" -o "$RENDER_DIR/esp32_$mode.png" \
    "$PROJECT_DIR/scad/source/esp32_fit.scad"
done

for mode in assembly part; do
  openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
    --colorscheme=Tomorrow --camera=0,0,0,65,0,25,100 \
    -D "MODE=\"$mode\"" -o "$RENDER_DIR/pogo_$mode.png" \
    "$PROJECT_DIR/scad/source/pogo_fit.scad"
done

openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
  --colorscheme=Tomorrow --camera=0,0,0,60,0,205,100 \
  -o "$RENDER_DIR/pogo_rear.png" "$PROJECT_DIR/scad/source/pogo_fit.scad"

openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
  --colorscheme=Tomorrow --camera=0,0,0,120,0,25,100 \
  -D 'MODE="part"' -o "$RENDER_DIR/pogo_under.png" "$PROJECT_DIR/scad/source/pogo_fit.scad"

echo "Rendered previews in $RENDER_DIR"
