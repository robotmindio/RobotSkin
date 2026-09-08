# RobotSkin V0.1 FDM print profile

This is the release baseline, not a promise that every printer needs identical
settings. Calibrate `RM_PEG_FIT` and `RM_INSERT_BORE` before production.

| Setting | Baseline |
|---|---|
| Process | FDM/FFF |
| Material | PETG for functional evaluation; dry before printing |
| Nozzle / line width | 0.4 / 0.42 mm |
| Layer height | 0.20 mm |
| Walls | 4 |
| Top / bottom layers | 5 / 5 |
| Infill | 25% gyroid or cubic |
| Supports | Off except where listed below |
| Brim | Off; 5 mm for the UNO carrier if bed adhesion is marginal |
| Dimensional compensation | 0 initially; use calibration geometry, not slicer hole compensation, to tune the interface |

Do not scale STL files. Print one part at a time while qualifying a material or
printer. Orientations are already encoded in the production exports.

| Part family | Orientation / support |
|---|---|
| Plate and H25T horn plate | Flat back on bed; no support |
| Flat join and Grove carriers | Peg-side up; no support |
| LD06 PJ030 clamp | Bases as exported with clamp face on bed and pegs upward; bars flat; print two of each; no support |
| Inside/outside angle joins | As exported; local support below the horizontal connector row |
| UNO carrier | Long frame edge on bed; local support only beneath horizontal connector details when bridging fails |
| Raspberry Pi table | Tabletop on bed, legs and pegs upward; no support |
| ESP32-S3 dual-USB-C carrier | Long frame edge on bed; local supports beneath horizontal arms, corner seats/stops and pegs; inspect support removal access |
| Tripod, 2020, DIN, cable clip | As exported; inspect slicer preview before first production run |

For the ESP32 carrier, use the PETG baseline and the exported side orientation.
Remove supports fully from the hook ramps and seats without bending the arms.
The small 0.2 mm retaining overlap must survive slicing and printing; inspect
it before inserting the board. Check that jumper housings can seat at the four
hook positions. Do not force an oversized housing past a hook. Tune the header
fit in the source, not by scaling the STL. This revision needs physical fit and
cycle testing; passing the mesh/clearance checks does not qualify the print.

Reject a print when a port or peg has missing perimeters, an insert pocket is
closed, a wall is visibly delaminated, or the first layer changes a mating
feature. Record printer, nozzle, material brand, material lot, profile version,
and selected fit values with every qualification batch.
