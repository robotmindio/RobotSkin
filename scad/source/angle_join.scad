include <rm_common.scad>

// One full-edge right-angle join. The inner L groove accepts a silicone bead.
module angle_join() {
  rows = inner_join_rows();
  leg = join_leg(rows);
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-leg,0]) rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      translate([-RM_JOIN_L/2,0,0]) rotate([90,0,0])
        rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      for(x=join_columns(), y=[for(row=rows) -row])
        translate([x,y,0]) downward_peg();
      for(x=join_columns(), z=rows)
        translate([x,0,z]) forward_peg();
    }
    for(x=join_columns(), y=[for(row=rows) -row]) translate([x,y,0]) top_screw_cut();
    for(x=join_columns(), z=rows)
      translate([x,0,z]) side_screw_cut();
    translate([-RM_JOIN_L/2,-RM_SEAL_W/2,-RM_EPS])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_JOIN_T-RM_EPS,-1.5])
      cube([RM_JOIN_L,RM_SEAL_D+RM_EPS,RM_SEAL_W]);
  }
}

angle_join();
