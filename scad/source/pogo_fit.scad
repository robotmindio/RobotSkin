include <../lib/robotskin.scad>

MODE = "assembly"; // assembly, part, collision
assert(MODE == "assembly" || MODE == "part" || MODE == "collision");

module mounted_clamps() {
  for(side=[-1,1])
    translate([side*RM_POGO_CLAMP_X,RM_POGO_CLAMP_SEAT+RM_POGO_CLAMP_T,
               RM_POGO_PIN_Z])
      scale([side,1,1]) rotate([90,0,0]) pogo_pin_clamp();
}

// Provisional envelope, not a vendor CAD model. Dimensions need confirmation.
module connector_envelope() {
  translate([0,RM_POGO_FACE_T,RM_POGO_PIN_Z]) rotate([-90,0,0]) {
    // In collision mode exclude only the intentional flange seating faces.
    translate([0,0,MODE == "collision" ? 0.01 : 0])
    linear_extrude(height=RM_POGO_FLANGE_SIZE[2]-(MODE == "collision" ? 0.02 : 0)) hull()
      for(x=[-20,20]) translate([x,0]) circle(d=15);
    translate([-31.3/2,-11/2,RM_POGO_FLANGE_SIZE[2]]) cube([31.3,11,12]);
    for(x=[-RM_POGO_PIN_PITCH/2,RM_POGO_PIN_PITCH/2])
      translate([x,0,-5]) cylinder(h=5,d=4.5);
  }
}

module clearance_envelope() {
  connector_envelope();
  // Open rear cable route, continuing beyond the printed base.
  translate([-12,RM_POGO_FACE_T+RM_POGO_FLANGE_SIZE[2]+12,11])
    cube([24,25,8]);
  // Head and driver access to both RobotSkin locks.
  for(side=[-1,1]) translate([side*2.5*RM_GRID,19,RM_JOIN_T+0.01])
    cylinder(h=30,d=RM_M3_HEAD_CLEARANCE_D);
}

if(MODE == "part") pogo_pin_mount();
if(MODE == "assembly") {
  color([0.16,0.38,0.64]) pogo_pin_mount();
  color([1,0.68,0.05]) mounted_clamps();
  color([0.3,0.3,0.3]) connector_envelope();
}
if(MODE == "collision") {
  translate([100,100,100]) cube(1); // Known volume makes empty intersections testable.
  intersection() {
    union() { pogo_pin_mount(); mounted_clamps(); }
    clearance_envelope();
  }
}
