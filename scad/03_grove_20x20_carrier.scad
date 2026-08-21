include <rm_common.scad>

PCB=[20,20];
GROVE_CLEARANCE=0.35+RM_FIT;
GROVE_WALL=1.6;
GROVE_WALL_H=3;
GROVE_PEG_D=1.9-2*RM_FIT;
assert(GROVE_PEG_D > 0, "RM_FIT makes the Grove pegs invalid");

module grove_20x20_carrier() {
  pocket=[PCB[0]+2*GROVE_CLEARANCE,PCB[1]+2*GROVE_CLEARANCE];
  outer=[pocket[0]+2*GROVE_WALL,pocket[1]+2*GROVE_WALL];
  difference() {
    union() {
      translate([-outer[0]/2,-outer[1]/2,0])
        rounded_box([outer[0],outer[1],RM_PLATE_T+GROVE_WALL_H],2);
      translate([-RM_UNIT/2,-RM_GRID/2,0])
        rounded_box([RM_UNIT,RM_GRID,RM_PLATE_T],RM_CORNER_R);
    }
    translate([-pocket[0]/2,-pocket[1]/2,RM_PLATE_T])
      rounded_box([pocket[0],pocket[1],GROVE_WALL_H+RM_EPS],1);
    translate([-6,outer[1]/2-GROVE_WALL-RM_EPS,RM_PLATE_T])
      cube([12,2*GROVE_WALL+2*RM_EPS,GROVE_WALL_H+RM_EPS]);
    for(x=[-2*RM_GRID,2*RM_GRID]) hole_at([x,0]);
  }
  for(x=[-RM_GRID,RM_GRID], y=[-RM_GRID,RM_GRID])
    translate([x,y,RM_PLATE_T]) cylinder(h=1.2,d=GROVE_PEG_D);
}

grove_20x20_carrier();
