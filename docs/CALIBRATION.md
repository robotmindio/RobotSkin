# RobotMind calibration

Build the dedicated tolerance kit with `./scripts/build_test_parts.sh`. It
writes only to `test-stl/`, not the production `stl/` directory.

The male set has five separate samples, left to right: `RM_PEG_FIT` 0.00,
+0.05, +0.10, +0.15, and +0.20 mm. Test them in any of the four nominal female
ports. Each sample has zero to four edge marks to identify its left-to-right
position. Select the loosest sample that remains firm and non-rotating, then
set `RM_PEG_FIT` to that value for production parts. The female tile also
checks the insert seat and M3×6 screw path.

Leave `RM_PORT_FIT` at 0.00 unless a separately printed female-port trial
shows it is required; it changes the socket and insert pilot together.

`tolerance_insert_set.stl` is independent of the peg-fit kit. Its five
plate-equivalent ports, left to right, use 3.75, 3.80, 3.85, 3.90, and 3.95 mm
insert pilots. Zero to four front-edge marks identify the bores. Heat-set one
of your actual inserts into each: select the largest bore that seats flush,
does not visibly distort the port, and resists a screw pull/twist test. Set
`RM_INSERT_BORE` to that bore only after this test.

| Date | Material | `RM_PEG_FIT` | Entry | Grip | Rotation | Verdict |
|---|---|---:|---|---|---|---|
| | | 0.00 | | | | |

## Connector release gate

After choosing both fits, print one flat join, one angle join, and only enough
plate geometry to exercise them. A connector design is ready for the first
release only when:

1. Every peg seats by hand without cracking or tools.
2. A press-fit assembly can be removed and reinstalled ten times without
   losing alignment.
3. Four M3×6 screws clamp a join without bottoming, splitting, or visible
   plate distortion.
4. A locked flat join resists hand twisting and a locked angle holds 90°.

Record failures here before changing geometry; do not add another connector
type to work around an uncalibrated shared interface.

## Mounting cap

Print one `mounting_cap` before printing a set. It should press fully flush by
hand and remain in place when the plate is inverted. If it is too tight, raise
`RM_MOUNT_CAP_FIT` in 0.05 mm steps; do not enlarge the grid-aligned plate
recesses.
