#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCAD="$ROOT/scad"
STL="$ROOT/stl"
PNG="$ROOT/previews"
mkdir -p "$STL" "$PNG"

build() {
  local output="$1" source="$2"
  shift 2
  echo "[OpenSCAD] $output"
  openscad "$@" -o "$STL/$output.stl" "$SCAD/$source.scad"
  if command -v xvfb-run >/dev/null 2>&1; then
    xvfb-run -a openscad "$@" --imgsize=1200,900 --viewall --autocenter --projection=ortho -o "$PNG/$output.png" "$SCAD/$source.scad" || true
  fi
}

models=(
  01_universal_dock
  03_apriltag_insert 04_beacon_flat 05_beacon_cube
  dock_90deg 08_esp32_uno_mount 09_cable_clip
)

for model in "${models[@]}"; do build "$model" "$model"; done

build carrier_20x20 02_carriers -D 'SIZE=0'
build carrier_20x40 02_carriers -D 'SIZE=1'
build carrier_20x60 02_carriers -D 'SIZE=2'
build carrier_40x40 02_carriers -D 'SIZE=3'
build carrier_40x60 02_carriers -D 'SIZE=4'

build dock_15deg 06_angle_docks -D 'ANGLE=15'
build dock_30deg 06_angle_docks -D 'ANGLE=30'
build dock_45deg 06_angle_docks -D 'ANGLE=45'

build mount_magnet 10_mount_adapters -D 'TYPE="magnet"'
build mount_tripod 10_mount_adapters -D 'TYPE="tripod"'

echo "Built STLs in $STL"
echo "Rendered previews in $PNG"
