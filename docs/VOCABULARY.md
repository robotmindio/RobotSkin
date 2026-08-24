# RobotMind system vocabulary

The law of the system. Every part, drawing and document must use these terms
exactly.

## Geometry (not parts — the only ways things connect)

| Term | Definition |
|---|---|
| **Port** | The only hole in the system: blind hexagon with an optional M3 pilot. Lives on panel **faces**, and carriers press into it. |
| **Peg** | The only protrusion in the system: integral tapered hexagon with a centre bore for the optional M3 lock. |
| **Face** | Either broad surface of a panel. Both faces carry the same full port grid. |
| **Edge** | A narrow side of a panel. Every panel carries the same battlement edge on every side: tabs at even anchor lines, sockets at odd, alternating around the perimeter. |

## Parts (what gets printed)

| Term | Definition | Naming pattern |
|---|---|---|
| **Panel** | Structural surface with identical edges on all sides and identical port grids on both faces. | `panel_<Wmm>x<Hmm>` — e.g. `panel_40x40`, `panel_80x80` |
| **Carrier** | Holds a payload onto face ports using its integral pegs. | `<payload>_carrier` — e.g. `grove_20x20_carrier` |
| **Coupon** | Calibration and concept-test prints, not system parts. | `<test>_coupon` — e.g. `edge_coupon`, `corner_coupon` |

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
3. Panels join directly edge-to-edge through their battlements. Any edge
   mates the opposing edge of any neighbour with a 180° flip; a 90° in-plane
   twist does not mate and must never be forced.
4. A 90° corner — a fold about a shared edge, or two walls meeting — is an
   open problem, not a solved one. The rest of this system does not depend
   on it; the corner coupon exists to resolve it.
5. Panels press together by hand. An optional M3 screw through the centre of
   the pegs locks a joint or a carrier, but nothing in the system requires
   it.
6. Everything assembles and disassembles by hand alone.

The grammar is the product: when a new idea needs a second connection
primitive, the idea is redesigned, not the rule.