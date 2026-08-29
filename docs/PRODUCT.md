# RobotSkin V0.1 product definition

`VERSION` is the product-package version. Part geometry uses revision letters;
changing fit, interfaces, hole locations, or external dimensions requires a new
revision. Documentation or packaging-only corrections increment the package
version without changing the part revision.

V0.1 is engineering-evaluation hardware. It has no certified load rating and
is not a safety component. A production release requires every gate in
`QUALITY.md` to pass with recorded results.

## Production SKUs

| SKU | Export | Revision | Product |
|---|---|---|---|
| RM-PL-0808-A | `plate_8x8.stl` | A | 80×80 mm single-sided plate |
| RM-PT-0503-A | `through_plate_5x3.stl` | A | 50×30 mm plate, every port M3-through |
| RM-PT-0508-A | `through_plate_5x8.stl` | A | 50×80 mm plate, every port M3-through |
| RM-JF-0202-A | `flat_join.stl` | A | 2×2 + 2×2 coplanar join |
| RM-JI-0202-B | `angle_join.stl` | B | 2×2 + 2×2 inside 90° flush-butt join |
| RM-JO-0202-B | `outer_angle_join.stl` | B | 2×2 + 2×2 outside 90° flush-butt join |
| RM-GR-2020-A | `grove_carrier_20x20.stl` | A | Grove 20×20 carrier |
| RM-GR-2040-A | `grove_carrier_20x40.stl` | A | Grove 20×40 carrier |
| RM-GR-2060-A | `grove_carrier_20x60.stl` | A | Grove 20×60 carrier |
| RM-GR-4040-A | `grove_carrier_40x40.stl` | A | Grove 40×40 carrier |
| RM-GR-4060-A | `grove_carrier_40x60.stl` | A | Grove 40×60 carrier |
| RM-AT-0050-A | `apriltag_holder_50.stl` | A | 50 mm AprilTag holder |
| RM-TR-1420-A | `tripod_adapter.stl` | A | 1/4-20 tripod adapter |
| RM-PF-2020-A | `profile_2020_adapter.stl` | A | 20-series slot-6 adapter |
| RM-DN-TH35-A | `din_rail_adapter.stl` | A | TH35 end-slide adapter |
| RM-CC-GRV1-A | `grove_cable_clip.stl` | A | Grove cable clip |
| RM-PC-UNO3-C | `uno_carrier.stl` | C | Solid UNO R3-form-factor carrier |

## Authoritative hardware BOM

Quantities are per occupied attachment unless a part row says otherwise.
Vendor approval is still open; substitute hardware only when every listed
dimension and material requirement is met.

| Hardware ID | Approved engineering specification | Used by | Quantity |
|---|---|---|---:|
| HW-INS-M3-334 | Heat-set insert, M3 female, 3 mm long, 4.0 mm OD | RobotSkin port; UNO standoff | 1 per lock |
| HW-SCR-M3X6-PH | M3×6 pan-head machine screw | Standard RobotSkin lock | 1 per lock |
| HW-SCR-M3X4-PH | M3×4 pan-head machine screw | UNO PCB | 4 |
| HW-SCR-M25X6-TF | M2.5×6 thread-forming screw for plastic | Grove PCB | 4 |
| HW-NUT-1420-HX | 1/4-20 hex nut, 11.3 mm maximum across flats, 5.8 mm maximum thick | Tripod adapter | 1 |
| HW-SCR-M5-PH | M5 screw sized for extrusion engagement | 2020 adapter | 2 |
| HW-NUT-M5-T20S6 | M5 T-nut for 20-series slot-6 extrusion | 2020 adapter | 2 |

Fastener finish is zinc-plated or stainless steel. Do not mix the M3×6 joint
screw with the shorter M3×4 UNO screw: the longer screw can bottom in the UNO
standoff insert after passing through a 1.6 mm PCB.

## Compatibility matrix

| Product | RobotSkin plate | Payload / external standard | Status and limit |
|---|---|---|---|
| Flat and angle joins | Any plate using the V0.1 10 mm port grid | — | Geometry verified; physical qualification pending |
| Grove carriers | V0.1 ports | Nominal 20/40 × 20/40/60 mm Grove PCB | Board-specific connector/component clearance must be checked |
| UNO carrier | V0.1 ports | Arduino UNO R3 mechanical outline and asymmetric holes | Mechanical pattern only; connector clearance must be checked per clone |
| 2020 adapter | V0.1 pegs/carriers | 20-series, 6 mm slot, M5 T-nuts | Not for slot-5, slot-8, or 40-series profiles without verification |
| DIN adapter | V0.1 pegs/carriers | EN 60715 TH35 rail | Slides on from a free rail end; it is not a front-snap clip |
| Tripod adapter | V0.1 plate | 1/4-20 tripod screw | Maximum 4.5 mm screw entry into adapter |
| AprilTag holder | V0.1 plate | 50×50 mm printed card | No optical-range claim; print tag at exact scale |
| Cable clip | V0.1 plate | 7.5 mm nominal flat Grove cable | Verify cable jacket compression before repeated use |

Compatibility means nominal mechanical geometry only until the applicable
qualification record in `QUALITY.md` is complete.
