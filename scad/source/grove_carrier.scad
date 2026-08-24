include <rm_common.scad>

module grove_20x20_carrier() {
  pcb = [20,20];
  clearance = 0.5;
  wall = 1.8;
  floor = 2;
  wall_h = 3.5;
  outer = [pcb[0]+2*(clearance+wall), pcb[1]+2*(clearance+wall)];
  difference() {
    union() {
      translate([-outer[0]/2,-outer[1]/2,0])
        rounded_box([outer[0],outer[1],floor+wall_h],2);
      male_interface();
    }
    translate([-pcb[0]/2-clearance,-pcb[1]/2-clearance,floor])
      rounded_box([pcb[0]+2*clearance,pcb[1]+2*clearance,wall_h+RM_EPS],1);
    // Generic cable exit; board-specific cut-outs belong in a board-specific carrier.
    translate([-6,outer[1]/2-wall-RM_EPS,floor])
      cube([12,wall+2*RM_EPS,wall_h+RM_EPS]);
  }
}

grove_20x20_carrier();
