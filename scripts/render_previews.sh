#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCENE="$PROJECT_DIR/scad/04_assembly_previews.scad"
RENDER_DIR="$PROJECT_DIR/renders"
mkdir -p "$RENDER_DIR"

render() {
  local name="$1"
  openscad --autocenter --viewall --projection=ortho \
    --imgsize=1400,1000 --colorscheme=Tomorrow \
    -D "SCENE=\"$name\"" -o "$RENDER_DIR/$name.png" "$SCENE"
}

render overview
render flat
render corner
render grove

echo "Rendered previews in $RENDER_DIR"
