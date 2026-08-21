# RobotMind V3 modular construction system

RobotMind is a simple 8 mm structural grid for robotics:

`plate + connector + push pins`

Children can assemble it without tools. The same holes accept M4 bolts when a
robot needs a permanent joint. Plain plates stay visually clean; small
connectors make flat or 90° structures.

## V3 MVP

- 40 mm structural unit and 8 mm hole grid.
- 3.2 mm plates with 5 mm nominal through-holes.
- 40×40, 80×40 and 80×80 mm plates.
- One split push pin for any two 3.2 mm layers.
- One four-pin flat connector.
- One four-pin 90° connector.
- One Grove 20×20 carrier with the same grid interface.
- One calibration control: `RM_FIT`. Positive values loosen every printed fit.

The grid is dimensionally close to Technic-style parts, but compatibility is
not claimed until genuine parts have been tested. Grove compatibility belongs
to carriers and does not change the structural interface.

## Print and calibrate

Build everything:

```bash
./scripts/build.sh
```

Print `fit_test_holes.stl` and the three `fit_test_pin_*.stl` files first.
The small and large pins differ from nominal by 0.1 mm. Set `RM_FIT=0.05` if
the nominal fit is too tight or `RM_FIT=-0.05` if it is too loose, then
rebuild.

All MVP parts print without supports. PETG, 0.20 mm layers and four perimeters
are a reasonable prototype baseline. Print pins upright on their heads.

## Assembly

- Flat surface: place `flat_link` below the seam and use four push pins.
- 90° corner: place `angle_link` inside the corner and use four push pins.
- Permanent joint: replace any push pin with an M4 bolt and nut.
- Grove: press a 20×20 board onto the four small pegs, leaving its cable at the
  open side of the tray.

The push pin is sized for exactly two `RM_PLATE_T` layers. Carriers and
connectors therefore use the same 3.2 mm mounting flange.

## Product boundary

V3 deliberately omits integral edge teeth, hex sockets, heat-set inserts,
injection shells and payload adapters beyond the first Grove carrier. Validate
the core connection before expanding the catalogue or starting mold DFM.

`scad/rm_common.scad` is the only source of shared mechanical dimensions.
