# RobotMind V4 calibration record

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

Print both `edge_coupon_*.stl` at the selected `RM_FIT`. The male coupon's
pegs must press into the female coupon's bores by hand, align flush across
the joint, and separate without galling.

| Date | `RM_FIT` | Insertion | Flush? | Damage | Verdict |
|---|---|---|---|---|---|
| | | | | | |

## Step 3 — Carrier cycle test

Mount one two-peg Grove carrier into one port pair and remove it repeatedly.

| Cycles completed | Pegs worn? | Ports worn? | Still retained? |
|---|---|---|---|
| | | | |

Target: 50 clean cycles.

## Steps 4–5 — Panel joints

Join two panels flat and at 90° with pegs only, then repeat with short M3
screws through the peg centres.

| Joint | Pegs only holds? | M3 locks cleanly? | Notes |
|---|---|---|---|
| Flat seam | | | |
| 90° corner | | | |

## Step 6 — Edge joint and gasket spray test

Join two panels through their integral edges. Install TPU gaskets on one
flat seam and one gasketed corner. Spray the assemblies and inspect the
interiors.

| Coupon | Duration | Interior dry? | Notes |
|---|---|---|---|
| Edge joint | | | |
| Flat seam | | | |
| Corner | | | |

No `waterproof` or IP claim may be published until this row passes.

## Step 7 — Three-panel corner

Assemble the three-panel corner before any complete cube.

| Assembled? | Alignment acceptable? | Notes |
|---|---|---|
| | | |
