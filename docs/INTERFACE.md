# RobotSkin interface

The production base plate is `plate(8,8)`: 80×80×4 mm with a full 8×8,
10 mm-pitch port grid. The library derives other plate dimensions from the
same grid standard. Every plate back is flat for reliable printing and surface
mounting.

| Feature | Dimension |
|---|---:|
| Annular octagonal port, across flats | 8.0 mm |
| Octagonal depth | 2.2 mm |
| Insert entry / pilot / insert | 4.6 mm × 0.8 mm / 3.7 mm × 3.0 mm / 4.0 mm OD M3×3×4 |
| Centre boss / peg clearance | 5.6 mm diameter / 5.9 mm diameter |
| Port backing wall | 1.0 mm |
| Corner mounting ports | Standard port plus 3.4 mm M3 clearance through backing wall |
| Through-plate ports | Standard port plus 3.4 mm M3 clearance through every backing wall |
| Peg root / tip | 8.3 / 7.7 mm across flats |
| Peg depth | 2.2 mm |
| Permanent lock | M3×6 pan-head screw, 2 mm insert engagement |
| Grove carrier retention | M2×6 / 1.7 mm pilot (2×2, 4×2); M2.5×6 / 2.1 mm pilot (LCD) |
| Profile 2020 mounting | Two M5 clearance holes, 30 mm apart |
| DIN rail | EN 60715 TH35 rigid end-slide channel |
| Tripod | Captive 1/4-20 hex nut, 4.5 mm maximum screw entry |
| UNO carrier | 68.58×53.34 mm outline, official asymmetric four-hole layout |

The circular central boss carries the insert for its full 3 mm depth. A visible 4.6 mm,
0.8 mm-deep entry cup leads into the 3.7 mm pilot, so the brass can start
straight from the exposed plate face before heat presses it into the interference fit. The peg
clears the boss, then its centre accepts an M3 screw. Its thinnest wall is 0.7 mm at the calibrated fit;
a four-peg field locates each join face and stops rotation. Every peg has an
identical through-hole and can accept a screw; four screws per tile are the
minimum recommended lock and all eight can be used for maximum strength.

Flat joins mount on the plate face across an edge seam. Angle joins mount in
the inside corner: one leg on the floor face and one on the wall face. Their
plate-contact faces are flat. Water resistance is outside the first release
until a sealed joint has been designed and tested.
Every join is one 20 mm tile spanning two adjacent port columns. A flat tile
has a 2×2 peg field on each plate. The inside angle is one continuous,
geometrically symmetric L-shaped part with the same 5/15 mm connector rows on
each face. Correctly seated plates touch along the full corner line; connector
fit must not be compensated by shifting either plate. Its outer ends use the
same rounded corners as the Grove carrier while both contact faces remain flat.
One to four tiles span a 20–80 mm run on a single surface.

`outer_angle_join` mounts below the floor and outside the wall. Its pegs use
the same port dimensions and sit 9 and 19 mm from the exterior corner.
Like the other joins, every peg has an identical screw-clearance hole.

The four corner stations remain standard connector ports. Their 3.7 mm insert
pilots end at the normal shoulder, while a 3.4 mm M3 clearance continues
through the final 1 mm backing wall. Each corner therefore accepts the normal
peg and heat-set insert or an M3 pan-head mounting screw through the plate.

One plate is the default product. When both faces are required, place two
identical plates flat-back to flat-back and fasten them through the four corner
ports; no adhesive or second plate design is required.

`through_plate(columns,rows)` is the mounting-oriented variant: every grid
station remains a standard RobotSkin port while its M3 centre continues through
the full plate. The production exports are 5×3 (50×30 mm), 5×8 (50×80 mm),
8×8 (80×80 mm), and 12×10 (120×100 mm).

The Grove carriers have fixed, published PCB footprints: `grove_carrier_2x2()`
fits only the 20×20 mm Seeed Studio 101020083 Grove Gesture v1.0 with two
2.2 mm holes on its centre line; `grove_carrier_4x2()` fits only the 40×20 mm
Seeed Studio 101020585 Grove IMU 9DOF with its asymmetric three 2.2 mm holes.
The LCD carrier fits only Seeed Studio 104020111: its two RobotSkin lock
stations remain outside the 80×40 mm PCB footprint, while four bosses match
its 76×36 mm hole pitch. All Grove PCB pilots are blind and leave 2 mm of
plastic below the screw path.
