include <rm_common.scad>

PCB=[20,20];
GROVE_WALL=1.7;
GROVE_FLOOR=1.8;
GROVE_CLEARANCE=0.5;

module grove_carrier(pcb=PCB) {
  W=pcb[0]+2*(GROVE_WALL+GROVE_CLEARANCE);
  L=pcb[1]+2*(GROVE_WALL+GROVE_CLEARANCE);
  assert(W >= 2*(RM_HEX_R+RM_HEX_GRIP),
         "Grove carrier is narrower than the universal hex plug");
  carrier_mount() union() {
    translate([-W/2,-L/2,0]) difference() {
      rounded_box([W,L,GROVE_FLOOR+3.1],2);
      translate([GROVE_WALL,GROVE_WALL,GROVE_FLOOR])
        rounded_box([pcb[0]+2*GROVE_CLEARANCE,
                     pcb[1]+2*GROVE_CLEARANCE,5],1);
      translate([W/2-6,-0.2,GROVE_FLOOR+0.5])
        cube([12,GROVE_WALL+1,3.5]);
    }
    for(x=[-W/2+2.2,W/2-2.2], y=[-L/2+2.2,L/2-2.2])
      translate([x,y,GROVE_FLOOR+2.5]) cylinder(h=1.3,d=2.2);
  }
}

W=PCB[0]+2*(GROVE_WALL+GROVE_CLEARANCE);
print_on_x_edge(W) grove_carrier();
