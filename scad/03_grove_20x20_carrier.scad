include <rm_common.scad>

module grove_20x20_carrier() {
  pcb=[20,20];
  clearance=0.35+RM_FIT;
  wall=1.6;
  wall_h=3;
  floor=RM_LINK_T;
  peg_d=1.9-2*RM_FIT;
  pocket=[pcb[0]+2*clearance,pcb[1]+2*clearance];
  outer=[pocket[0]+2*wall,pocket[1]+2*wall];
  assert(peg_d > 0, "RM_FIT makes the Grove pegs invalid");
  difference() {
    union() {
      translate([-outer[0]/2,-outer[1]/2,0])
        rounded_box([outer[0],outer[1],floor+wall_h],2);
      translate([-16,-5,0]) rounded_box([32,10,floor],3);
      for(x=[-RM_GRID,RM_GRID])
        translate([x,0,0]) rotate([180,0,0]) mount_peg();
    }
    translate([-pocket[0]/2,-pocket[1]/2,floor])
      rounded_box([pocket[0],pocket[1],wall_h+RM_EPS],1);
    translate([-6,outer[1]/2-wall-RM_EPS,floor])
      cube([12,2*wall+2*RM_EPS,wall_h+RM_EPS]);
    for(x=[-RM_GRID,RM_GRID])
      translate([x,0,floor]) rotate([180,0,0])
        optional_screw_cut(floor+RM_PORT_DEPTH);
  }
  for(x=[-8,8], y=[-8,8])
    translate([x,y,floor]) cylinder(h=1.2,d=peg_d);
}

// Side orientation keeps the tray and its two integral mounting pegs
// support-free on FDM printers.
translate([0,0,12]) rotate([90,0,0]) grove_20x20_carrier();
