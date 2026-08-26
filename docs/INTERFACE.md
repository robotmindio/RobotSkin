# RobotMind interface

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
| Peg root / tip | 8.3 / 7.7 mm across flats |
| Peg depth | 2.2 mm |
| Permanent lock | M3×6 pan-head screw, 2 mm insert engagement |
| Grove PCB retention | M2.5×6 thread-forming screw, 2.1 mm blind pilot |
| Profile 2020 mounting | Two M5 clearance holes, 30 mm apart |
| DIN rail | EN 60715 TH35 rigid end-slide channel |
| Tripod | Captive 1/4-20 hex nut, 4.5 mm maximum screw entry |

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
geometrically symmetric L-shaped part with two identical 20 mm legs and the
same 5/15 mm connector rows on each face. Its outer ends use the same rounded
corners as the Grove carrier while both contact faces remain flat. One to four
tiles span a 20–80 mm run on a single surface.

`outer_angle_join` mounts below the floor and outside the wall. Its pegs use
the same port dimensions but sit 9 and 19 mm from the exterior corner, rather
than the inner join's symmetric 5 and 15 mm rows.
Like the other joins, every peg has an identical screw-clearance hole.

The four corner stations remain standard connector ports. Their 3.7 mm insert
pilots end at the normal shoulder, while a 3.4 mm M3 clearance continues
through the final 1 mm backing wall. Each corner therefore accepts the normal
peg and heat-set insert or an M3 pan-head mounting screw through the plate.

One plate is the default product. When both faces are required, place two
identical plates flat-back to flat-back and fasten them through the four corner
ports; no adhesive or second plate design is required.

The Grove carrier keeps its two RobotMind lock stations outside the PCB
footprint. The PCB sits 3 mm above the carrier on four bosses and is retained
from above; its blind pilots leave 2 mm of plastic below the screw path.
