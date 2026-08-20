# RobotMind Modular Sensor + Beacon Ecosystem — OpenSCAD Rev A

A simple, modular mechanical system for **Grove sensor modules** and **AprilTag + UWB/beacon modules** using one shared dock interface.

## Core architecture

`module → carrier/housing → universal dovetail + latch → dock → robot / plate / wall / tripod`

The same lower interface is used by Grove carriers, the flat beacon, the cube beacon, and the ESP32-S3 UNO carrier.

## Included models

- Universal 0° slide-in dock with dovetail guides, end stop, flexible latch and M3 holes.
- Grove carriers: 20×20, 20×40, 20×60, 40×40, 40×60 mm.
- Interchangeable AprilTag insert.
- Flat AprilTag + beacon enclosure with provisional electronics cavity and RF keep-out opening.
- Cube beacon with five tag faces and the same universal lower interface.
- 15°, 30°, 45° and 90° mounting concepts.
- Adjustable Arduino-UNO-format ESP32-S3/Grove shield mount.
- Grove cable clip.
- Generic mounting adapter concept for magnets / 1/4-20 insert. Use the dock directly for M3 or VHB mounting.
- `build.sh` to generate STL files using OpenSCAD.

For larger layouts, fasten docks to the robot chassis or an off-the-shelf perforated plate rather than printing a custom base plate.

## Important: Rev A is mechanical concept hardware

Before printing the beacon enclosure as a final fit, **measure the actual UWB/beacon PCB, antenna location, connector location, and keep-out requirements** and update the `PCB` dimensions in `04_beacon_flat.scad` and the cube design if necessary.

Similarly, Grove boards nominally use standard board size classes, but individual modules can have connectors/components that overhang the nominal PCB. The carriers intentionally include clearance and an open top.

## Printing recommendations

For prototype: PETG, 0.20 mm layer, 3–4 perimeters, 25–35% infill. Print the dock flat on its mounting face and the carrier flat on its tray floor. Start with `RM_CLEARANCE=0.28`; tune by ±0.10 mm based on your printer.

## Build

```bash
cd robotmind_modular_ecosystem
./scripts/build.sh
```

Generated STL files are written to `stl/`; they are not source artifacts.
