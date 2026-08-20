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
- One optional M3 heat-set insert and lock through the center of each plug

The loose tip starts easily; only the final portion grips. The M3 is not needed
for normal use. If permanent locking is wanted, heat an M3 insert into the
4.0 mm central pocket, then install the screw through the carrier before the
sensor. A 0.3 mm membrane keeps opposite sockets separated and sealed until
an insert intentionally melts through it. Tune `RM_M3_INSERT_HOLE` for the
chosen insert, plus `RM_HEX_ENTRY_CLEARANCE` and
`RM_HEX_GRIP` after printing the separate plug and socket coupons.

## Panel to panel

Every plate has the same direct joining geometry:

- Integral rectangular tabs on the +X and +Y edges.
- Open edge slots on the -X and -Y edges for 90° corners.
- No printed connector, hinge, rail or corner piece.

Rotate an A plate 90° so its tabs enter the open slots of a B plate. One M3
position per 42 mm edge unit passes through the female plate and threads into
a 2.6 mm blind pilot in the male tab.

The tabs locate the plates; the screws only clamp them. The 84 mm edge provides two screw positions. Screws are
optional, and no heat-set insert or nut is required for the first prototypes.

## Printing and testing

Print these four separate files before a full panel:

1. fit_test_hex_socket.stl
2. fit_test_hex_plug.stl
3. plate_joint_male_test.stl
4. plate_joint_female_test.stl

The edge coupons test the 90° corner directly. All
exports are already oriented for printing.

Use sealing washers and sealant around optional screws if the final cube must
resist water.
