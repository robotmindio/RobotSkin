# RobotMind calibration

Build the dedicated tolerance kit with `./scripts/build_test_parts.sh`. It
writes only to `test-stl/`, not the production `stl/` directory.

The male set has five separate samples, left to right: `RM_PEG_FIT` 0.00,
+0.05, +0.10, +0.15, and +0.20 mm. Test them in any of the four nominal female
ports. Each sample has zero to four edge marks to identify its left-to-right
position. Select the loosest sample that remains firm and non-rotating, then
set `RM_PEG_FIT` to that value for production parts. The female tile also
checks the insert seat and M3×7 screw path.

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
