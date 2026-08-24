# RobotMind mechanical interface

## Panel

- Structural unit: 40 mm.
- Mounting pitch: 10 mm.
- Panel thickness: 8 mm.
- Corner radius: 3 mm.
- Blind pilot depth: 3 mm from either face.
- Continuous centre membrane: 2 mm minimum.
- Valid sizes: whole 40 mm multiples in X and Y.

Both faces carry the same complete port grid: 4×4 on a 40×40 panel, 8×8 on
an 80×80 panel. Port centres are 5 mm from every outer edge. There is no
face with fewer ports; the two faces are interchangeable.

The 8 mm thickness exists to keep two opposing blind M3 pilots from meeting
through the 2 mm membrane. A thinner panel means dropping the optional screw
pilot, not shrinking clearances.

## Panel edges

Every panel carries the same battlement edge on all four sides:

- Tabs, 6 mm wide, 3 mm thick, centred in the panel thickness, proud of the
  face by 4 mm.
- Sockets, the same width and thickness, 4 mm deep.
- On each edge, tabs occupy the even grid lines and sockets the odd, or the
  reverse; the arrangement rotates around the perimeter so that any edge
  mates the opposing edge of any neighbour.
- Two panels mate edge-to-edge when one leads with tabs where the other leads
  with sockets. This works across any tessellation and under a 180° flip.
- A 90° in-plane twist does not mate. Dimensions are chosen so the tabs and
  sockets merely collide; never force it.

Because the edge is identical on all four sides, there is no north/east or
south/west specialisation. A panel has no top, no bottom and no preferred
orientation for joining.

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

There are none. Joints are direct panel-to-panel, so a seam can be crossed
with no spacer part. The battlement arrangement is what makes this possible,
and it is the only edge hardware.

## 90° corners and fastening

- **Corner state:** a 90° fold between two edges or a two-wall corner is an
  open build question. The `corner_coupon` probe is the current instrument;
  once it returns, this section either declares corners free or introduces
  the one corner part the observed failure demands. No corner geometry is
  assumed in the meantime.
- **Fastening:** pegs are press-fit by design. Where a joint or carrier must
  be demountable, an optional M3 screw threads through the peg centre into
  the blind pilot. For repeated service, the pilot can seat a metal heat-set
  insert that supplies the thread; the screw then engages metal instead of
  plastic. The insert seat itself is a future version of the pilot, not
  present in this one's geometry.

## Source ownership

- `scad/source/rm_common.scad`: panel, port, peg, battlements, shared dims.
- `scad/source/panels.scad`: panel export parameters only.
- `scad/source/grove_carrier.scad`: Grove envelope and board retention only.
- `scad/source/previews.scad`: non-manufacturing presentation scenes only.
- `scad/test/fit_tests.scad`: port and peg fit coupons only.
- `scad/test/edge_coupons.scad`: hermaphrodite battlement coupon only.
- `scad/test/corner_coupon.scad`: 90° fold probe only.

Payload dimensions never belong in `rm_common.scad`. A second mechanical
interface should not be introduced unless the hexagonal port physically cannot
serve the use case.

## Prototype order

1. Tune one port and the three peg coupons.
2. Mount and remove one two-peg carrier 50 times.
3. Join two panels flat, edge-to-edge, by hand, with battlements alone.
4. Print and fold the corner coupon; record in docs/CALIBRATION.md whether
   a 90° corner holds or slips.
5. Act on the corner result, then test optional M3 locking through peg
   centres on the real joints.