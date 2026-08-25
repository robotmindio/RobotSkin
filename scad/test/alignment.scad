include <../source/rm_system.scad>

inner = inner_join_rows();
outer = outer_join_rows();
edge_ports = [for(i=port_indices()) port_position(i)];
assert(join_columns() == [for(i=port_indices()) port_position(i)],
       "Join columns must equal every plate port column");
assert(inner == [RM_PORT_INSET, RM_PORT_INSET+RM_GRID],
       "Inner join rows must land on the first two port rows");
assert(outer == [for(row=inner) RM_PLATE_T+row],
       "Outer join rows must account for plate thickness");
assert(flat_peg_rows() == [-5,-15,5,15],
       "Flat join rows must land on both plates adjacent to the seam");
assert(inner_floor_rows() == [5,15] && inner_wall_rows() == [13,23],
       "Inner angle must account for the wall plate thickness");
assert(outer_floor_rows() == [13,23] && outer_wall_rows() == [13,23],
       "Outer angle must land on exterior floor and wall ports");
assert([for(row=inner_floor_rows()) RM_PLATE/2-row] == [edge_ports[7],edge_ports[6]],
       "Inner floor pegs must meet the floor edge ports");
assert(inner_wall_rows() == [RM_PLATE_T+inner[0],RM_PLATE_T+inner[1]],
       "Inner wall pegs must meet the wall edge ports");
assert(RM_TEST_MALE_FITS == [0,0.05,0.10,0.15,0.20],
       "Tolerance coupon must retain its documented five male fits");
assert(test_tile_positions() == [-RM_GRID/2,RM_GRID/2],
       "Tolerance tile must retain its 2x2 nominal female grid");
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
