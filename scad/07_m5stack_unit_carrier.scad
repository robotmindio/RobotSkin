include <rm_common.scad>

UNIT=[24,32];
CLEARANCE=0.15+RM_FIT;
BASE_T=2.2;
RAIL_T=2;
RAIL_H=4;
W=UNIT[0]+2*(CLEARANCE+RAIL_T);

module m5stack_unit_carrier() {
  carrier_mount() union() {
    translate([-W/2,-UNIT[1]/2,0]) rounded_box([W,UNIT[1],BASE_T],2);
    for(sx=[-1,1])
      translate([sx>0 ? UNIT[0]/2+CLEARANCE : -UNIT[0]/2-CLEARANCE-RAIL_T,
                 -UNIT[1]/2,BASE_T])
        cube([RAIL_T,UNIT[1],RAIL_H]);
    // One open cable end; slide the Unit against the opposite stop.
    translate([-UNIT[0]/2-CLEARANCE,UNIT[1]/2-RAIL_T,BASE_T])
      cube([UNIT[0]+2*CLEARANCE,RAIL_T,RAIL_H]);
  }
}

print_on_y_edge(UNIT[1]) m5stack_unit_carrier();
