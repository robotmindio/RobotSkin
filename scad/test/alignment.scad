include <../source/rm_system.scad>

edge_ports = [for(i=port_indices()) port_position(i)];
assert(RM_JOIN_PORTS == 2 && RM_JOIN_L == 2*RM_GRID,
       "Every join must be one two-column tile");
assert(join_columns() == [-RM_GRID/2,RM_GRID/2],
       "Join tile columns must land on two adjacent ports");
assert(flat_peg_rows() == [-15,-5,5,15],
       "Flat join must have a two-by-two field on each plate");
assert(inner_floor_rows() == [5,15] && inner_wall_rows() == [5,15],
       "Inner angle must have a two-by-two field on each leg");
assert(outer_floor_rows() == [9,19] && outer_wall_rows() == [9,19],
       "Outer angle must land on exterior floor and wall ports");
assert(len([for(x=port_indices(), y=port_indices())
              if(!is_corner_port(x,y)) 1]) == 60,
       "The single-sided plate must retain 60 connector ports");
assert(mount_positions() == [edge_ports[0],edge_ports[7]],
       "Mount holes must occupy corner positions on the 10 mm grid");
assert(RM_MOUNT_CAP_D > RM_MOUNT_SINK_D &&
       RM_MOUNT_CAP_DEPTH+RM_MOUNT_SINK_DEPTH < RM_PLATE_T,
       "The flush cap and countersink must fit within the plate");
assert([for(row=inner_floor_rows()) RM_PLATE/2-row] == [edge_ports[7],edge_ports[6]],
       "Inner floor pegs must meet the floor edge ports");
assert(inner_wall_rows() == inner_floor_rows(),
       "Inner angle legs must be geometrically symmetric");
assert(RM_TEST_MALE_FITS == [0,0.05,0.10,0.15,0.20],
       "Tolerance coupon must retain its documented five male fits");
assert(test_tile_positions() == [-RM_GRID/2,RM_GRID/2],
       "Tolerance tile must retain its 2x2 nominal female grid");
assert(RM_TEST_INSERT_BORES == [3.75,3.80,3.85,3.90,3.95],
       "Insert coupon must retain its documented five pilot bores");
for(bore=RM_TEST_INSERT_BORES)
  assert(bore < RM_INSERT_OD && bore > RM_M3_CLEARANCE,
         "Every insert coupon pilot must be below insert OD and above M3 clearance");
for(fit=RM_TEST_MALE_FITS)
  assert(peg_root_af(fit) > port_af(0) && port_af(0) > peg_tip_af(fit),
         "Every coupon peg must fit the nominal female port");
assert(inner_floor_rows() == [RM_PORT_INSET,RM_JOIN_L-RM_PORT_INSET] &&
       inner_wall_rows() == inner_floor_rows(),
       "Both inner-angle faces must use the same 20 mm connector tile");
assert(outer_floor_rows() == [RM_PLATE_T+RM_PORT_INSET,
                              RM_PLATE_T+RM_JOIN_L-RM_PORT_INSET] &&
       outer_wall_rows() == outer_floor_rows(),
       "Both outer-angle faces must use the same offset connector tile");
assert(RM_INSERT_DEPTH > RM_INSERT_LEAD && insert_entry_d() > RM_INSERT_OD &&
       RM_INSERT_OD > insert_bore(),
       "Female port needs a visible entry cup and an interference pilot");
assert(peg_bore() > port_boss_d() && peg_wall(peg_tip_af()) >= RM_PEG_MIN_WALL,
       "Peg must clear the circular boss with a printable wall");
cube([1,1,1]);
