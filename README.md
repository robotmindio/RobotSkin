# RobotMind modular panels

RobotMind is a double-sided construction system for robotics:

`blind panel grid + integral pegs + bolted link brackets + optional M3 screws`

Nothing passes through a panel. Every mounting port is a blind hexagon with a
concentric bore; the bore seats an M3 brass heat-set insert when the joint
must be bolted, and the peg press of a carrier needs no insert at all.
Panels butt edge-to-edge and a flat or angle link bracket carries the seam.

## System MVP

- 40 mm structural unit and clean 10 mm mounting grid.
- 8 mm solid panels in 40×40, 80×40 and 80×80 mm sizes.
- Sixteen hexagonal blind ports per face of a 40×40 panel, identical on
  both faces; each port has a concentric 3 mm blind bore for an insert.
- Clean panel edges: a seam is a direct butt with no edge hardware.
- Four linked joints: `flat_link_40`, `flat_link_80`, `angle_link_40`,
  `angle_link_80` for coplanar seams and 90° corners.
- Integral tapered pegs for tool-free carrier mounting.
- A blind 3.4×3.0 mm bore inside every port for an M3 brass heat-set insert
  (optional locking).
- One Grove 20×20 carrier using the same two integral pegs.
- One calibration control: `RM_FIT`. Positive values loosen printed fits.

## Print and calibrate

```bash
./scripts/build.sh
```

The script also runs the grid-alignment check, which fails the build if any
link hole lands off a panel port centre.

Print `fit_test_port.stl` and the three `fit_test_peg_*.stl` files first.
The small and large pegs differ from nominal by 0.1 mm. Adjust `RM_FIT` in
0.05 mm steps and rebuild.

Panels print face down; the edge is a clean butt, no cantilevered features,
so panels print support-free. The Grove carrier prints on the exported side
orientation. Links print flat, features up, support-free.

PETG, 0.20 mm layers and four perimeters are a reasonable prototype baseline.

## Assembly

- Carrier: press two integral carrier pegs into any two face ports.
- Locked carrier: add short M3 screws through the peg centres.
- Flat seam: butt two panels along the 20 mm seam line; seat M3 inserts in
  the seam-adjacent ports and bolt a `flat_link` over the seam.
- 90° corner: butt two panels at a fold; seat inserts in the inner port rows
  and bolt an `angle_link` in the inner corner.
- Box: build the five walls with flat links on flat seams and angle links on
  corners; drop the lid last.

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