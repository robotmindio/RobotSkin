# RobotMind modular sensor system

RobotMind has one connection rule: an annular blind octagonal port accepts a
hollow octagonal peg around its centre boss.

`scad/source/rm_system.scad` is the single source of truth: all dimensions,
the interface, and every part definition live there. The other source files
only name the part to export.
Press parts together by hand; install M3×3×4 heat-set inserts and M3 screws
through the peg centres when the joint must be permanent.

The first printed set has four product categories:

1. `plate_8x8` — 80×80 mm, double-sided 8×8 mounting grid.
2. `flat_join` — joins two full plate edges coplanar.
3. `angle_join` / `outer_angle_join` — inside/outside variants of one 90° join.
4. `grove_plaque` — a generic 20 mm Grove board plaque.

## Print and calibrate

```bash
./scripts/build.sh
```

The build also regenerates the assembly previews in `renders/`.

Print one plate and one Grove plaque first. The plaque pegs should enter with
firm thumb pressure, resist rotation, and remove without damaging the port.
Tune `RM_FIT` in 0.05 mm steps only after recording a physical trial.

Ports are blind on both plate faces, retaining a 2 mm centre membrane. For a
permanent splash-resistant seam, fill the join's shallow underside groove with
neutral-cure silicone before tightening the screws. This is not an IP rating.

Print plates face down. Print the flat join and plaque peg-side up. Angle joins
need local support below the peg row that is perpendicular to the print bed.

## Preview the system

```bash
./scripts/render_previews.sh
```

This writes `overview.png`, `port.png`, `flat.png`, `angle.png`, and
`outer_angle.png` to `renders/`. The port view shows the 4.0 mm-OD brass insert seated by melt-press
interference in the 3.7 mm blind pilot; its entry chamfer guides the brass and
the enlarged boss supports it for the full 3 mm depth. Insert it from the
exposed plate face before mounting a join or plaque.
