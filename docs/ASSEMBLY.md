# RobotSkin assembly

Use the numbered sequence in
[`ASSEMBLY_DRAWINGS.svg`](ASSEMBLY_DRAWINGS.svg) as the visual assembly guide.

## Hardware

Each occupied lock station uses one M3×3×4, 4.0 mm-OD brass heat-set insert
and one M3×6 pan-head screw. The insert is heat-set flush into the 3 mm-deep,
blind centre bore of the plate's female port; it does not pass through the
plate. Its M3 threaded centre remains open for the screw. The join or Grove
carrier only supplies peg guidance and a screw-clearance path.

## Sequence

1. For a permanent joint, heat-set one insert at every lock station you will
   use, from the exposed plate face.
2. Press the pegs into the matching plate ports.
3. Drive one M3×6 screw through each occupied lock station into its insert.

Each join tile has eight identical lock stations: four on each attached plate.
For ordinary permanent assembly, use the four stations farthest from the seam
or corner. Use all eight when maximum strength is required.
Each Grove carrier has two M3 lock stations outside its PCB footprint. Fasten
the carrier first, then place the specified PCB on its standoffs and drive the
required thread-forming screws into the blind pilots from above: two M2 for
the 2×2 Gesture carrier, three M2 for the 4×2 IMU carrier, or four M2.5 for
the LCD.
The M3 locks remain accessible without removing the PCB. Press-fit-only
assembly remains removable.

The large rectangular opening between the LCD standoffs is only PCB and
connector clearance: leave it empty. Do not heat-set an insert in that opening
or in the carrier. The brass M3 inserts belong exclusively in the matching
female ports of the RobotSkin plate.

## External mounting adapters

- `tripod_adapter`: place a standard 1/4-20 hex nut in the top pocket, then
  attach a RobotSkin plate over it using two M3×6 screws from the recessed
  underside stations. The plate traps the nut. Thread the tripod screw no more
  than 4.5 mm into the adapter.
- `profile_2020_adapter`: use two M5 screws through the exposed end holes into
  M5 T-nuts for 20-series slot-6 extrusion.
- `din_rail_adapter`: slide the rigid channel onto a TH35 rail from an exposed
  rail end. It is not a front-snap clip.
- `grove_cable_clip`: fasten or press its single peg first, then press the flat
  cable through the narrowed opening.
- `h25t_horn_plate_3x3`: place the plate on the STS3215 H25T horn, then install
  the supplied M3×6 centre screw and four M3×8 pan-head screws from the port
  face. The surrounding screws use the four holes at 7 mm radius.
- `h25t_port_cube_3x3`: heat-set inserts in the drive plate's four corner
  ports, press in the hub's four lower pegs, then lock them through the recessed
  top-corner M3 access bores. Remove these four screws to service the horn
  centre screw.

## UNO-format carrier

Install four standard M3×3×4 heat-set inserts into the standoff tops. Attach
the empty carrier to its four hidden plate ports first, then lower the
UNO-format board onto the
standoffs, and retain it with four M3×4 pan-head screws. Do not use M3×6 here:
after passing through a 1.6 mm PCB it can bottom beyond the 3 mm insert.
The exported UNO STL stands on its long frame edge for printing; its module in
the OpenSCAD library remains in assembly orientation.

## Raspberry Pi 5 USB carrier

Install the empty carrier at its eight hidden RobotSkin locks before mounting
either PCB. Place the Raspberry Pi 5 on the left standoffs and the Waveshare
PCIe TO USB 3.2 Gen1 Board (C) on the right standoffs, with its USB ports
facing the outer edge. The PCB long edges sit adjacent, as in the Waveshare
side-mounting layout, and their mounting rows align. Use eight M2.5×6
thread-forming screws (four per PCB), then route the supplied 16-pin PCIe cable
between the boards. Keep the top open for the Pi cooler and GPIO access.

## Raspberry Pi 5 protection table

Mount the populated Raspberry Pi carrier first. Align the table's four feet
with the surrounding RobotSkin ports, keeping every leg outside the carrier,
then press the table into place. For a locked installation, drive one M3×6
pan-head screw down each leg's access bore into the plate insert. Keep all four
open sides unobstructed so the active cooler can exhaust air.

## Plate mounting

The four corner ports have an M3 clearance bore through the backing wall. Use
the same M3 pan-head screw type as the rest of the kit to mount one plate to a
threaded surface. For a double-sided assembly, place two identical plates
flat-back to flat-back and fasten the corner ports with suitably long M3
through-bolts or reusable binding posts. Do not glue the plate backs together.
