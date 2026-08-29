# RobotSkin V0.1 acceptance and rating plan

V0.1-alpha is unrated engineering-evaluation hardware. Do not use it to support
people, safety equipment, suspended loads, or valuable equipment. Publishing a
working-load rating requires the tests below on production-equivalent material
and process; source geometry alone is not evidence of strength.

## Release acceptance

Record part revision, STL SHA-256, printer, profile, material lot, conditioning,
operator, date, sample count, measurements, failures, and disposition.

| Gate | Sample and method | Acceptance |
|---|---|---|
| Mesh | Every production STL, `scripts/validate_stl.py` | Watertight, consistent winding, positive volume, one connected shell |
| Grid | Alignment test compiled by `scripts/build.sh` | All OpenSCAD assertions pass |
| Visual | Every printed part | No cracks, missing walls, delamination, blocked holes, or loose material |
| Peg fit | 5 joints from the selected calibration | Seats fully by hand; no crack; no perceptible rotation under hand load |
| Repeatability | Same 5 joints | Ten install/remove cycles; all still seat and retain alignment |
| Insert installation | 10 inserts | Flush ±0.2 mm; no split or visible port distortion |
| Locked joint | 5 flat and 5 angle joints | M3×6 tightens without bottoming, stripping, or distortion |
| Plate flatness | 5 plates, flat reference surface | Maximum corner lift 1.0 mm before assembly |
| PCB carrier | 3 carriers with intended real PCB | All fasteners engage; no board bending; connectors and antenna remain accessible |
| Printability | Every SKU in release profile | Completes in documented orientation with only documented supports |

## Load qualification and published rating

Test at least five production-equivalent samples for each claimed load case:
flat-joint tension, flat-joint shear, angle-joint bending, plate surface mount,
DIN retention, 2020 retention, and tripod pull-out. Apply load gradually in a
guarded fixture, record first permanent deformation and ultimate failure, and
retain the raw results.

The published working load for a load case is the lower of:

1. one third of the lowest ultimate failure load; and
2. one half of the lowest load causing permanent deformation or loss of function.

Round the result down, state the material, print orientation, temperature, and
fastener configuration, and rerun the affected test whenever geometry,
material, print profile, insert, or screw specification changes. Until those
records exist, the authoritative load rating is **unrated / no load-bearing
claim**.
