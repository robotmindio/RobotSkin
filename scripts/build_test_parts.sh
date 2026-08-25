#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PART_DIR="$PROJECT_DIR/scad/test_parts"
OUT_DIR="$PROJECT_DIR/test-stl"
mkdir -p "$OUT_DIR"
find "$OUT_DIR" -maxdepth 1 -type f -name '*.stl' -delete

for source in "$PART_DIR"/*.scad; do
  output="$(basename "${source%.scad}")"
  echo "[OpenSCAD] $output"
  openscad -o "$OUT_DIR/$output.stl" "$source"
  test -s "$OUT_DIR/$output.stl"
done
