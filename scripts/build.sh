#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$PROJECT_DIR/scad/source"
STL_DIR="$PROJECT_DIR/stl"
mkdir -p "$STL_DIR"
find "$STL_DIR" -maxdepth 1 -type f -name '*.stl' -delete

build() {
  local output="$1" source="$2"
  echo "[OpenSCAD] $output"
  openscad -o "$STL_DIR/$output.stl" "$source"
}

build plate_8x8 "$SRC_DIR/plate_8x8.scad"
build flat_join "$SRC_DIR/flat_join.scad"
build angle_join "$SRC_DIR/angle_join.scad"
build outer_angle_join "$SRC_DIR/outer_angle_join.scad"
build grove_plaque "$SRC_DIR/grove_plaque.scad"

"$PROJECT_DIR/scripts/render_previews.sh"
echo "Built STLs in $STL_DIR"
