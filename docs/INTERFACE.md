# RobotMind V2 interface

## Coordinate system

- All dimensions are millimetres.
- `RM_UNIT=40` defines plate sizes.
- Plates are 12 mm thick and accept carriers from either face.
- Positive `RM_FIT` values loosen carrier and plate-edge fits together.

## Carrier interface

The universal carrier interface is one six-sided tapered plug:

- Socket pitch: 20 mm triangular lattice.
- Hex width across flats: 16 mm.
- Socket depth: 4 mm.
- Entry clearance at `RM_FIT=0`: 0.10 mm radial.
- Final grip at `RM_FIT=0`: 0.20 mm radial interference.
- One plug per carrier; the hex prevents rotation.
- Broad carrier bases bear moments against the plate surface.

The loose tip guides insertion and the final travel creates the press fit.
There are no barbs, flexible snaps or secondary alignment plugs.

For permanent locking, install one nominal 4 mm M3 heat-set insert in the
4 mm central web shared by the two sockets, then pass an M3 screw through the
carrier. The insert remains optional.

## Plate interface

Every side of every plate has the same hermaphroditic edge:

- One progressive 7 mm-wide finger and one notch per 40 mm.
- Finger height and engagement depth both equal the 12 mm plate thickness.
- The resulting cubic envelope is invariant under a 90° rotation.
- Identical edges connect coplanar at 0° or from either face at 90°.
- One optional M3 insert per finger locks either angle with a 9 mm washer.
- No A/B orientation and no separate connector piece.

Mirroring occurs naturally when two edges face each other, aligning each
finger with the other plate's notch. A finger starts 0.30 mm undersize in
width and ends with 0.20 mm total interference at `RM_FIT=0`. Its double-sided
4.0×4 mm pocket accepts the same M3 heat-set insert used by carrier sockets.

Plates are available in 40×40, 80×40 and 80×80 mm. Six 80×80 plates are the
reference cube, but flat panels, a three-plate corner and complete cube closure
must be verified with coupons before committing to a long print run.

## Ecosystem adapters

- Grove carriers follow the five official 20/40/60 mm PCB envelopes.
- The M5Stack carrier targets a 24×32 mm Unit envelope with open side rails.
- The Technic adapter uses 4.9 mm holes on an 8 mm grid.
- Arduino UNO and AprilTag use the same single plug as every small carrier.

Compatibility adapters do not change the plate or hex interface.

## Manufacturing variants

- `plate()`: closed monolithic FDM model; slicer infill controls its interior.
- `injection_shell_a()` and `injection_shell_b()`: complementary 6 mm shells.
- Shell nominal skin: 2.0 mm; ribs: 1.5 mm; perimeter rim: 2.4 mm.
- Every molded feature pulls in Z; there are no lateral connector cavities.
- Shell welding can seal the plate body without changing the user interface.

The shell files are DFM references, not released production tooling. Draft,
shrink compensation, gate balance, ejectors and weld geometry depend on the
selected resin and mold supplier.

## Source ownership

- `rm_common.scad`: every dimension shared by plates and carriers, including
  both manufacturing variants.
- `rm_apriltag.scad`: dimensions shared only by the two AprilTag products.
- `09_injection_plate.scad`: printable/export orientations for the A/B shells.
- `02_grove_carriers.scad`: Grove tray geometry and PCB clearance.
- Other numbered files: dimensions owned by one payload or adapter.

`RM_EPS` is the common boolean overlap, `RM_FIT` is the only printed-fit
calibration, and the `RM_M3_*` variables describe shared screw and insert
hardware. Payload-specific clearances must not be promoted into the core
library unless a second independent object actually uses the same interface.

## Prototype order

1. Print and tune the separate hex plug and socket coupons.
2. Print two copies of the universal edge coupon; test both 0° and 90°.
3. Test one Grove 20×20 carrier.
4. Assemble a three-plate corner.
5. Only then print 80×80 plates or a complete cube.
