# RobotMind OpenSCAD library

Include `scad/lib/robotmind.scad`. Dimensions passed to public part modules are
port counts unless a parameter explicitly says otherwise.

```text
standards
  -> port_cut / peg / heat_set_insert
    -> connector_grid / plate_body / join_panel / join_leg
      -> plate / joins / carriers / mounting adapters
        -> scad/parts entry point -> STL
```

## Finished parts

```scad
plate(columns, rows);
flat_join(width_ports=2, depth_ports=2);
angle_join(width_ports=2, depth_ports=2);
outer_angle_join(width_ports=2, depth_ports=2, plate_t=RM_PLATE_T);
grove_carrier(board_size=[20,20]);
apriltag_holder(tag_size=50, border=RM_TAG_BORDER);
tripod_adapter();
profile_2020_adapter();
din_rail_adapter();
grove_cable_clip();
uno_carrier();
```

`plate()` requires integer dimensions of at least 2×2. Width and height are
derived as `count × RM_GRID`; the four corner ports receive the M3 through bore.
Join counts control their connector field without changing the shared port,
peg, hardware, or fit standard.

`grove_carrier()` accepts the documented Grove board families: widths of 20 or
40 mm and lengths of 20, 40, or 60 mm. Its RobotMind M3 lock stations remain
outside the PCB footprint. Four raised bosses accept top-installed M2.5
thread-forming screws, so assembly needs no inaccessible underside nuts.
The repository exports all five documented combinations as production entry
points.

`uno_carrier()` follows the official 68.58×53.34 mm UNO outline and asymmetric
four-hole pattern. The open frame leaves connectors and underside pins clear;
four symmetric RobotMind locks remain hidden below the board.

`apriltag_holder()` accepts a square size or `[width,height]` and retains the
printed card between four corner shelves and tabs. Its two M3 stations are
outside the image area and remain accessible.

The mounting adapters deliberately expose RobotMind in the useful direction:
`tripod_adapter()` places two upward pegs under a plate, while the 2020-profile
and DIN-rail adapters provide female ports for carriers. The DIN part is a
rigid end-slide mount, not a material-dependent snap clip.

## Reusable components

```scad
connector_grid(columns, rows, direction="down", cut=false,
               body_t=RM_JOIN_T, fit=RM_PEG_FIT);
connector_peg(direction="down", fit=RM_PEG_FIT);
connector_screw_cut(direction="down", body_t=RM_JOIN_T);
plate_body(columns, rows);
plate_port_cuts(columns, rows);
plate_corner_through_cuts(columns, rows);
join_panel(width, min_row, max_row);
join_leg(width, length);
pcb_standoff(position);
```

Directions are `down`, `forward`, `up`, and `backward`. Screw and port modules
are negative geometry: call them inside `difference()`.

## Interface primitives

```scad
port_cut(fit=RM_PORT_FIT, bore=undef);
peg(fit=RM_PEG_FIT);
heat_set_insert();
```

These define the physical compatibility boundary. Prefer the component and
finished-part modules unless a new product genuinely needs custom placement.

## Grid functions

```scad
grid_size(count);
grid_positions(count);
edge_rows(depth_ports);
flat_rows(depth_ports);
outer_rows(depth_ports, plate_t=RM_PLATE_T);
is_corner_index(column, row, columns, rows);
grid_station_outside(distance);
```

## Mechanical standard

`RM_GRID`, port dimensions, peg dimensions, insert geometry, plate thickness,
and screw clearances are shared system constants. Do not pass replacements into
individual parts: changing them locally would create incompatible products.

Only the calibrated manufacturing values are expected to vary between printer
and material profiles:

```scad
RM_PORT_FIT
RM_PEG_FIT
RM_INSERT_BORE
```

The repository exports one validated candidate per product family. Additional
sizes should be exported only after the first physical example of that family
passes its release gate.
