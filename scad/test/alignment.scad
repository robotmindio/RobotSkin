include <../source/rm_common.scad>

inner = inner_join_rows();
outer = outer_join_rows();
assert(join_columns() == [for(i=port_indices()) port_position(i)],
       "Join columns must equal every plate port column");
assert(inner == [RM_PORT_INSET, RM_PORT_INSET+RM_GRID],
       "Inner join rows must land on the first two port rows");
assert(outer == [for(row=inner) RM_PLATE_T+row],
       "Outer join rows must account for plate thickness");
assert(join_leg(inner) >= max(inner)+RM_PORT_OD/2,
       "Inner join leg must support every peg root");
assert(join_leg(outer) >= max(outer)+RM_PORT_OD/2,
       "Outer join leg must support every peg root");
cube([1,1,1]);
