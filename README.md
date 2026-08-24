# RobotMind modular panels

RobotMind is a double-sided construction system for robotics:

`solid panel + integral pegs + hermaphrodite edges + optional M3 screws`

Nothing passes through a panel. Every mounting port is blind on both faces,
leaving a continuous membrane in the centre. Panels join each other directly
through identical battlement edges — no connector parts exist. Carriers press
into the same face ports without loose pins.

## System MVP

- 40 mm structural unit and clean 10 mm mounting grid.
- 8 mm solid panels in 40×40, 80×40 and 80×80 mm sizes.
- Sixteen hexagonal blind ports per face of a 40×40 panel, identical on
  both faces.
- Identical hermaphrodite battlements on all four edges: any edge mates any
  edge of any neighbour, flat or folded to 90°, with no extra parts.
- Integral tapered pegs for tool-free carrier mounting.
- A blind M3 pilot inside every port for optional locking.
- One Grove 20×20 carrier using the same two integral pegs.
- One calibration control: `RM_FIT`. Positive values loosen printed fits.

## Print and calibrate

```bash
./scripts/build.sh
```

Print `fit_test_port.stl`, the three `fit_test_peg_*.stl` files and two
`edge_coupon.stl` copies first. The small and large pegs differ from nominal
by 0.1 mm. Adjust `RM_FIT` in 0.05 mm steps and rebuild.

Panels print face down; the edge tabs are horizontal cantilevers, so add
small local supports under the exposed tabs. Coupons print on the exported
side orientation, features up, support-free. The Grove carrier prints on the
exported side orientation.

PETG, 0.20 mm layers and four perimeters are a reasonable prototype baseline.

## Assembly

- Payload: press two integral carrier pegs into any two face ports.
- Locked payload: add short M3 screws through the peg centres.
- Flat seam: butt two panels; their battlements interleave as-is. Never
  twist a panel 90° relative to its neighbour.
- 90° corner: fold a panel up about the shared edge; the same battlements
  engage through the fold.
- Closed boxes: fold five walls, drop the lid last. Wall-to-wall vertical
  seams are still being validated; see docs/CALIBRATION.md before relying
  on a full cube.

## Manufacturing

The exterior interface pulls from the two broad panel faces and uses no
undercuts. The 8 mm solid panel is the simplest FDM prototype, not final
injection DFM; a mould engineer should core or split the body after load
tests freeze the interface. Draft, shrink, gates and ejectors remain
process-specific.

Shared dimensions and geometry live only in `scad/source/rm_common.scad`.

## Assembly images

```bash
./scripts/render_previews.sh
```

The command regenerates the PNG files in `renders/` directly from OpenSCAD.
