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

The LD06 PJ030 clamp uses no PCB mounting holes. Print two clamp bases and two
clamp bars. Heat-set two M3×3×4 inserts into each base's exposed clamp pockets.
Mount the base peg rows 30 mm apart with the 1.2 mm ledges facing inward, then
lock all four pegs to the RobotSkin plate. Set the 40×20 mm controller on the
ledges and fasten each bar with two M3×6 screws. The short pads overlap only
1 mm of each PCB edge; confirm they touch bare PCB rather than a component.
Tighten evenly until the board cannot move, without bending it. For vibration
service, apply removable threadlocker only to the metal insert threads and
keep it off the printed plastic. Both short ends remain open for connectors.

The large rectangular opening between the LCD standoffs is only PCB and
connector clearance: leave it empty. Do not heat-set an insert in that opening
or in the LCD carrier. Except for the dedicated PJ030 clamp pockets and PCB
standoffs explicitly described above, brass M3 inserts belong in the matching
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

## ESP32-S3 dual-USB-C carrier

Attach the empty carrier using its four consecutive RobotSkin lock stations
before fitting the board. Orient components toward the frame and both yellow
header strips and long pins away from it. Centre the PCB between the corner
stops; lower it evenly onto the side edge seats. The four outside hooks must
return over the outer edges of the yellow plastic, with no PCB bending.
The seats touch the PCB edge underneath; the hooks retain the plastic above it.

To remove it, gently move the two hooks on one side outward, lift that edge
slightly, then disengage the other side. Do not pull the pins or pry against
solder joints. Both central end openings remain free for the USB-C cables and
the projecting antenna. Test cable insertion/removal and ten latch cycles on
the first PETG print before using it on the robot. See [printing](PRINTING.md).

## Plate mounting

The four corner ports have an M3 clearance bore through the backing wall. Use
the same M3 pan-head screw type as the rest of the kit to mount one plate to a
threaded surface. For a double-sided assembly, place two identical plates
flat-back to flat-back and fasten the corner ports with suitably long M3
through-bolts or reusable binding posts. Do not glue the plate backs together.

## Two-contact pogo mount

Print one revision C mount. Confirm the
[nominal footprint and mating travel](PRODUCT.md#two-contact-pogo-mount-nominal-footprint)
against the actual connector. The older separate clamps are not used.

1. Install six standard M3 inserts in six consecutive RobotSkin ports, then
   attach the mount with six M3×6 screws through its outside lower/front rail.
   This row is outside the connector body; keep the rear clear for wiring.
2. Feed the contacts through the face from behind. Align the flange's two
   existing mounting holes over the locating posts and seat it in the capsule
   recess without forcing either the contacts or posts.
3. Place a 5 mm-OD, 0.3 mm-thick M2 washer over each rear flange hole. Fit one
   M2×3 thread-forming screw into each blind pilot, turning gently until the
   flange is retained. Do not use M2×6 screws here or overtighten the posts.
4. Route the leads through the open centre/rear. Check pin movement and mate
   with the actual counterpart: its housing must not meet the skin before
   the pins reach their specified working compression. Verify cable bend and
   strain relief with the actual leads.

The standard RobotSkin locks and both rear M2 screws remain accessible with
the connector installed and its mating counterpart removed. Inspect post cracking, front-face distortion and
retention during the first physical fit check before repeated use.
