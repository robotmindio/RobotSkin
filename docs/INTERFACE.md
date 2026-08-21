# RobotMind V3 interface

## Structural grid

- Unit: 40 mm.
- Pitch: 8 mm in X and Y.
- Plate thickness: 3.2 mm.
- Nominal hole diameter: 5.0 mm.
- Hole centres begin 4 mm from each plate edge, so grids remain continuous
  across an assembled seam.
- Plate sizes are whole multiples of 40 mm.

Every structural attachment uses these through-holes. There are no special
carrier sockets or active plate edges.

## Fasteners

The standard split push pin joins exactly two 3.2 mm layers. Its open-ended
split prints upright and lets the tip flex during assembly. The head bears on
the connector and the split tip retains the far plate. Material and mold
ejection still require physical validation.

The same nominal 5 mm holes accept ordinary M4 hardware. Push pins are the
tool-free mode; bolts and nuts are the locked mode.

`RM_FIT` adjusts both sides of the printed fit. Positive values enlarge holes
and shrink pins. Tune it in 0.05 mm steps using the fit coupon.

## Connectors

- `flat_link()`: a 16×24 mm bridge with two pins on each side of a seam.
- `angle_link()`: a 24 mm-wide inside bracket with two pins on each surface.

Use the bridge below a flat assembly to preserve a clean top surface. The
angle bracket aligns with holes 4 mm from both plate edges.

Two explicit connectors are intentional: they keep the plates, printing and
future tooling simpler than a universal articulated edge.

## Grove carrier

The MVP carrier accepts the nominal 20×20 mm Grove envelope. Four pegs target
an 8×8 mm corner pattern around the centre, and two grid holes at ±16 mm attach
the carrier to a plate. Measure the actual board and connector keep-outs before
production.

## Manufacturing

All MVP parts have a single support-free print orientation. The flat 3.2 mm
walls and simple through-holes are suitable starting geometry for mold DFM.
Draft, resin shrink, ribs, gates, side actions and ejectors remain
supplier-specific work and must follow physical fit and load tests.
