include <rm_common.scad>

// Plain M3 mounting plate: use it for a robot, wall, or tripod adapter base.
PLATE = [44,48,4];
difference() {
  translate([-PLATE[0]/2,-PLATE[1]/2,0]) rounded_box(PLATE,3);
  for(x=[-16,16], y=[-18,18]) {
    translate([x,y,-RM_EPS]) cylinder(h=PLATE[2]+2*RM_EPS,d=RM_M3_CLEARANCE);
    translate([x,y,PLATE[2]-2]) cylinder(h=2+RM_EPS,d=6.4);
  }
}
translate([0,0,PLATE[2]]) universal_dock();
