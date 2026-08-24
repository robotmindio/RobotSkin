#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$PROJECT_DIR/scad/source"
TEST_DIR="$PROJECT_DIR/scad/test"
STL_DIR="$PROJECT_DIR/stl"
mkdir -p "$STL_DIR"
find "$STL_DIR" -maxdepth 1 -type f -name '*.stl' -delete

build() {
  local output="$1" source="$2"
  echo "[OpenSCAD] $output"
  openscad -o "$STL_DIR/$output.stl" "$source"
}

build dock_fit_test "$TEST_DIR/dock_fit_test.scad"
build universal_dock "$SRC_DIR/universal_dock.scad"
build grove_20x20_carrier "$SRC_DIR/grove_carrier.scad"
build beacon_flat "$SRC_DIR/beacon_flat.scad"
build mount_plate "$SRC_DIR/mount_plate.scad"

echo "Built STLs in $STL_DIR"
