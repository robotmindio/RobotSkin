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
| RM-GR-0402-B | `grove_carrier_4x2.stl` | B | 40 mm-long Seeed Studio 101020585 Grove IMU 9DOF carrier |
| RM-LD-PJ03-C | `ld06_pj030_clip_carrier.stl`; `ld06_pj030_clamp_bar.stl` | C | Bolted edge clamp for LD06 PJ030 controller; print two of each |
| RM-GR-L162-A | `grove_lcd_16x2_carrier.stl` | A | Seeed Studio 104020111 Grove 16×2 LCD carrier |
| RM-TR-1420-A | `tripod_adapter.stl` | A | 1/4-20 tripod adapter |
| RM-PF-2020-A | `profile_2020_adapter.stl` | A | 20-series slot-6 adapter |
| RM-DN-TH35-A | `din_rail_adapter.stl` | A | TH35 end-slide adapter |
| RM-CC-GRV1-A | `grove_cable_clip.stl` | A | Grove cable clip |
| RM-PC-UNO3-C | `uno_carrier.stl` | C | Solid UNO R3-form-factor carrier |
| RM-PC-RPI5U-A | `rpi5_usb_carrier.stl` | A | Raspberry Pi 5 + Waveshare USB Board (C) carrier |
| RM-PC-RPI5T-A | `rpi5_table.stl` | A | Raspberry Pi 5 open protection table |
| RM-PC-ES3DC-F | `esp32_s3_devkitc_carrier.stl` | F | Solid-deck one-piece carrier for the 44-pin dual-USB-C ESP32-S3 board |
| RM-PG-2P-E | `pogo_pin_mount.stl` | E | Compact outward-facing pogo mount with six directly attached RobotSkin pegs; nominal fit candidate |
| RM-SV-H25T-D | `h25t_horn_plate_3x3.stl` | D | STS3215 H25T 7 mm-radius drive plate with horn-screw clearance |
| RM-SV-H25C-F | `h25t_port_cube_3x3.stl` | F | STS3215 drive plate to compact five-face RobotSkin end-effector hub |

## Authoritative hardware BOM

Quantities are per occupied attachment unless a part row says otherwise.
Vendor approval is still open; substitute hardware only when every listed
dimension and material requirement is met.

| Hardware ID | Approved engineering specification | Used by | Quantity |
|---|---|---|---:|
| HW-INS-M3-334 | Heat-set insert, M3 female, 3 mm long, 4.0 mm OD | RobotSkin port; UNO standoff; PJ030 clamp | 1 per lock or clamp screw |
| HW-SCR-M3X6-PH | M3×6 pan-head machine screw | Standard RobotSkin lock; PJ030 clamp | 1 per lock or clamp screw |
| HW-SCR-M3X4-PH | M3×4 pan-head machine screw | UNO PCB | 4 |
| HW-SCR-M3X8-PH | M3×8 pan-head machine screw | H25T horn plate | 4 |
| HW-SCR-M3X10-PH | M3×10 pan-head machine screw | H25T end-effector hub lock | 4 |
| HW-HUB-STS3215-H25T | Supplied STS3215 H25T horn, 4×M3 at 7 mm radius | H25T horn plate | 1 |
| HW-SCR-M2X3-TF | M2×3 thread-forming screw for plastic, measured 3 mm under head | Pogo connector flange | 2 |
| HW-WASHER-M2-503 | M2 flat washer, 5 mm OD, 2.2 mm ID, 0.3 mm thick | Pogo connector flange | 2 |
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
| Grove 4×2 carrier | V0.1 ports | Seeed Studio 101020585 Grove IMU 9DOF, 40×20 mm PCB and asymmetric three 2.2 mm holes | 40 mm-long base with locks beneath the PCB; geometry verified; physical fit pending; other 40×20 Grove boards require matching hole positions |
| LD06 PJ030 clamp carrier | Four V0.1 ports | 40×20×1.6 mm PJ030 controller without mounting holes | Two bases and two bolted bars clamp both long edges; four PCB-clamp screws and four plate locks; geometry verified, vibration qualification pending |
| Grove 16×2 LCD carrier | V0.1 ports | Seeed Studio 104020111, 80×40 mm PCB and 76×36 mm hole pitch | Geometry verified; physical fit pending |
| UNO carrier | V0.1 ports | Arduino UNO R3 mechanical outline and asymmetric holes | Mechanical pattern only; connector clearance must be checked per clone |
| Raspberry Pi 5 USB carrier | V0.1 ports | Raspberry Pi 5; Waveshare PCIe TO USB 3.2 Gen1 Board (C) | Mount the Waveshare PCB with USB ports facing outward; retain both PCBs with M2.5×6 thread-forming screws |
| Raspberry Pi 5 table | Four V0.1 ports | Raspberry Pi 5 USB carrier with official active cooler | 30 mm open-sided clearance; unrated protective top, not a safety component |
| ESP32-S3 dual-USB-C carrier | V0.1 ports | Measured headers: 22 mm inside, 28 mm outside, 2 mm high; 2×22 pins | Four continuous locks; outside hooks capture plastic above PCB; nominal PCB and connector envelopes; physical fit qualification pending |
| 2020 adapter | V0.1 pegs/carriers | 20-series, 6 mm slot, M5 T-nuts | Not for slot-5, slot-8, or 40-series profiles without verification |
| DIN adapter | V0.1 pegs/carriers | EN 60715 TH35 rail | Slides on from a free rail end; it is not a front-snap clip |
| Tripod adapter | V0.1 plate | 1/4-20 tripod screw | Maximum 4.5 mm screw entry into adapter |
| Cable clip | V0.1 plate | 7.5 mm nominal flat Grove cable | Verify cable jacket compression before repeated use |
| Two-contact pogo mount | Six consecutive V0.1 ports at 10 mm pitch | User-supplied two-contact connector screenshot | Nominal footprint below; pin travel, M2 retention and physical fit unverified |
| H25T drive plate | Four V0.1 corner female ports with M3-through paths | STS3215/LeRobot H25T horn, 4×M3 at 7 mm radius | All five horn screws install from the port face |
| H25T end-effector hub | H25T drive plate | Five top ports plus two ports on each vertical face | Four 22 mm corner M3 access bores lock into the drive plate |

