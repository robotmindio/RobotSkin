include <rm_common.scad>

// Full-edge exterior corner join. Its 8 mm offset clears the plate thickness.
module outer_angle_join() {
  rows = outer_join_rows();
  leg = join_leg(rows);
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-leg,-RM_JOIN_T])
        rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      translate([-RM_JOIN_L/2,0,leg]) rotate([-90,0,0])
        rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      for(x=join_columns(), y=[for(row=rows) -row])
        translate([x,y,0]) upward_peg();
      for(x=join_columns(), z=rows)
        translate([x,0,z]) backward_peg();
    }
    for(x=join_columns(), y=[for(row=rows) -row])
      translate([x,y,0]) bottom_screw_cut();
    for(x=join_columns(), z=rows)
      translate([x,0,z]) backward_screw_cut();
    translate([-RM_JOIN_L/2,-RM_PLATE_T-RM_SEAL_W/2,-RM_SEAL_D])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_EPS,RM_PLATE_T-RM_SEAL_W/2])
      cube([RM_JOIN_L,RM_SEAL_D+RM_EPS,RM_SEAL_W]);
  }
}

outer_angle_join();
