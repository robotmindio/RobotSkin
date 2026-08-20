# Modular hex interface

## Dock panels

- Base construction unit: 42 mm
- Printable panels: 42×42, 84×42 and 84×84 mm
- Panel thickness: 7 mm
- Dense 18.2 mm flat-to-flat hex socket lattice
- Mirrored 2.4 mm blind sockets with a 2.2 mm solid center web
- Nominal plug clearance: 0.28 mm

Every panel has integral faceted bead segments on its `+X` and `+Y` edges and
integral snap channels on its `-X` and `-Y` edges. Rotate a panel until an A
edge meets a B edge, press the short segments together, then leave the joint
flat or rotate it to 90°. The faceted rail supplies both detents. No hinge pin,
corner key or bracket is required.

Six 84×84 panels make a cube. Smaller panels extend a face on the same 42 mm
grid.

## Carriers

Each carrier includes its male hex plug in the same print:

1. Align the plug with any socket.
2. Press straight in until the shallow split ridge snaps beneath the lip.
3. Pull straight out with a gentle rocking motion to remove.

Small Grove carriers use one plug. The AprilTag/beacon and Arduino UNO
carriers use two plugs spaced to match the dense lattice.

Print the fit-test parts before a full panel. Tune `RM_HEX_CLEARANCE` by
±0.10 mm and `RM_HINGE_CLEARANCE` by ±0.10 mm for the printer and material.
The socket, plug, bead and channel are exported as four separate, print-ready
STL files.

## Water resistance

The blind sockets do not penetrate the panel. Direct panel joints are suitable
as a structural prototype and rain labyrinth, not an immersion seal. Add a
continuous TPU seam gasket or a thin waterproof inner liner when sealing is
required.