Compatibility means nominal mechanical geometry only until the applicable
qualification record in `QUALITY.md` is complete.

## Two-contact pogo mount nominal footprint

Revision E targets the projecting-pin half shown in the user's drawing. The
screenshot suggests the following nominal connector dimensions; it is not a
substitute for a readable supplier drawing or measurements. Confirm especially
the contact diameter, mounting-hole bore and pin working height before printing.

| Feature | Candidate dimension |
|---|---|
| Connector flange | 55 × 15 × 3 mm, capsule outline |
| Existing flange mounting holes | 43 mm pitch, 4.5 mm bore |
| Pin centres / nominal pin diameter | 20 mm / 6 mm |
| Printed pin clearance holes | 6.4 mm diameter |
| Contact face | 60 × 18 × 0.8 mm, two apertures and a 0.3 mm perimeter bevel |
| Mount body, excluding RobotSkin pegs | 60 × 14.1 × 21 mm |
| Pin centre above RobotSkin mating surface | 12 mm |
| Nominal rear connector body used in clearance check | 31.3 mm wide × 11 mm high × 12 mm behind flange |
| Locating posts | 4.2 mm OD, 2.8 mm high, 1.7 mm blind screw pilots |
| Cable route tested behind body | 24 mm wide × 8 mm high, open rear exit |
| RobotSkin pegs | Six at 10 mm pitch, X = −25, −15, −5, 5, 15, 25 mm; row 9.1 mm behind face; axes perpendicular to contacts |

The flange pocket has 0.2 mm perimeter clearance. Two M2×3 thread-forming
screws with 0.3 mm-thick washers clamp the existing flange holes onto the
locating posts, with nominal 2.5 mm thread engagement and 1.1 mm of material
between the screw tip and front surface. The 0.9 mm pilot floor is blind.
Do not substitute longer screws: they can pierce the front. No printed clamps
or accessory heat-set inserts are needed. Six standard M3×6 screws and six
standard plate inserts populate all RobotSkin locks. Their 0.4 mm-deep head
seats give 2.4 mm insert engagement and 0.5 mm clearance between the nominal
2.4 mm-high heads and connector body. Use heads no taller than 2.4 mm.
Fasten these locks before fitting the connector; the installed body covers the central screwdriver paths.

The 0.8 mm skin consumes 0.8 mm of available pin projection. The mating half
must reach the supplier's working compression before touching the printed
face. The preview's 5 mm projection is illustrative; stroke and working
height remain unconfirmed. This mount does not fit the flush-contact half.
Check the M2 retention in the first PETG print; CAD clearance is not physical
qualification. Revision A's separate clamps are obsolete and must not be used
with later revisions.

### Drawing-to-model hole audit

Both diagrams show the same nominal contact and mounting centres. The upper
sheet depicts the flush-contact half; the lower sheet is the projecting-pin
half targeted here. The readable nominal callouts match the model as follows:

| Drawing feature | Printed interface | Review |
|---|---|---|
| 20 mm contact pitch | Two apertures at X = ±10 mm | Centres match |
| 43 mm flange mounting pitch | Posts and blind pilots at X = ±21.5 mm | Centres match |
| Ø4.5 flange mounting bore | Ø4.2 locating post, Ø1.7 pilot for the rear M2 screw | Intentional 0.3 mm diametral post clearance; not a Ø4.5 hole in the mount |
| Contact diameter and small tolerances | Ø6.4 aperture based on a nominal Ø6 contact | Callout insufficiently legible; not confirmed from this screenshot |

`check_pogo_fit.py` measures mesh sections to verify the above printed diameters
and centre locations plus all six RobotSkin pegs. That verifies CAD output,
not unreadable vendor dimensions. A full-height mating-flange sweep also
checks that the rail leaves 0.5 mm below the nominal mating flange.
The contact face points away from the RobotSkin plate. The 10 mm-deep rail
starts at the rear rim with no bridge gap. The connector sits above its
recessed screw heads; the connector's rear body and terminals project beyond
the rail, leaving the cable exit open. Driver access is checked before the
connector is installed, then installed head clearance and rear M2 access are
checked with the connector present. Remove the connector before accessing
covered RobotSkin lock screws.
