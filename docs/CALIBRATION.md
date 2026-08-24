# RobotMind calibration record

Every dimension in `rm_common.scad` is a hypothesis until a printed part says
otherwise. Record physical results here; do not tune geometry without logging
the measurement that motivated it.

## Baseline

| Field | Value |
|---|---|
| Printer | |
| Material | PETG |
| Layer height | 0.20 mm |
| Perimeters | 4 |
| Nozzle / temps | |

## Step 1 — Port and peg fit (`RM_FIT`)

Print `fit_test_port.stl` plus all three `fit_test_peg_*.stl` coupons at
`RM_FIT=0`. Test each peg by hand: it must insert with firm thumb pressure,
rotate-lock against the hex, and pull out without deforming the port.

Log every trial before changing the value:

| Date | `RM_FIT` | Peg coupon | Insertion | Retention | Damage | Verdict |
|---|---|---|---|---|---|---|
| | 0.00 | nominal | firm thumb press | held | none | OK — single informal trial |
| | | | | | | |

Selected production value: `RM_FIT = ____` (nominal 0.00 looks promising;
needs repeated trials before freezing).

## Step 2 — Edge coupons

Print one `edge_coupon.stl` (contains both mating halves, A and B) at the
selected `RM_FIT`. The two halves must press together by hand, align flush
across the joint, and separate without galling. Test both flat
orientations; then flip one half 180° and retest.

| Date | `RM_FIT` | Insertion | Flush? | Damage | Verdict |
|---|---|---|---|---|---|
| | | | | | |

## Step 3 — Carrier cycle test

Mount one two-peg Grove carrier into one port pair and remove it repeatedly.

| Cycles completed | Pegs worn? | Ports worn? | Still retained? |
|---|---|---|---|
| | | | |

Target: 50 clean cycles.

## Step 4 — Flat panel joints

Join two panels edge-to-edge, flat, with battlements only, then repeat with
short M3 screws through the peg centres.

| Joint | Pegs only holds? | M3 locks cleanly? | Notes |
|---|---|---|---|
| Flat seam | | | |

## Step 5 — Corner fold probe

Print one `corner_coupon.stl`. Fold its two leaves to 90°: the teeth either
keep the angle or slip apart.

| Date | `RM_FIT` | Engaged? | Slips? | Verdict |
|---|---|---|---|---|
| | | | | |

The result picks the corner strategy:

- Engages: corners fold with no extra part. Document the fold licence and
  continue; a cube is then a genuine build with no new catalogue entry.
- Slips: corners need one male part per corner. Design the corner gusset on
  its own geometry, with its own coupon, before any cube claim.

## Step 6 — M3 locking on real joints

Repeat the flat seam and any corner joint with short M3 screws through the
peg centres. Confirm the screw threads into the plastic pilot without
stripping at hand torque, for ten consecutive cycles.

| Joint | Threads? | Survives 10 cycles? | Notes |
|---|---|---|---|
| Flat seam | | | |

## Step 7 — Three-panel flat junction

Assemble three panels in a T before any more complex build. Confirm the
battlement parity holds at corner junctions, not just along straight seams.

| Assembled? | Alignment acceptable? | Notes |
|---|---|---|
| | | |