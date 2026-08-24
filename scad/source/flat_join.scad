include <rm_common.scad>

// One full-edge join. Silicone in the underside groove seals a permanent seam.
module flat_join() {
  rows = inner_join_rows();
  difference() {
    union() {
      translate([-RM_JOIN_L/2,-join_leg(rows),0])
        rounded_box([RM_JOIN_L,2*join_leg(rows),RM_JOIN_T],3);
      for(x=join_columns(), y=concat([-rows[0],-rows[1]],rows))
        translate([x,y,0]) downward_peg();
    }
    for(x=join_columns(), y=concat([-rows[0],-rows[1]],rows))
      translate([x,y,0]) top_screw_cut();
    translate([-RM_JOIN_L/2,-RM_SEAL_W/2,-RM_EPS])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
  }
}

flat_join();
