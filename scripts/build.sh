#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PART_DIR="$PROJECT_DIR/scad/parts"
TEST_DIR="$PROJECT_DIR/scad/test"
STL_DIR="$PROJECT_DIR/stl"
mkdir -p "$STL_DIR"
find "$STL_DIR" -maxdepth 1 -type f -name '*.stl' -delete

build() {
  local source="$1" output
  output="$(basename "${source%.scad}")"
  echo "[OpenSCAD] $output"
  openscad -o "$STL_DIR/$output.stl" "$source"
  test -s "$STL_DIR/$output.stl"
}

echo "[OpenSCAD] alignment"
openscad --export-format csg -o /dev/null "$TEST_DIR/alignment.scad"

for source in "$PART_DIR"/*.scad; do
  build "$source"
done

"$PROJECT_DIR/scripts/render_previews.sh"
echo "Built STLs in $STL_DIR"
