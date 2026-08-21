#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCAD="$ROOT/scad"
STL="$ROOT/stl"
mkdir -p "$STL"
find "$STL" -maxdepth 1 -type f -name '*.stl' -delete

build() {
  local output="$1" source="$2"
  shift 2
  echo "[OpenSCAD] $output"
  openscad "$@" -o "$STL/$output.stl" "$SCAD/$source.scad"
}

build plate_40x40 01_plates -D 'PLATE=[40,40]'
build plate_80x40 01_plates -D 'PLATE=[80,40]'
build plate_80x80 01_plates -D 'PLATE=[80,80]'
build fit_test_hex_socket 00_fit_tests -D 'PART="hex_socket"'
build fit_test_hex_plug 00_fit_tests -D 'PART="hex_plug"'
build plate_joint_test 00_fit_tests -D 'PART="edge"'

build apriltag_insert 03_apriltag_insert
build apriltag_beacon_carrier 04_apriltag_beacon_carrier
build arduino_uno_carrier 05_arduino_uno_carrier
build grove_cable_clip_carrier 06_grove_cable_clip_carrier
build m5stack_unit_24x32_carrier 07_m5stack_unit_carrier
build technic_8mm_adapter 08_technic_adapter

build grove_carrier_20x20 02_grove_carriers -D 'PCB=[20,20]'
build grove_carrier_20x40 02_grove_carriers -D 'PCB=[20,40]'
build grove_carrier_20x60 02_grove_carriers -D 'PCB=[20,60]'
build grove_carrier_40x40 02_grove_carriers -D 'PCB=[40,40]'
build grove_carrier_40x60 02_grove_carriers -D 'PCB=[40,60]'

echo "Built STLs in $STL"
