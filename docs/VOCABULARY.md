# RobotMind system vocabulary

The law of the system. Every part, drawing and document must use these terms
exactly.

## Geometry (not parts — the only ways things connect)

| Term | Definition |
|---|---|
| **Port** | The only hole in the system: a blind hexagonal recess with a concentric centre bore. Lives on panel **faces** in a 10 mm grid. Accepts a **peg** (carriers) or an **insert** (links). |
| **Peg** | The only protrusion in the system: an integral tapered hexagon pin with a centre bore. Carriers press two pegs into two face ports. |
| **Bore** | The concentric blind hole at the centre of a port. Seats an M3 brass heat-set insert for bolted links. Shallow enough that opposing face bores never meet through the panel. |
| **Face** | Either broad surface of a panel. Both faces carry the same full port grid. |
| **Edge** | A narrow side of a panel. Edges are clean cut lines for seaming; the seam runs on the 20 mm half-pitch between two port rows. |

## Parts (what gets printed)

| Term | Definition | Naming pattern |
|---|---|---|
| **Panel** | Structural surface with identical port grids on both faces. Direct butt joints live on the edges. | `panel_<Wmm>x<Hmm>` — e.g. `panel_40x40`, `panel_80x80` |
| **Carrier** | Holds a payload onto face ports using its integral pegs. | `<payload>_carrier` — e.g. `grove_20x20_carrier` |
| **Link** | Bolted bracket that crosses a seam and joins two panels. A flat link joins coplanar edges; an angle link joins two faces at 90°. Screws pass through the bracket into insert bores. | `<flat|angle>_link_<Lmm>` — e.g. `flat_link_40`, `angle_link_80` |
| **Coupon** | Calibration prints, not system parts. | `<test>_coupon` |

## Units

- `U` = 40 mm, the structural unit.
- Mounting positions live on the 10 mm grid. One U contains four port rows.
- Panel sizes count whole Us: `panel_2x2` is 80×80 mm.

## Grammar

1. Every hole is a Port; every protrusion is a Peg. There is no third way
   to connect anything. Payload geometry lives inside a carrier's envelope
   and is not a system interface.
2. Any carrier mounts into any face port of any panel, from either side, by
   hand. The full grid is identical on both faces, so there is no special
   case.
3. Panels join edge-to-edge directly; a seam is a butt cut, and a link is
   the bracket that carries the load across it. A flat link crosses a
   coplanar seam; an angle link crosses a 90° fold.
4. A 90° corner is a solved case: two panels meet in a fold and the
   `angle_link` brackets that fold.
5. Every link hole lands on a port centre. Screws pass through the link into
   the port bore, where an M3 brass heat-set insert turns the joint into a
   true structural fastening.
6. Everything assembles and disassembles by hand alone; the optional M3 screw
   locks it against service torque.

The grammar is the product: when a new idea needs a second connection
primitive, the idea is redesigned, not the rule.