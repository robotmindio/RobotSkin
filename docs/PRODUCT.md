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
| RM-PT-0808-A | `through_plate_8x8.stl` | A | 80×80 mm plate, every port M3-through |
| RM-PT-1210-A | `through_plate_12x10.stl` | A | 120×100 mm plate, every port M3-through |
| RM-JF-0202-A | `flat_join.stl` | A | 2×2 + 2×2 coplanar join |
| RM-JI-0202-B | `angle_join.stl` | B | 2×2 + 2×2 inside 90° flush-butt join |
| RM-JO-0202-B | `outer_angle_join.stl` | B | 2×2 + 2×2 outside 90° flush-butt join |
| RM-GR-0202-A | `grove_carrier_2x2.stl` | A | Seeed Studio 101020083 Grove Gesture v1.0 carrier |
| RM-GR-0402-A | `grove_carrier_4x2.stl` | A | Seeed Studio 101020585 Grove IMU 9DOF carrier |
| RM-GR-L162-A | `grove_lcd_16x2_carrier.stl` | A | Seeed Studio 104020111 Grove 16×2 LCD carrier |
| RM-TR-1420-A | `tripod_adapter.stl` | A | 1/4-20 tripod adapter |
| RM-PF-2020-A | `profile_2020_adapter.stl` | A | 20-series slot-6 adapter |
| RM-DN-TH35-A | `din_rail_adapter.stl` | A | TH35 end-slide adapter |
| RM-CC-GRV1-A | `grove_cable_clip.stl` | A | Grove cable clip |
| RM-PC-UNO3-C | `uno_carrier.stl` | C | Solid UNO R3-form-factor carrier |
| RM-PC-RPI5U-A | `rpi5_usb_carrier.stl` | A | Raspberry Pi 5 + Waveshare USB Board (C) carrier |
| RM-PC-RPI5T-A | `rpi5_table.stl` | A | Raspberry Pi 5 open protection table |
| RM-SV-H25T-D | `h25t_horn_plate_3x3.stl` | D | STS3215 H25T 7 mm-radius drive plate with horn-screw clearance |
| RM-SV-H25C-F | `h25t_port_cube_3x3.stl` | F | STS3215 drive plate to compact five-face RobotSkin end-effector hub |

## Authoritative hardware BOM

Quantities are per occupied attachment unless a part row says otherwise.
Vendor approval is still open; substitute hardware only when every listed
dimension and material requirement is met.

| Hardware ID | Approved engineering specification | Used by | Quantity |
|---|---|---|---:|
| HW-INS-M3-334 | Heat-set insert, M3 female, 3 mm long, 4.0 mm OD | RobotSkin port; UNO standoff | 1 per lock |
| HW-SCR-M3X6-PH | M3×6 pan-head machine screw | Standard RobotSkin lock | 1 per lock |
| HW-SCR-M3X4-PH | M3×4 pan-head machine screw | UNO PCB | 4 |
| HW-SCR-M3X8-PH | M3×8 pan-head machine screw | H25T horn plate | 4 |
| HW-SCR-M3X10-PH | M3×10 pan-head machine screw | H25T end-effector hub lock | 4 |
| HW-HUB-STS3215-H25T | Supplied STS3215 H25T horn, 4×M3 at 7 mm radius | H25T horn plate | 1 |
| HW-SCR-M2X6-TF | M2×6 thread-forming screw for plastic | Grove 2×2 or 4×2 PCB | 2 or 3 |
| HW-SCR-M25X6-TF | M2.5×6 thread-forming screw for plastic | Grove LCD PCB | 4 |
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
| Grove 2×2 carrier | V0.1 ports | Seeed Studio 101020083 Grove Gesture v1.0, 20×20 mm PCB and two 2.2 mm holes | Geometry verified; physical fit pending; other 20×20 Grove boards require matching hole positions |
| Grove 4×2 carrier | V0.1 ports | Seeed Studio 101020585 Grove IMU 9DOF, 40×20 mm PCB and asymmetric three 2.2 mm holes | Geometry verified; physical fit pending; other 40×20 Grove boards require matching hole positions |
| Grove 16×2 LCD carrier | V0.1 ports | Seeed Studio 104020111, 80×40 mm PCB and 76×36 mm hole pitch | Geometry verified; physical fit pending |
| UNO carrier | V0.1 ports | Arduino UNO R3 mechanical outline and asymmetric holes | Mechanical pattern only; connector clearance must be checked per clone |
| Raspberry Pi 5 USB carrier | V0.1 ports | Raspberry Pi 5; Waveshare PCIe TO USB 3.2 Gen1 Board (C) | Mount the Waveshare PCB with USB ports facing outward; retain both PCBs with M2.5×6 thread-forming screws |
| Raspberry Pi 5 table | Four V0.1 ports | Raspberry Pi 5 USB carrier with official active cooler | 30 mm open-sided clearance; unrated protective top, not a safety component |
| 2020 adapter | V0.1 pegs/carriers | 20-series, 6 mm slot, M5 T-nuts | Not for slot-5, slot-8, or 40-series profiles without verification |
| DIN adapter | V0.1 pegs/carriers | EN 60715 TH35 rail | Slides on from a free rail end; it is not a front-snap clip |
| Tripod adapter | V0.1 plate | 1/4-20 tripod screw | Maximum 4.5 mm screw entry into adapter |
| Cable clip | V0.1 plate | 7.5 mm nominal flat Grove cable | Verify cable jacket compression before repeated use |
| H25T drive plate | Four V0.1 corner female ports with M3-through paths | STS3215/LeRobot H25T horn, 4×M3 at 7 mm radius | All five horn screws install from the port face |
| H25T end-effector hub | H25T drive plate | Five top ports plus two ports on each vertical face | Four 22 mm corner M3 access bores lock into the drive plate |

Compatibility means nominal mechanical geometry only until the applicable
qualification record in `QUALITY.md` is complete.
