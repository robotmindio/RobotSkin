# RobotMind calibration record

Every dimension in `rm_common.scad` is a hypothesis until a printed part
says otherwise. Record physical results here; do not tune geometry without
logging the measurement that motivated it.

## Baseline

| Field | Value |
|---|---|
| Printer | |
| Material | PETG |
| Layer height | 0.20 mm |
| Perimeters | 4 |
| Nozzle / temps | |

## Step 1 — Port and peg fit (`RM_FIT`)

Print `fit_test_port.stl` and the three `fit_test_peg_*.stl` coupons at
`RM_FIT=0`. The port coupon contains the full blind hexagon ring and bore.
Each peg must insert with firm thumb pressure, rotate-lock against the hex,
and pull out without deforming the port.

Log every trial before changing the value:

| Date | `RM_FIT` | Peg coupon | Insertion | Retention | Damage | Verdict |
|---|---|---|---|---|---|---|
| | | | | | | |

Selected production value: `RM_FIT = 0.00` nominal; tune in 0.05 mm steps
only after a repeated-trial record exists.

## Step 2 — Peg bore and M3 pass-through

Mount any two-peg carrier to a port pair. Run a short M3 screw through one
peg centre; it must pass through the peg and seat without binding.

| Carrier | Peg bore threads? | Binds? | Verdict |
|---|---|---|---|
| grove_20x20_carrier | | | |

## Step 3 — Insert seat

Press a 4.0 mm M3 brass knurled heat-set insert into the bore of a port
coupon. The coupon's bore is through so the insert presses in from the face
and can be pushed out for reuse. It must melt-press to the printed bore, sit
retained after cooling, and take an M3 screw with ordinary hand torque.

| Date | Insert od / bore | Melt-press holds? | Torque | Verdict |
|---|---|---|---|---|
| | | | | |

## Step 4 — Flat panel seam

Print the `seam_coupon.stl` (one slab carrying the four coupling bores) and
one `flat_link_40.stl`. The coupon bores are through; seat M3×3×4 inserts
pressed from the face, lay the link over the seam line, and run two M3
screws through the link holes into the seated inserts on each side. The seam
must hold under hand force with no slop.

| Joint | Printed | Seated inserts? | Holds? | Notes |
|---|---|---|---|---|
| Flat seam | seam_coupon + flat_link_40 | | | |

## Step 5 — Corner fold

Print one `angle_link_40`. Offer it across the 90° corner of two panels and
join with the inner row screws on both faces. Confirm a working 90° corner
with no gap at the fold.

| Date | Link | Engaged? | Gap? | Verdict |
|---|---|---|---|---|
| | | | | |

## Step 6 — Load cycling

Bolt a flat seam and an angle corner together, then flex them across the
useful torque range for ten cycles. Confirm the inserts stay seated and the
screws stay tight.

| Joint | Survives 10 cycles? | Notes |
|---|---|---|
| Flat seam | | |

## Step 7 — Three-panel flat junction

Assemble three panels in T flat, with the third panel bearing a carrier, and
confirm the seams square and the whole is rigid under load.

| Assembled? | Alignment acceptable? | Notes |
|---|---|---|
| | | |