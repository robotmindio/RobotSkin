# RobotMind V4 mechanical interface

## Panel

- Structural unit: 40 mm.
- Mounting pitch: 10 mm.
- Panel thickness: 8 mm.
- Corner radius: 3 mm.
- Blind pilot depth: 3 mm from either face.
- Continuous centre membrane: 2 mm minimum.
- Valid sizes: whole 40 mm multiples in X and Y.

The bottom face of every panel carries a complete port grid: 4×4 on a 40×40
panel, 8×8 on an 80×80 panel. Port centres are 5 mm from every outer edge.
The top face carries the same grid minus its outermost lines flanking the
female edges (see Panel edges below): 3×3 full ports remain on a 40×40
panel. Screws and carriers reach every region of the top face through the
edge bores or the remaining grid.

The 8 mm thickness is not independent: the `rm_common.scad` assertion requires
it to exceed two opposing blind M3 pilots plus the 2 mm membrane. A thinner,
cheaper panel therefore means dropping the optional screw pilot, not shrinking
clearances.

## Panel edges

Panels join directly edge-to-edge with no spacer parts:

- North and east edges are male: integral Pegs, 4 mm long, centred in the
  strip at every second grid line (±10 mm on a 1 U edge).
- South and west edges are female: horizontal edge Ports drilled inward,
  same hexagon and M3 pilot profile as face Ports but 10 mm deep.
- A 6 mm wide interior Rib thickens each female edge to 12 mm local
  thickness so the horizontal bores keep real walls inside the 8 mm panel.
- Mating is N-to-S and E-to-W; peg axes and bore axes align across any
  tessellation because anchors sit between mounting columns.

The bores pass beneath the top-face port band adjacent to female edges, so
that band stays solid rather than opening a face-to-interior leak path. The
opposite face keeps its complete grid. Edge joints are structural only:
sealing still comes from a Link and Gasket across the seam.

## Hexagonal mounting port

The only payload and connector interface is one concentric blind port:

- Outer hexagon corner-to-corner diameter: 8 mm nominal.
- Circular centre boss diameter: 5 mm nominal.
- Groove depth: 2.2 mm.
- M3 pilot diameter: 2.7 mm nominal.
- M3 pilot depth: 3 mm.
- Integral peg entry: 0.2 mm diametric clearance.
- Integral peg final grip: 0.2 mm diametric interference.

Two hexagonal pegs prevent payload rotation. The broad payload base carries
the moment; the short pegs locate and retain it. A screw may pass through a
peg's circular centre and self-form into the blind pilot. Production thread
geometry must be matched to the chosen screw and resin.

`RM_FIT` enlarges the groove, reduces the centre boss and shrinks the peg.
Positive values therefore loosen both radial peg surfaces together.

## Panel connectors

`flat_link(length)` bridges the back of a coplanar seam. `angle_link(length)`
holds two panels at 90°. Both lengths use whole 40 mm units. Flat links place
four pegs per panel per unit; angle links place two rows of four pegs per face.

The 90° peg and screw axes point away from the connector into their respective
panels. Their 5 mm offsets exceed the 3.2 mm connector wall, so perpendicular
hardware cannot intersect.

Every link includes a shallow groove for its matching TPU gasket:

- Gasket width: 5 mm.
- Gasket nominal thickness: 0.8 mm.
- Connector groove depth: 0.4 mm.

The 0.4 mm protrusion supplies initial compression. Material hardness and
final compression require physical leak coupons.

## Source ownership

- `rm_common.scad`: panel, port, peg, both connectors, both gaskets, the
  edge interface and every shared mechanical dimension.
- `00_fit_tests.scad`: fit coupons and assembly checks only.
- `01_panels.scad`: panel export parameters only.
- `02_connectors.scad`: connector export parameters only.
- `03_grove_20x20_carrier.scad`: Grove envelope and board retention only.
- `04_assembly_previews.scad`: non-manufacturing presentation scenes only.
- `05_edge_coupons.scad`: 1 U male and female edge coupons only.

Payload dimensions never belong in `rm_common.scad`. A second mechanical
interface should not be introduced unless the hexagonal port physically cannot
serve the use case.

## Prototype order

1. Tune one port and the three peg coupons.
2. Mount and remove one two-peg carrier 50 times.
3. Join two panels flat and at 90° without screws.
4. Repeat both joints with short M3 screws.
5. Join two panels through their integral edges; then test one gasketed flat
   seam and one gasketed corner under spray.
6. Build a three-panel corner before attempting a complete cube.
