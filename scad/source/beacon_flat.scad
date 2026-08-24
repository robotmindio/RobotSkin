include <rm_common.scad>

// Provisional board envelope: measure antenna and connector keep-outs first.
TAG = 60;
PCB = [28,45,8];
W = max(TAG+8, PCB[0]+8);
H = max(TAG+8, PCB[1]+8);
DEPTH = 14;

difference() {
  union() {
    translate([-W/2,-H/2,0]) rounded_box([W,H,DEPTH],3);
    male_interface();
  }
  // Open rear cavity preserves the front face for the printed AprilTag.
  translate([-PCB[0]/2,-PCB[1]/2,4]) cube([PCB[0],PCB[1],DEPTH+RM_EPS]);
  translate([W/2-18,-16,6]) cube([20,32,DEPTH+RM_EPS]);
}
