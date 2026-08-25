# RobotMind modular sensor system

RobotMind has one connection rule: an annular blind octagonal port accepts a
hollow octagonal peg around its centre boss.

`scad/source/rm_system.scad` is the single source of truth: all dimensions,
the interface, and every part definition live there. `scad/parts/` contains
only export entry points; the build discovers them automatically.
Press parts together by hand; install M3×3×4 heat-set inserts and M3×6 screws
through any peg centre when the joint must be permanent.

The brass insert always goes in the plate's female port—not in a join. For a
permanent joint, use one 4.0 mm-OD M3×3×4 insert and one M3×6 pan-head screw
at every occupied lock station. See `docs/ASSEMBLY.md`.

The first printed set has four product categories:

1. `plate_8x8` — 80×80 mm, double-sided 8×8 mounting grid.
2. `flat_join` — a 20 mm two-column tile; use one to four to join coplanar plate edges.
3. `angle_join` / `outer_angle_join` — 20 mm inside/outside 90° tiles; use one to four per edge.
4. `grove_plaque` — a generic 20 mm Grove board plaque.

## Print and calibrate

```bash
./scripts/build.sh
```

The build also regenerates the assembly previews in `renders/`.

First run `./scripts/build_test_parts.sh`. Its five male samples establish
`RM_PEG_FIT` against a nominal 2×2 female tile before you print production
parts; see `docs/CALIBRATION.md`.

Ports are blind on both plate faces, retaining a 2 mm centre membrane. The
first release makes no water-resistance claim; validate the dry mechanical
interface before adding seals.

Print [VOCABULARY.svg](docs/VOCABULARY.svg) at 100% for the part names and
connection vocabulary.

Print plates face down. Print the flat join and plaque peg-side up. Angle joins
need local support below the peg row that is perpendicular to the print bed.

## Preview the system

```bash
./scripts/render_previews.sh
```

This writes `overview.png`, `port.png`, `flat.png`, `angle.png`, and
`outer_angle.png` to `renders/`. The port view is a cutaway of the assembled
plate port, peg, and 4.0 mm-OD brass insert. The insert sits flush in the 3 mm
blind pilot, leaving its M3 threaded centre open for the screw. Insert it from
the exposed plate face before mounting a join or plaque.
