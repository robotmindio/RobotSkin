# RobotMind modular sensor + beacon ecosystem

One mechanical interface connects every payload to every mount:

`module → carrier / beacon housing → slide-in rail → dock → robot, wall, or plate`

The Rev A MVP deliberately contains only the common interface and its first
real users: a universal dock, a Grove 20×20 carrier, a flat AprilTag/beacon
housing, and an M3 mounting plate. The rail is a longitudinal dovetail pair;
the same geometry is used by every carrier and every dock.

## Print first

```bash
./scripts/build.sh
```

Print `dock_fit_test.stl` before any full part. Adjust `RM_CLEARANCE` in
`scad/source/rm_common.scad` by 0.05 mm steps: it should slide by hand with
no perceptible vertical rock. Then print one dock and the Grove carrier.

The dock is bolted down through four M3 holes. The supplied mounting plate is
the plain robot/wall base; it does not introduce another payload interface.

`beacon_flat.scad` has a provisional 28×45×8 mm board cavity. Measure the
actual PCB, antenna keep-out, and connector before printing it as a final part.
