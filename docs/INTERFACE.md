# RobotMind mechanical interface

## Panel

- Structural unit: 40 mm.
- Mounting pitch: 10 mm.
- Panel thickness: 8 mm.
- Corner radius: 3 mm.
- Port centre inset: 5 mm from every outer edge.
- Continuous centre membrane: 3 mm minimum between opposing face bores.

Both faces carry the same complete port grid: 4×4 on a 40×40 panel, 8×4 on
an 80×40 panel, 8×8 on an 80×80 panel. Port centres are 5 mm from every
outer edge. There is no face with fewer ports; the two faces are
interchangeable.

The 8 mm thickness exists to keep two opposing blind bores from meeting
through the 3 mm membrane. A thinner panel means dropping the insert bore,
not shrinking clearances.

## Panel edges

Clean butt cuts. Panels sit flush edge-to-edge with the seam centred on a
half-pitch line (20 mm between end-capped rows). The interface for joining
is the link — no material key, interlock or interleaving lives on the edge
itself. The seam runs on the mounting grid, not the edge material.

## Hexagonal mounting port

The only payload and connector interface is one concentric blind port:

- Outer hexagon corner-to-corner diameter: 8 mm nominal.
- Hex ring depth: 2.2 mm.
- Centre bore diameter: 3.4 mm nominal (melt-press fit for an M3 brass
  knurled heat-set insert, 4.0 mm outer diameter).
- Centre bore depth: 3.0 mm blind; opposing bores leave a 3 mm membrane.
- Integral peg entry: 0.2 mm diametric clearance.
- Integral peg final grip: 0.2 mm diametric interference.
- Peg centre bore: 4.2 mm, clears a seated insert for through-pegging or M3
  pass-through.

Two hexagonal pegs prevent payload rotation. The broad payload base carries
the moment; the short pegs locate and retain it.

`RM_FIT` enlarges the port and bore, and shrinks the peg. Positive values
therefore loosen both radial fits together.

## Panel connectors

A seam is a butt joint between two clean panel edges. The only connector is
the link:

- `flat_link_<L>`: a flat bracket bridging a coplanar seam, holes at ±5 mm
  off the seam line (the two seam-adjacent port rows), columns repeated
  every 20 mm.
- `angle_link_<L>`: a 90° bracket for box corners; the fold line sits at the
  inner corner, holes land on the first two free port rows of each panel
  from the fold.

Every link hole sits on a port centre. Screws pass through the link into the
port bore where an M3 brass heat-set insert supplies the thread. The insert
is seated with a soldering iron / heat-set gun; the screw fastens the joint.
For demountable links, the pegs press into the same bores without an insert.

## 90° corners and fastening

- **Corner:** solved. A 90° fold between two edges is bracketed by an
  `angle_link` with screws through the two inner port rows.
- **Fastening:** pegs are press-fit by design. Where a joint must be
  demountable, an M3 screw threads through the peg centre (or through a
  link bracket) into the blind bore. For repeated service, the bore seats an
  M3 brass heat-set insert; the screw then engages metal instead of plastic.

## Source ownership

- `scad/source/rm_common.scad`: panel, port, peg, link, shared dims.
- `scad/source/panels.scad`: panel export parameters only.
- `scad/source/links.scad`: link export parameters only.
- `scad/source/grove_carrier.scad`: Grove envelope and board retention only.
- `scad/source/previews.scad`: non-manufacturing presentation scenes only.
- `scad/test/fit_tests.scad`: port and peg fit coupons only.
- `scad/test/seam_coupon.scad`: flat-link coupling seat probe only.

Payload dimensions never belong in `rm_common.scad`. A second mechanical
interface should not be introduced unless the hexagonal port physically cannot
serve the use case.

## Prototype order

1. Tune one port and the three peg coupons.
2. Mount and remove one two-peg carrier 50 times.
3. Join two panels flat, edge-to-edge, with a `flat_link_40`.
4. Join two panels at 90° with an `angle_link_40`.
5. Seat real inserts and bolt the links down for a load test.