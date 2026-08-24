#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCENE="$PROJECT_DIR/scad/source/previews.scad"
RENDER_DIR="$PROJECT_DIR/renders"
mkdir -p "$RENDER_DIR"

render() {
  local name="$1"
  openscad --autocenter --viewall --projection=ortho \
    --imgsize=1400,1000 --colorscheme=Tomorrow \
    --csglimit=2000000 \
    -D "SCENE=\"$name\"" -o "$RENDER_DIR/$name.png" "$SCENE"
}

render overview
render pair
render corner
render grove
render cube

echo "Rendered previews in $RENDER_DIR"
