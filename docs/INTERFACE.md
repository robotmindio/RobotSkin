# RobotMind V1 interface

## Coordinate system

- All dimensions are millimetres.
- `RM_UNIT=40` defines plate sizes.
- Plates are 12 mm thick and accept carriers from either face.
- Positive `RM_FIT` values loosen carrier and corner fits together.

## Carrier interface

The universal carrier interface is one six-sided tapered plug:

- Socket pitch: 20 mm triangular lattice.
- Hex width across flats: 16 mm.
- Socket depth: 3.4 mm.
- Entry clearance at `RM_FIT=0`: 0.10 mm radial.
- Final grip at `RM_FIT=0`: 0.20 mm radial interference.
- One plug per carrier; the hex prevents rotation.
- Broad carrier bases bear moments against the plate surface.

The loose tip guides insertion and the final travel creates the press fit.
There are no barbs, flexible snaps or secondary alignment plugs.

For permanent locking, install a nominal 5 mm M3 heat-set insert in the
socket's 4.0 mm pocket, then pass an M3 screw through the carrier. The central
0.3 mm membrane keeps an unused double-sided socket closed.

## Plate interface

All plates use the same edge convention:

- Integral 6 mm tabs at 10 mm pitch on +X and +Y.
- Matching open slots on -X and -Y.
- Tabs enter slots from either plate face to form a 90° corner.
- One optional M3 clamp per 40 mm of edge.
- No flat 0° joint and no separate corner piece.

Plates are available in 40×40, 80×40 and 80×80 mm. Six 80×80 plates are the
reference cube, but a complete cube closure must be verified with the corner
coupons before committing to a long print run.

## Ecosystem adapters

- Grove carriers follow the five official 20/40/60 mm PCB envelopes.
- The M5Stack carrier targets a 24×32 mm Unit envelope with open side rails.
- The Technic adapter uses 4.9 mm holes on an 8 mm grid.
- Arduino UNO and AprilTag use the same single plug as every small carrier.

Compatibility adapters do not change the plate or hex interface.

## Prototype order

1. Print and tune the separate hex plug and socket coupons.
2. Print and tune the separate male and female corner coupons.
3. Test one Grove 20×20 carrier.
4. Assemble a three-plate corner.
5. Only then print 80×80 plates or a complete cube.
