# RobotSkin OpenSCAD library

Include `scad/lib/robotskin.scad`. Dimensions passed to public part modules are
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
plate(columns, rows, thickness=RM_PLATE_T);
through_plate(columns, rows, thickness=RM_PLATE_T);
h25t_horn_plate_3x3(thickness=2*RM_PLATE_T,
                     hub_radius=RM_STS3215_HUB_RADIUS);
h25t_port_cube_3x3();
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
rpi5_usb_carrier();
```

`plate()` requires integer dimensions of at least 2×2. Width and height are
derived as `count × RM_GRID`; `thickness` defaults to 4 mm and may be increased
for custom structural plates. The four corner ports receive the M3 through bore.
`through_plate()` uses the same dimensions and identical octagonal ports, but
continues the 3.4 mm M3 centre path through the backing wall at every station.
Join counts control their connector field without changing the shared port,
peg, hardware, or fit standard.

`h25t_horn_plate_3x3()` is an 8 mm, 30×30 mm STS3215 drive plate. It reserves its
four cardinal stations for the STS3215/LeRobot H25T horn's 4×M3 pattern at
7 mm radius and keeps four corner RobotSkin ports with M3-through paths. The
centre screw and four surrounding horn screws all install from the port face;
the plate does not print a servo spline.

`h25t_port_cube_3x3()` mates to those four corner ports with lower pegs and
provides a 30×30×30 mm hub. Its centre and four top edge-centre stations are
female ports; the corners are 22 mm deep M3 head-access bores. Each vertical face
keeps its lower two centred ports and leaves its upper station flat to prevent
intersection. Four corner screw paths continue through the lower pegs into the
drive-plate inserts.

`grove_carrier()` accepts the documented Grove board families: widths of 20 or
40 mm and lengths of 20, 40, or 60 mm. Its RobotSkin M3 lock stations remain
outside the PCB footprint. Four raised bosses accept top-installed M2.5
thread-forming screws, so assembly needs no inaccessible underside nuts.
The repository exports all five documented combinations as production entry
points.

`uno_carrier()` follows the official 68.58×53.34 mm UNO outline and asymmetric
four-hole pattern. Its main body is one continuous flat plate interrupted only
by screw paths. Four symmetric RobotSkin locks remain hidden below the board.

`rpi5_usb_carrier()` fits a Raspberry Pi 5 beside a Waveshare PCIe TO USB 3.2
Gen1 Board (C). The two PCBs sit on 5 mm standoffs above a compact 120×97 mm
carrier, with their long edges adjacent and mounting rows aligned; the
Waveshare USB ports face outward.
Eight RobotSkin locks attach the empty carrier before either PCB is installed.

`apriltag_holder()` accepts a square size or `[width,height]` and retains the
printed card between four corner shelves and tabs. Its two M3 stations are
outside the image area and remain accessible.

The mounting adapters deliberately expose RobotSkin in the useful direction:
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
plate_all_through_cuts(columns, rows);
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
