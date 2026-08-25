include <../source/rm_system.scad>

inner = inner_join_rows();
outer = outer_join_rows();
edge_ports = [for(i=port_indices()) port_position(i)];
assert(RM_JOIN_PORTS == 2 && RM_JOIN_L == 2*RM_GRID,
       "Every join must be one two-column tile");
assert(join_columns() == [-RM_GRID/2,RM_GRID/2],
       "Join tile columns must land on two adjacent ports");
assert(inner == [RM_PORT_INSET],
       "Inner join must use one row on each leg");
assert(outer == [for(row=inner) RM_PLATE_T+row],
       "Outer join rows must account for plate thickness");
assert(flat_peg_rows() == [-5,5],
       "Flat join rows must land on both plates adjacent to the seam");
assert(inner_floor_rows() == [5] && inner_wall_rows() == [13],
       "Inner angle must account for the wall plate thickness");
assert(outer_floor_rows() == [13] && outer_wall_rows() == [13],
       "Outer angle must land on exterior floor and wall ports");
assert([for(row=inner_floor_rows()) RM_PLATE/2-row] == [edge_ports[7]],
       "Inner floor pegs must meet the floor edge ports");
assert(inner_wall_rows() == [RM_PLATE_T+inner[0]],
       "Inner wall pegs must meet the wall edge ports");
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
assert(join_leg(inner) >= max(inner)+octagon_d(peg_root_af())/2,
       "Inner join leg must support every peg root");
assert(join_leg(outer) >= max(outer)+octagon_d(peg_root_af())/2,
       "Outer join leg must support every peg root");
assert(RM_INSERT_DEPTH > RM_INSERT_LEAD && insert_entry_d() > RM_INSERT_OD &&
       RM_INSERT_OD > insert_bore(),
       "Female port needs a visible entry cup and an interference pilot");
assert(peg_bore() > port_boss_d() && peg_wall(peg_tip_af()) >= RM_PEG_MIN_WALL,
       "Peg must clear the circular boss with a printable wall");
cube([1,1,1]);
