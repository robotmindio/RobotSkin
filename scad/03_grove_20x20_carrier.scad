include <rm_common.scad>

module grove_20x20_carrier() {
  pcb=[20,20];
  clearance=0.35+RM_FIT;
  wall=1.6;
  wall_h=3;
  peg_d=1.9-2*RM_FIT;
  pocket=[pcb[0]+2*clearance,pcb[1]+2*clearance];
  outer=[pocket[0]+2*wall,pocket[1]+2*wall];
  assert(peg_d > 0, "RM_FIT makes the Grove pegs invalid");
  difference() {
    union() {
      translate([-outer[0]/2,-outer[1]/2,0])
        rounded_box([outer[0],outer[1],RM_PLATE_T+wall_h],2);
      translate([-RM_UNIT/2,-RM_GRID/2,0])
        rounded_box([RM_UNIT,RM_GRID,RM_PLATE_T],RM_CORNER_R);
    }
    translate([-pocket[0]/2,-pocket[1]/2,RM_PLATE_T])
      rounded_box([pocket[0],pocket[1],wall_h+RM_EPS],1);
    translate([-6,outer[1]/2-wall-RM_EPS,RM_PLATE_T])
      cube([12,2*wall+2*RM_EPS,wall_h+RM_EPS]);
    for(x=[-2*RM_GRID,2*RM_GRID]) hole_at([x,0]);
  }
  for(x=[-RM_GRID,RM_GRID], y=[-RM_GRID,RM_GRID])
    translate([x,y,RM_PLATE_T]) cylinder(h=1.2,d=peg_d);
}

grove_20x20_carrier();
