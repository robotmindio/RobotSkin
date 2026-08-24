include <rm_common.scad>

// Full-edge exterior corner join. Its 8 mm offset clears the plate thickness.
module outer_angle_join() {
  leg = 30;
  floor_rows = [-13,-23];
  wall_rows = [13,23];
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-leg,-RM_JOIN_T])
        rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      translate([-RM_JOIN_L/2,0,leg]) rotate([-90,0,0])
        rounded_box([RM_JOIN_L,leg,RM_JOIN_T],3);
      for(x=join_columns(), y=floor_rows)
        translate([x,y,0]) upward_peg();
      for(x=join_columns(), z=wall_rows)
        translate([x,0,z]) backward_peg();
    }
    for(x=join_columns(), y=floor_rows) translate([x,y,0]) bottom_screw_cut();
    for(x=join_columns(), z=wall_rows)
      translate([x,0,z]) backward_screw_cut();
  }
}

outer_angle_join();
