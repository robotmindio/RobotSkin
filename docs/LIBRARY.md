# RobotMind OpenSCAD library

Include `scad/lib/robotmind.scad`. Dimensions passed to public part modules are
port counts unless a parameter explicitly says otherwise.

```text
standards
  -> port_cut / peg / heat_set_insert
    -> connector_grid / plate_body / join_panel / join_leg
      -> plate / flat_join / angle_join / outer_angle_join / grove_plaque
        -> scad/parts entry point -> STL
```

## Finished parts

```scad
plate(columns, rows);
flat_join(width_ports=2, depth_ports=2);
angle_join(width_ports=2, depth_ports=2);
outer_angle_join(width_ports=2, depth_ports=2, plate_t=RM_PLATE_T);
grove_plaque(size=[28,28], peg_spacing=10, slot_spacing=[16,16]);
```

`plate()` requires integer dimensions of at least 2×2. Width and height are
derived as `count × RM_GRID`; the four corner ports receive the M3 through bore.
Join counts control their connector field without changing the shared port,
peg, hardware, or fit standard.

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

The repository currently ships only `plate(8,8)` as a production entry point.
Additional sizes should be exported only after the first product set passes the
physical release gate.
