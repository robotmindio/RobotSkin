# RobotMind assembly

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
The Grove carrier uses two M3 lock stations outside the PCB footprint. Fasten
the carrier first, then place the board on its four standoffs and drive M2.5
thread-forming screws into the blind pilots from above. The M3 locks remain
accessible without removing the board. Press-fit-only assembly remains removable.

## AprilTag holder

Attach the empty frame through its two exposed M3 stations. Flex the printed
tag card gently under the four corner tabs; no adhesive is required.

## External mounting adapters

- `tripod_adapter`: place a standard 1/4-20 hex nut in the top pocket, then
  attach a RobotMind plate over it using two M3×6 screws from the recessed
  underside stations. The plate traps the nut. Thread the tripod screw no more
  than 4.5 mm into the adapter.
- `profile_2020_adapter`: use two M5 screws through the exposed end holes into
  M5 T-nuts for 20-series slot-6 extrusion.
- `din_rail_adapter`: slide the rigid channel onto a TH35 rail from an exposed
  rail end. It is not a front-snap clip.
- `grove_cable_clip`: fasten or press its single peg first, then press the flat
  cable through the narrowed opening.

## UNO-format carrier

Install four standard M3×3×4 heat-set inserts into the standoff tops. Attach
the empty carrier to its four hidden plate ports first, then lower the
UNO-format board onto the
standoffs, and retain it with four M3×4 pan-head screws. Do not use M3×6 here:
after passing through a 1.6 mm PCB it can bottom beyond the 3 mm insert.
The exported UNO STL stands on its long frame edge for printing; its module in
the OpenSCAD library remains in assembly orientation.

## Plate mounting

The four corner ports have an M3 clearance bore through the backing wall. Use
the same M3 pan-head screw type as the rest of the kit to mount one plate to a
threaded surface. For a double-sided assembly, place two identical plates
flat-back to flat-back and fasten the corner ports with suitably long M3
through-bolts or reusable binding posts. Do not glue the plate backs together.
