include <rm_common.scad>

// One full-edge right-angle join. The inner L groove accepts a silicone bead.
module angle_join() {
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-24,0]) rounded_box([RM_JOIN_L,24,RM_JOIN_T],3);
      translate([-RM_JOIN_L/2,0,0]) rotate([90,0,0])
        rounded_box([RM_JOIN_L,24,RM_JOIN_T],3);
      for(x=join_columns(), y=[-15,-5])
        translate([x,y,0]) downward_peg();
      for(x=join_columns(), z=[5,15])
        translate([x,0,z]) forward_peg();
    }
    for(x=join_columns(), y=[-15,-5]) translate([x,y,0]) top_screw_cut();
    for(x=join_columns(), z=[5,15])
      translate([x,0,z]) side_screw_cut();
    translate([-RM_JOIN_L/2,-1.5,-RM_EPS]) cube([RM_JOIN_L,3,0.9+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_JOIN_T-RM_EPS,-1.5])
      cube([RM_JOIN_L,0.9+RM_EPS,3]);
  }
}

angle_join();
