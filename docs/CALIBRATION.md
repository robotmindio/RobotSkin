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
| | 0.00 | small | | | | |
| | 0.00 | nominal | | | | |
| | 0.00 | large | | | | |

Selected production value: `RM_FIT = ____`

## Step 2 — Carrier cycle test

Mount one two-peg Grove carrier into one port pair and remove it repeatedly.

| Cycles completed | Pegs worn? | Ports worn? | Still retained? |
|---|---|---|---|
| | | | |

Target: 50 clean cycles.

## Steps 3–4 — Panel joints

Join two panels flat and at 90° with pegs only, then repeat with short M3
screws through the peg centres.

| Joint | Pegs only holds? | M3 locks cleanly? | Notes |
|---|---|---|---|
| Flat seam | | | |
| 90° corner | | | |

## Step 5 — Gasket spray test

Install TPU gaskets on one flat seam and one gasketed corner. Spray the
assembly and inspect the interior.

| Coupon | Duration | Interior dry? | Notes |
|---|---|---|---|
| Flat seam | | | |
| Corner | | | |

No `waterproof` or IP claim may be published until this row passes.

## Step 6 — Three-panel corner

Assemble the three-panel corner before any complete cube.

| Assembled? | Alignment acceptable? | Notes |
|---|---|---|
| | | |
