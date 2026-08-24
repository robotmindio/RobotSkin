# RobotMind modular sensor system

RobotMind has one connection rule: an annular blind hex port accepts a hollow
hex peg around its centre boss.
Press parts together by hand; install M3×3×4 heat-set inserts and M3 screws
through the peg centres when the joint must be permanent.

The first printed set is intentionally only four parts:

1. `plate_8x8` — 80×80 mm, double-sided 8×8 mounting grid.
2. `flat_join` — joins two full plate edges coplanar.
3. `angle_join` — joins two full plate edges at 90°.
4. `grove_plaque` — a generic 20 mm Grove board plaque.
5. `outer_angle_join` — joins a 90° corner from its exterior.

## Print and calibrate

```bash
./scripts/build.sh
```

The build also regenerates the assembly previews in `renders/`.

Print one plate and one Grove plaque first. The plaque pegs should enter with
firm thumb pressure, resist rotation, and remove without damaging the port.
Tune `RM_PEG_ENTRY` and `RM_PEG_GRIP` only after recording a physical trial.

Ports are blind on both plate faces, retaining a 2 mm centre membrane. For a
permanent splash-resistant seam, fill the join's shallow underside groove with
neutral-cure silicone before tightening the screws. This is not an IP rating.

## Preview the system

```bash
./scripts/render_previews.sh
```

This writes `overview.png`, `port.png`, `flat.png`, `angle.png`, and
`outer_angle.png` to `renders/`. The port view shows the 4.0 mm-OD brass insert seated by melt-press
interference in the 3.4 mm blind pilot; the boss supports it for the full 3 mm
depth. Insert it from the exposed plate face before mounting a join or plaque.
