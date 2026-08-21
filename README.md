# RobotMind V2 modular construction system

RobotMind is a printable mechanical bus for sensors and small controllers:

`electronics → carrier → universal hex mount → structural plate`

Every carrier uses one identical hex plug. The press fit works without tools;
an M3 screw and heat-set insert can lock a carrier permanently. Every plate
edge is identical and connects directly at 0° or 90°, without separate
printed connectors or A/B plate types.

## V2 mechanical standard

- 40 mm structural unit; plates are 40×40, 80×40 or 80×80 mm.
- 20 mm triangular socket pitch.
- 12 mm plate thickness and 16 mm hex width across flats.
- 4 mm carrier engagement on either plate face.
- One full-height 7×12×12 mm finger and one notch per 40 mm of edge.
- The same cubic notch accepts the finger coplanar or at 90°.
- One hex plug per carrier, including Arduino and AprilTag carriers.
- Double-sided carrier sockets and one identical joint on every plate edge.
- Optional M3 locking; screws are never required for normal assembly.
- One calibration control: `RM_FIT`. Positive values loosen every printed fit.

## Generated models

- Three structural plates.
- Five official Grove PCB envelopes: 20×20, 20×40, 20×60, 40×40 and 40×60 mm.
- Arduino UNO carrier.
- AprilTag/beacon carrier and removable 60 mm tag insert.
- M5Stack Unit 24×32 mm carrier.
- 8 mm-pitch Technic adapter with 4.9 mm holes.
- Grove cable clip carrier.
- Three separate fit-test coupons.
- Complementary A/B injection-shell references for all three plate sizes.

The M5Stack and Technic models are dimensional adapters, not certifications.
Verify them against the specific device and genuine pins before a production
run. Measure electronics, connectors and antenna keep-outs before final use.

## Print and calibrate

Start with these three files:

1. `fit_test_hex_socket.stl`
2. `fit_test_hex_plug.stl`
3. `plate_joint_test.stl` (print two copies)

The default `RM_FIT=0` targets a calibrated Bambu Lab printer. If a fit is too
tight, rebuild with `RM_FIT=0.05`; if loose, use `RM_FIT=-0.05`. Change only in
0.05 mm steps. PETG, 0.20 mm layers, four perimeters and 25–35% infill are a
reasonable prototype baseline.

All exports are oriented for their recommended print position.

## SCAD library structure

- `scad/rm_common.scad` is the V2 mechanical source of truth: plate grid,
  carrier hex, hermaphroditic plate edge, M3 hardware and print-orientation
  helpers.
- `scad/rm_apriltag.scad` contains the tag dimensions and rails shared by the
  AprilTag insert and beacon carrier.
- `scad/09_injection_plate.scad` exports the A/B shell references.
- Other numbered SCAD files contain payload-specific geometry and defaults.

Change a shared interface only in `rm_common.scad`. Keep dimensions that
belong to one product—such as an Arduino board, M5Stack case or cable—in that
product's numbered file.

## M3 locking and manufacturing

The 4 mm web between opposite carrier sockets accepts one 4 mm M3 heat-set
insert. Each plate finger also has a 4 mm insert pocket from either face.
Inserts and screws remain optional; the progressive press fits carry normal
assemblies without them. A 9 mm M3 washer bridges the edge notch when a flat
or 90° joint needs permanent locking.

The normal FDM plate is monolithic and prints flat. Injection uses two
complementary 6 mm shells with 2 mm skins, internal ribs and a perimeter rim.
The finished plate has the same exterior interfaces as the printed version.
The shell exports are design references: a mold engineer must add resin- and
tool-specific draft, gates, ejectors and ultrasonic-weld details.

V2 is not yet IP-rated. Welded shells can seal the plate body, but cube seams,
carrier sockets and screws still require gaskets or plugs. Water resistance is
a sealing variant, not a different mechanical bus.

## Build

```bash
./scripts/build.sh
```

The script removes stale STL exports and rebuilds the complete V2 set in
`stl/`.
