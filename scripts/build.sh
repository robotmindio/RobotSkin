#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCAD_DIR="$PROJECT_DIR/scad"
STL_DIR="$PROJECT_DIR/stl"
mkdir -p "$STL_DIR"
find "$STL_DIR" -maxdepth 1 -type f -name '*.stl' -delete

build() {
  local output="$1" source="$2"
  shift 2
  echo "[OpenSCAD] $output"
  openscad "$@" -o "$STL_DIR/$output.stl" "$SCAD_DIR/$source.scad"
}

build fit_test_holes 00_fit_tests -D 'PART="holes"'
build fit_test_pin_small 00_fit_tests -D 'PART="pin_small"'
build fit_test_pin_nominal 00_fit_tests -D 'PART="pin_nominal"'
build fit_test_pin_large 00_fit_tests -D 'PART="pin_large"'
build plate_40x40 01_plates -D 'PLATE=[40,40]'
build plate_80x40 01_plates -D 'PLATE=[80,40]'
build plate_80x80 01_plates -D 'PLATE=[80,80]'
build push_pin 02_connectors -D 'PART="pin"'
build flat_link 02_connectors -D 'PART="flat"'
build angle_link 02_connectors -D 'PART="angle"'
build grove_20x20_carrier 03_grove_20x20_carrier

echo "Built STLs in $STL_DIR"
