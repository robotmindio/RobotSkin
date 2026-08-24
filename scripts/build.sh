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
  shift 2
  echo "[OpenSCAD] $output"
  openscad "$@" -o "$STL_DIR/$output.stl" "$source"
}

build fit_test_port "$TEST_DIR/fit_tests.scad" -D 'PART="port"'
build fit_test_peg_small "$TEST_DIR/fit_tests.scad" -D 'PART="peg_small"'
build fit_test_peg_nominal "$TEST_DIR/fit_tests.scad" -D 'PART="peg_nominal"'
build fit_test_peg_large "$TEST_DIR/fit_tests.scad" -D 'PART="peg_large"'
build panel_40x40 "$SRC_DIR/panels.scad" -D 'PANEL=[40,40]'
build panel_80x40 "$SRC_DIR/panels.scad" -D 'PANEL=[80,40]'
build panel_80x80 "$SRC_DIR/panels.scad" -D 'PANEL=[80,80]'
build grove_20x20_carrier "$SRC_DIR/grove_carrier.scad"
build edge_coupon "$TEST_DIR/edge_coupons.scad"

echo "Built STLs in $STL_DIR"
