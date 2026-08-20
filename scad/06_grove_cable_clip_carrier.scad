include <rm_common.scad>

CABLE_W=7.5;
CABLE_H=2.2;
BASE=24;

module grove_cable_clip_carrier() {
  carrier_mount() {
    difference() {
      translate([-BASE/2,-BASE/2,0]) rounded_box([BASE,BASE,4],2);
      translate([0,0,2.8]) cube([CABLE_W,CABLE_H+1,4],center=true);
      translate([0,BASE/2-3,2.8]) cube([CABLE_W,7,4],center=true);
    }
  }
}

print_on_y_edge(BASE) grove_cable_clip_carrier();
