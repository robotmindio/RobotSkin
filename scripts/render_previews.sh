#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCENE="$PROJECT_DIR/scad/source/previews.scad"
RENDER_DIR="$PROJECT_DIR/renders"
mkdir -p "$RENDER_DIR"

for scene in overview port flat angle outer_angle grove; do
  openscad --autocenter --viewall --projection=ortho --imgsize=1400,1000 \
    --colorscheme=Tomorrow --csglimit=2000000 -D "SCENE=\"$scene\"" \
    -o "$RENDER_DIR/$scene.png" "$SCENE"
done

echo "Rendered previews in $RENDER_DIR"
