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

build fit_test_port 00_fit_tests -D 'PART="port"'
build fit_test_peg_small 00_fit_tests -D 'PART="peg_small"'
build fit_test_peg_nominal 00_fit_tests -D 'PART="peg_nominal"'
build fit_test_peg_large 00_fit_tests -D 'PART="peg_large"'
build panel_40x40 01_panels -D 'PANEL=[40,40]'
build panel_80x40 01_panels -D 'PANEL=[80,40]'
build panel_80x80 01_panels -D 'PANEL=[80,80]'
build flat_link_40 02_connectors -D 'PART="flat"'
build angle_link_40 02_connectors -D 'PART="angle"'
build flat_gasket_40 02_connectors -D 'PART="flat_gasket"'
build angle_gasket_40 02_connectors -D 'PART="angle_gasket"'
build flat_link_80 02_connectors -D 'PART="flat"' -D 'LENGTH=80'
build angle_link_80 02_connectors -D 'PART="angle"' -D 'LENGTH=80'
build grove_20x20_carrier 03_grove_20x20_carrier

echo "Built STLs in $STL_DIR"
