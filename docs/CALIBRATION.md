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

| Date | Material | `RM_PEG_FIT` | Entry | Grip | Rotation | Verdict |
|---|---|---:|---|---|---|---|
| | | 0.00 | | | | |
