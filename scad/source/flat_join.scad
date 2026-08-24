include <rm_common.scad>

// One full-edge join. Silicone in the underside groove seals a permanent seam.
module flat_join() {
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-15,0]) rounded_box([RM_JOIN_L,30,RM_JOIN_T],3);
      for(x=join_columns(), y=[-5,5])
        translate([x,y,0]) downward_peg();
    }
    for(x=join_columns(), y=[-5,5]) translate([x,y,0]) top_screw_cut();
    translate([-RM_JOIN_L/2,-1.5,-RM_EPS]) cube([RM_JOIN_L,3,0.9+RM_EPS]);
  }
}

flat_join();
