# Direct hex interface

## Carrier to panel

Every carrier uses the same progressive tapered hexagonal plug. There are no
barbs, flexible tabs or separate connector parts.

- Socket depth: 3.4 mm
- Entry clearance: 0.24 mm
- Final radial grip: 0.08 mm
- Taper: 0.28 mm across the insertion depth
- One integral plug for Grove carriers
- Two identical plugs for Arduino UNO and AprilTag/beacon carriers
- One optional M3 lock through the center of each plug

The loose tip starts easily; only the final portion grips. The M3 is not needed
for normal use. If permanent locking is wanted, install it before the sensor:
the screw passes through the carrier and forms its thread in the panel's blind
2.6 mm pilot. A 0.3 mm membrane keeps opposite sockets separated and sealed
until a screw intentionally pierces it. Tune `RM_HEX_ENTRY_CLEARANCE` and
`RM_HEX_GRIP` after printing the separate plug and socket coupons.

## Panel to panel

Every panel has the same direct joining geometry:

- Integral tapered male hex pins on the +X and +Y edges.
- Female edge sockets on the -X and -Y edges for coplanar 0° joints.
- Female face sockets beside those same edges for perpendicular 90° joints.
- No printed connector, hinge, rail or corner piece.

At 0°, press an A edge directly into a B edge. At 90°, rotate the A panel so
its pins enter the perpendicular sockets of the B panel. One M3 position per
42 mm edge unit is counterbored from both faces. An M3 screw passes through
the female panel and threads into a 2.6 mm blind pilot running through the
male pin and into its panel edge.

Use M3x12 screws at 90°, or M3x14 with a washer. The hex pins locate the panels; the screws
only clamp them. The 84 mm edge provides two screw positions. Screws are
optional, and no heat-set insert or nut is required for the first prototypes.

## Printing and testing

Print these four separate files before a full panel:

1. fit_test_hex_socket.stl
2. fit_test_hex_plug.stl
3. fit_test_edge_male.stl
4. fit_test_edge_female.stl

The edge coupons can be tested directly both coplanar and perpendicular. All
exports are already oriented for printing.

The perpendicular socket and screw counterbore create an opening near panel
edges. Use sealing washers and sealant if the final cube must resist water.
