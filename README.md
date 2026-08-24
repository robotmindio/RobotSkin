# RobotMind modular sensor system

RobotMind has one connection rule: a blind hex port accepts a hollow hex peg.
Press parts together by hand; install M3×3×4 heat-set inserts and M3 screws
through the peg centres when the joint must be permanent.

The first printed set is intentionally only four parts:

1. `plate_8x8` — 80×80 mm, double-sided 8×8 mounting grid.
2. `flat_join` — joins two full plate edges coplanar.
3. `angle_join` — joins two full plate edges at 90°.
4. `grove_plaque` — a generic 20 mm Grove board plaque.

## Print and calibrate

```bash
./scripts/build.sh
```

Print `fit_test.stl` first. The peg should enter with firm thumb pressure,
resist rotation, and remove without damaging the port. Tune `RM_PEG_ENTRY`
and `RM_PEG_GRIP` only after recording a physical trial.

Ports are blind on both plate faces, retaining a 2 mm centre membrane. For a
permanent splash-resistant seam, fill the join's shallow underside groove with
neutral-cure silicone before tightening the screws. This is not an IP rating.
