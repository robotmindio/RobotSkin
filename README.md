# RobotMind V4 solid modular panels

RobotMind V4 is a double-sided construction surface for robotics:

`solid panel + integral pegs + optional M3 screws`

Nothing passes through a panel. Every mounting port is blind on both faces,
leaving a continuous 2 mm membrane in the centre. Carriers and panel
connectors press directly into the same ports without loose pins.

## V4 MVP

- 40 mm structural unit and clean 10 mm mounting grid.
- 8 mm solid panels in 40×40, 80×40 and 80×80 mm sizes.
- Hexagonal blind port grids on both faces; the top-face lines flanking the
  female edges stay solid because the horizontal edge bores pass beneath.
- Integral tapered pegs for tool-free mounting.
- Direct tool-free panel joins: male pegs on north/east edges press into
  female ports on south/west edges, with no spacer parts.
- A blind M3 pilot inside every port for optional locking.
- Full-edge flat and 90° connectors in 40 and 80 mm lengths.
- Optional TPU gasket strips for panel seams.
- Grove 20×20 carrier using the same two integral pegs.
- One calibration control: `RM_FIT`. Positive values loosen printed fits.

The hexagonal port does two jobs without two interfaces: its outer groove and
peg prevent rotation, while its circular centre boss receives a short M3
screw. A screw ends inside the panel and cannot pierce the opposite face.

## Print and calibrate

```bash
./scripts/build.sh
```

Print `fit_test_port.stl`, the three `fit_test_peg_*.stl` files and the two
`edge_coupon_*.stl` files first. The small and large pegs differ from nominal
by 0.1 mm. Adjust `RM_FIT` in 0.05 mm steps and rebuild.

Panels print face down; their integral edge pegs are horizontal cantilevers,
so add small local supports under the four exposed pegs or accept slight
sag on the underside. Print the flat connector with its pegs upward. Print
the Grove carrier and the edge coupons on the exported side orientation.
The 90° connector may need small local supports under one peg direction; it
deliberately remains one piece instead of adding an assembly.

PETG, 0.20 mm layers and four perimeters are a reasonable prototype baseline.
TPU is appropriate for the optional gasket strips.

## Assembly

- Payload: press two integral carrier pegs into any two compatible ports.
- Locked payload: add short M3 screws through the peg centres.
- Direct edge join: press a panel's male north/east edge into the matching
  female edge of a neighbour, north-to-south and east-to-west.
- Flat panels: place `flat_link` behind the seam and press both panels on it.
- 90° panels: press both panels onto the two faces of `angle_link`.
- Sealed seam: install the matching gasket in the connector groove first.

Flat connectors use four pegs per 40 mm panel edge. 90° connectors use two
rows of four pegs on each face. Their optional screws point out into separate
blind panel pilots; perpendicular screws never meet inside the corner.

## Water-resistance boundary

Panel faces and every mounting pilot are blind, so water has no direct path
through a panel. Direct edge joints are structural alignment, not seals:
water sealing comes from the connector gaskets, which cover flat and 90°
seams continuously. This MVP targets rain and splashes, not certified
immersion: the ends where three cube edges meet still require a physical
leak test and probably a small moulded corner boot. No IP or `waterproof`
claim should be made before that test.

## Manufacturing

The V4 exterior interface pulls from the two broad panel faces and uses no
blind undercut. The 8 mm solid panel is the simplest FDM prototype, not final
injection DFM; a mould engineer should core or split the body after resin,
load and sealing tests freeze the interface. Draft, shrink, gates, ejectors
and connector tooling remain process-specific.

Shared dimensions and geometry live only in `scad/rm_common.scad`.

## Assembly images

```bash
./scripts/render_previews.sh
```

The command regenerates the PNG files in `renders/` directly from OpenSCAD.
