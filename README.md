# RobotMind modular hex construction system

A printable construction system in which the docks are the structure:

`payload → carrier with integral hex plug → flat dock panel`

There are no separate carrier feet, dock blocks, hinges, angle brackets or
corner connectors. Tapered male hex pins on one panel enter female sockets in
the neighboring panel directly at either 0° or 90°.

## Included models

- Dense, double-sided hex dock panels in 42×42, 84×42 and 84×84 mm sizes.
- Direct male/female hex panel edges for rigid flat and right-angle joints.
- Optional M3 clamping at 90°, directly between panels.
- Grove carriers for 20×20, 20×40, 20×60, 40×40 and 40×60 mm boards.
- Arduino-UNO-format two-plug carrier.
- AprilTag/beacon two-plug carrier and removable 60 mm tag insert.
- Grove cable clip carrier.
- Separate tapered-hex and direct-edge fit tests.

Six identical 84×84 panels form a cube. Carriers fit the same dense socket
lattice on either face, so an Alice/AprilTag card can sit outside while boards
sit inside.

## Prototype limits

This is fit-test hardware, not an IP-rated enclosure. Carrier sockets remain
blind with a solid center web, but the direct 90° joins have screw openings
near the edges. Use sealing washers and sealant for wet operation.

The tapered fits are printer-sensitive. Start with PETG, 0.20 mm layers,
4 perimeters and 25–35% infill. Tune `RM_HEX_CLEARANCE` and
`RM_JOIN_CLEARANCE` by ±0.10 mm before printing full panels.

Print the four separate `fit_test_*.stl` coupons first. Every generated model
is already oriented in its recommended printing position. Carriers stand on
a long edge to avoid support beneath the integral plug; add a brim if needed.

Measure actual electronics and antenna keep-outs before final use.

## Build

```bash
./scripts/build.sh
```

The script replaces stale generated STL files in `stl/` with the current set.
