# RobotMind modular hex construction system

A printable construction system in which the docks are the structure:

`payload → carrier with integral hex plug → flat dock panel`

There are no separate carrier feet, dock blocks, hinge pins, angle brackets or
cube shell. Flat dock panels connect directly to one another and remain usable
at either 0° or 90°.

## Included models

- Dense, double-sided hex dock panels in 42×42, 84×42 and 84×84 mm sizes.
- Direct A/B snap-hinge panel edges with flat and right-angle detents.
- Grove carriers for 20×20, 20×40, 20×60, 40×40 and 40×60 mm boards.
- Arduino-UNO-format two-plug carrier.
- AprilTag/beacon two-plug carrier and removable 60 mm tag insert.
- Grove cable clip carrier.
- Small hex snap and panel-hinge fit tests.

Six identical 84×84 panels form a cube. Carriers fit the same dense socket
lattice on either face, so an Alice/AprilTag card can sit outside while boards
sit inside.

## Prototype limits

This is fit-test hardware, not an IP-rated enclosure. The panel has blind
sockets and a solid center web, but a cube still has twelve edge seams and
eight corner intersections. Use a TPU seam gasket or waterproof inner liner
for wet operation.

The snap plug and hinge are printer-sensitive. Start with PETG, 0.20 mm layers,
4 perimeters and 25–35% infill. Tune `RM_HEX_CLEARANCE` and
`RM_HINGE_CLEARANCE` by ±0.10 mm before printing full panels.

Print the four separate `fit_test_*.stl` coupons first. Every generated model
is already oriented in its recommended printing position. Carriers stand on
a long edge to avoid support beneath the integral plug; add a brim if needed.

Measure actual electronics and antenna keep-outs before final use.

## Build

```bash
./scripts/build.sh
```

The script replaces stale generated STL files in `stl/` with the current set.
