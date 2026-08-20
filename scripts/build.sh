#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCAD="$ROOT/scad"
STL="$ROOT/stl"
mkdir -p "$STL"

build() {
  local output="$1" source="$2"
  shift 2
  echo "[OpenSCAD] $output"
  openscad "$@" -o "$STL/$output.stl" "$SCAD/$source.scad"
}

models=(
  01_universal_dock
  03_apriltag_insert 04_beacon_flat
  dock_90deg 08_esp32_uno_mount 09_cable_clip
)

for model in "${models[@]}"; do build "$model" "$model"; done

build 05_beacon_cube_shell 05_beacon_cube -D 'PART="shell"'
build 05_beacon_cube_lid 05_beacon_cube -D 'PART="lid"'
build 05_beacon_cube_gasket 05_beacon_cube -D 'PART="gasket"'
build 05_beacon_cube_pcb_carrier 05_beacon_cube -D 'PART="pcb_carrier"'
build 05_beacon_cube_tag_insert 03_apriltag_insert -D 'TAG_SIZE=42'

build carrier_20x20 02_carriers -D 'PCB=[20,20]'
build carrier_20x40 02_carriers -D 'PCB=[20,40]'
build carrier_20x60 02_carriers -D 'PCB=[20,60]'
build carrier_40x40 02_carriers -D 'PCB=[40,40]'
build carrier_40x60 02_carriers -D 'PCB=[40,60]'

build dock_15deg 06_angle_docks -D 'ANGLE=15'
build dock_30deg 06_angle_docks -D 'ANGLE=30'
build dock_45deg 06_angle_docks -D 'ANGLE=45'

build mount_magnet 10_mount_adapters -D 'TYPE="magnet"'
build mount_tripod 10_mount_adapters -D 'TYPE="tripod"'

echo "Built STLs in $STL"
