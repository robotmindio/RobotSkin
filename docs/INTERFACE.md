# RobotMind V4 mechanical interface

## Panel

- Structural unit: 40 mm.
- Mounting pitch: 10 mm.
- Panel thickness: 8 mm.
- Corner radius: 3 mm.
- Blind pilot depth: 3 mm from either face.
- Continuous centre membrane: 2 mm minimum.
- Valid sizes: whole 40 mm multiples in X and Y.

A 40×40 panel has a 4×4 port grid on each face. An 80×80 panel has an 8×8 port
grid. Port centres are 5 mm from every outer edge.

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
holds two panels at 90°. Both lengths use whole 40 mm units and place four pegs
per panel per unit.

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

- `rm_common.scad`: panel, port, peg, both connectors, both gaskets and every
  shared mechanical dimension.
- `00_fit_tests.scad`: fit coupons and assembly checks only.
- `01_panels.scad`: panel export parameters only.
- `02_connectors.scad`: connector export parameters only.
- `03_grove_20x20_carrier.scad`: Grove envelope and board retention only.
- `04_assembly_previews.scad`: non-manufacturing presentation scenes only.

Payload dimensions never belong in `rm_common.scad`. A second mechanical
interface should not be introduced unless the hexagonal port physically cannot
serve the use case.

## Prototype order

1. Tune one port and the three peg coupons.
2. Mount and remove one two-peg carrier 50 times.
3. Join two panels flat and at 90° without screws.
4. Repeat both joints with short M3 screws.
5. Test one gasketed flat seam and one gasketed corner under spray.
6. Build a three-panel corner before attempting a complete cube.
