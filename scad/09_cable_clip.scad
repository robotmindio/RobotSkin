include <rm_common.scad>
// Snap-in cable clip for 4-wire Grove cable, mounts to 3 mm slot/hole.
CABLE_W=7.5; CABLE_H=2.2;
difference(){
  rounded_box([14,9,4],2,center=true);
  translate([0,0,1.2]) cube([CABLE_W,CABLE_H+1,4],center=true);
  translate([0,0,-1]) cylinder(h=6,d=3.2,center=true);
}
