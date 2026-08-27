# RobotMind modular sensor system

RobotMind has one connection rule: an annular blind octagonal port accepts a
hollow octagonal peg around its centre boss.

`scad/lib/robotmind.scad` is the reusable design library and single source of
truth. `scad/parts/` contains only export entry points; the build discovers
them automatically. See `docs/LIBRARY.md` for the public API and hierarchy.
Press parts together by hand; install M3×3×4 heat-set inserts and M3×6 screws
through any peg centre when the joint must be permanent.

The Grove carrier's PCB uses four M2.5×6 thread-forming screws in blind top
pilots. These are payload fasteners; the carrier itself retains the common M3
RobotMind lock hardware.

The brass insert always goes in the plate's female port—not in a join. For a
permanent joint, use one 4.0 mm-OD M3×3×4 insert and one M3×6 pan-head screw
at every occupied lock station. See `docs/ASSEMBLY.md`.

The production set contains:

1. `plate_8x8` — 80×80×4 mm single-sided base with a full 8×8 port grid.
2. `flat_join` — a 20 mm two-column tile; use one to four to join coplanar plate edges.
3. `angle_join` / `outer_angle_join` — 20 mm inside/outside 90° tiles; use one to four per edge.
4. `grove_carrier_*` — serviceable carriers for all five nominal Grove sizes.
5. `apriltag_holder_50` — a glue-free frame for a replaceable 50 mm tag.
6. `tripod_adapter` — a plate-underlay adapter for a captive 1/4-20 nut.
7. `profile_2020_adapter` — two RobotMind ports mounted with two M5 T-nuts.
8. `din_rail_adapter` — four RobotMind ports on an end-slide TH35 rail mount.
9. `grove_cable_clip` — a single-station retainer for flat Grove cable.
10. `uno_carrier` — an orthogonal open-frame carrier for the standard
    asymmetric UNO hole layout.
11. `through_plate_5x3` / `through_plate_5x8` — full port grids with an M3
    clearance path through every station.

The authoritative V0.1 catalog, SKU scheme, hardware BOM, and compatibility
matrix are in [`docs/PRODUCT.md`](docs/PRODUCT.md). Use
[`docs/PRINTING.md`](docs/PRINTING.md) for the release print profile and
[`docs/QUALITY.md`](docs/QUALITY.md) for acceptance and load qualification.
V0.1-alpha remains unrated engineering-evaluation hardware.

## Print and calibrate

Create compatible geometry directly from port counts:

```scad
include <scad/lib/robotmind.scad>

plate(8,8);
// plate(4,6); // same interface, 40×60 mm
```

```bash
./scripts/build.sh
```

The build also regenerates the assembly previews in `renders/`.
CI runs `scripts/validate_stl.py` over every production STL and rejects open,
inverted, empty, or disconnected meshes. Run the same gate locally with:

```bash
python scripts/validate_stl.py stl/*.stl
```

Create the complete versioned engineering package, including STLs, calibration
parts, drawings, documentation, source, and SHA-256 manifests, with:

```bash
./scripts/package_release.sh
```

The archive and its checksum are written to `dist/`. GitHub Actions runs the
same command and uploads the result when Actions execution is available.

First run `./scripts/build_test_parts.sh`. Its five male samples establish
`RM_PEG_FIT` against a nominal 2×2 female tile before you print production
parts; see `docs/CALIBRATION.md`.

Ports face upward over a flat printable back and retain a 1 mm backing wall.
The four corner ports continue through that wall for surface mounting with the
same M3 pan-head screws used elsewhere in the kit. The first release makes no
water-resistance claim; validate the dry mechanical interface before adding seals.

Print [VOCABULARY.svg](docs/VOCABULARY.svg) at 100% for the part names and
connection vocabulary.

Print plates flat-side down. Print the flat join and carrier peg-side up. Angle joins
need local support below the peg row that is perpendicular to the print bed.
The UNO carrier STL is pre-oriented on its long solid edge so neither its pegs
nor its PCB standoffs create floating regions; add local support only if your
printer cannot bridge the horizontal connector details cleanly.

## Preview the system

```bash
./scripts/render_previews.sh
```

This writes `overview.png`, interface and assembly views, including `grove.png`,
`grove_family.png`, `uno.png`, and `adapters.png`, to `renders/`. The port view is a cutaway of the assembled
plate port, peg, and 4.0 mm-OD brass insert. The insert sits flush in the 3 mm
blind pilot, leaving its M3 threaded centre open for the screw. Insert it from
the exposed plate face before mounting a join or carrier.
