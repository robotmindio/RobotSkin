# RobotSkin repository guidance

## Source map

- Read `THESIS.md` for product intent and scope.
- `scad/lib/robotskin.scad` is the shared implementation. Fix reusable geometry
  and interface behavior there instead of patching individual exports.
- `scad/parts/*.scad` are minimal production export entry points discovered by
  `scripts/build.sh`.
- `scad/test/alignment.scad` contains executable geometry and interface checks.
- Generated files in `stl/`, `test-stl/`, `renders/`, and `dist/` are build
  outputs; do not edit or commit them.

## Mechanical contract

- Every part must reuse the shared 10 mm connector interface. Do not introduce
  another connector, carrier family, plate family, or enclosure without an
  explicit product decision.
- Treat grid spacing, port and peg geometry, insert geometry, plate thickness,
  screw clearances, hole locations, and external dimensions as compatibility
  behavior. Change the shared definition and all affected callers together.
- Only `RM_PORT_FIT`, `RM_PEG_FIT`, and `RM_INSERT_BORE` are expected to vary by
  printer or material. Preserve these physical calibration knobs.
- RobotSkin V0.1 is unrated engineering hardware. Do not infer or publish load
  claims from geometry alone; follow `docs/QUALITY.md`.

## Documentation ownership

- `docs/INTERFACE.md`: published mechanical interface and compatibility rules.
- `docs/LIBRARY.md`: public OpenSCAD API and reusable components.
- `docs/PRODUCT.md`: SKUs, revisions, BOM, and product compatibility.
- `docs/ASSEMBLY.md`: physical assembly and fastener sequence.
- `docs/CALIBRATION.md`, `docs/PRINTING.md`, and `docs/QUALITY.md`: manufacturing
  and release gates.
- Update only the documents whose contract changed. Cross-link instead of
  repeating the same specification in multiple files.

## Change and validation workflow

- Keep production wrappers in `scad/parts/` minimal: include the library and
  invoke one finished-part module in its export orientation.
- For OpenSCAD logic or shared geometry changes, run the fast assertion check:

  ```bash
  openscad --export-format csg -o /dev/null scad/test/alignment.scad
  ```

- For production geometry changes, build and validate every exported mesh:

  ```bash
  ./scripts/build.sh
  python scripts/validate_stl.py stl/*.stl
  ```

- Run `./scripts/build_test_parts.sh` when calibration geometry changes.
- Run `./scripts/package_release.sh` for release-affecting changes. CI tool
  versions and the authoritative full workflow live in
  `.github/workflows/validate.yml`.
