# RobotMind mechanical interface

All carriers use the same two longitudinal dovetail rails on their underside.
All docks use the matching two through-channels, open at the insertion end.

| Dimension | Value |
|---|---:|
| Dock footprint | 32 × 36 mm |
| Dock height | 8 mm |
| Rail centres | ±10 mm |
| Rail root / head | 4.8 / 7.0 mm |
| Rail depth | 3.0 mm |
| Nominal fit clearance | 0.28 mm per side |

The carrier slides from the open dock end along +Y until the rear stop. Its
underside rests on the dock surface and the widened rail head is captured below
it, resisting lift. The four M3 holes fasten the dock to its host. Tune only
`RM_CLEARANCE`, and validate it with `dock_fit_test` before changing the
shared geometry.
