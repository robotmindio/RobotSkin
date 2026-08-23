# RobotMind system vocabulary

The law of the system. Every part, drawing and document must use these terms
exactly.

## Geometry (not parts — the only ways things connect)

| Term | Definition |
|---|---|
| **Port** | The only hole in the system: blind hexagon with an optional M3 pilot. Lives on panel and carrier **faces**, and on panel **edges**. |
| **Peg** | The only protrusion in the system: integral tapered hexagon with a centre bore for the optional M3 screw. |
| **Face** | Either broad surface of a panel. Ports face outward on both. |
| **Edge** | A narrow side strip of a panel. Male edges carry pegs; female edges carry ports. |

## Parts (what gets printed)

| Term | Definition | Naming pattern |
|---|---|---|
| **Panel** | Structural surface. Sizes are whole Units. | `panel_<Wmm>x<Hmm>` — e.g. `panel_40x40`, `panel_80x40` |
| **Link** | Bridges panel seams: flat behind coplanar seams, angle inside 90° corners. | `<joint>_link_<length>` — e.g. `flat_link_40`, `angle_link_80` |
| **Carrier** | Holds a payload onto face ports using its integral pegs. | `<payload>_carrier` — e.g. `grove_20x20_carrier` |
| **Gasket** | Optional TPU seal sitting in a groove at a seam. | `gasket_<joint>_<length>` — e.g. `flat_gasket_40` |

## Units

- `U` = 40 mm, the structural unit.
- Mounting positions live on the 10 mm grid. One U contains four port rows.
- Panel sizes count whole Us: `panel_2x2` is 80×80 mm.

## Grammar

1. Every hole is a Port; every protrusion is a Peg. There is no third way to
   connect anything.
2. Any carrier mounts into any full face port of any panel, from either side,
   by hand. The only exceptions are the outermost top-face port lines
   flanking the female edges, which stay solid because the horizontal edge
   bores pass through that band.
3. Panels join directly edge-to-edge: north and east edges male, south and
   west edges female. No inter-panel spacer parts exist; links reinforce
   seams but never space panels apart.
4. Screws through peg centres are optional locks, never required for
   assembly, and never pierce a membrane.
5. Everything assembles and disassembles by hand alone.

The grammar is the product: when a new idea needs a second connection
primitive, the idea is redesigned, not the rule.
