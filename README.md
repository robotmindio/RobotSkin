# RobotMind V1 modular construction system

RobotMind is a printable mechanical bus for sensors and small controllers:

`electronics → carrier → universal hex mount → structural plate`

Every carrier uses one identical hex plug. The press fit works without tools;
an M3 screw and heat-set insert can lock a carrier permanently. Plates connect
directly at 90° with integral tabs and open edge slots, without separate
printed connectors.

## V1 mechanical standard

- 40 mm structural unit; plates are 40×40, 80×40 or 80×80 mm.
- 20 mm triangular socket pitch.
- 16 mm hex width across flats, leaving 4 mm nominal ligaments.
- 10 mm corner-tab pitch.
- One hex plug per carrier, including Arduino and AprilTag carriers.
- Double-sided carrier sockets and corner slots.
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
- Four separate fit-test coupons.

The M5Stack and Technic models are dimensional adapters, not certifications.
Verify them against the specific device and genuine pins before a production
run. Measure electronics, connectors and antenna keep-outs before final use.

## Print and calibrate

Start with these four files:

1. `fit_test_hex_socket.stl`
2. `fit_test_hex_plug.stl`
3. `plate_joint_male_test.stl`
4. `plate_joint_female_test.stl`

The default `RM_FIT=0` targets a calibrated Bambu Lab printer. If a fit is too
tight, rebuild with `RM_FIT=0.05`; if loose, use `RM_FIT=-0.05`. Change only in
0.05 mm steps. PETG, 0.20 mm layers, four perimeters and 25–35% infill are a
reasonable prototype baseline.

All exports are oriented for their recommended print position.

## M3 locking and water resistance

Each carrier socket contains a 4.0 mm pocket for a nominal 5 mm M3 heat-set
insert. A 0.3 mm membrane keeps the opposite socket closed until an insert is
installed. Insert and screw dimensions remain configurable in
`scad/rm_common.scad`.

V1 is not IP-rated. Blind sockets preserve the plate wall, but corner seams
and optional screws require sealing. A waterproof product needs a dedicated
gasketed edge profile rather than changes to the universal carrier interface.

## Build

```bash
./scripts/build.sh
```

The script removes stale STL exports and rebuilds the complete V1 set in
`stl/`.
