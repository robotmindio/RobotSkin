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

build dock_panel_1x1 01_dock_panels -D 'PANEL=[42,42]'
build dock_panel_2x1 01_dock_panels -D 'PANEL=[84,42]'
build dock_panel_2x2 01_dock_panels -D 'PANEL=[84,84]'
build fit_test_hex_socket 00_fit_tests -D 'PART="hex_socket"'
build fit_test_hex_plug 00_fit_tests -D 'PART="hex_plug"'
build fit_test_hinge_bead 00_fit_tests -D 'PART="hinge_bead"'
build fit_test_hinge_channel 00_fit_tests -D 'PART="hinge_channel"'

build apriltag_insert 03_apriltag_insert
build apriltag_beacon_carrier 04_beacon_flat
build arduino_uno_carrier 08_esp32_uno_mount
build grove_cable_clip_carrier 09_cable_clip

build carrier_20x20 02_carriers -D 'PCB=[20,20]'
build carrier_20x40 02_carriers -D 'PCB=[20,40]'
build carrier_20x60 02_carriers -D 'PCB=[20,60]'
build carrier_40x40 02_carriers -D 'PCB=[40,40]'
build carrier_40x60 02_carriers -D 'PCB=[40,60]'

echo "Built STLs in $STL"
