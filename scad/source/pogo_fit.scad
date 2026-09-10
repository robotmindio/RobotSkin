include <../lib/robotskin.scad>

MODE = "assembly"; // assembly, part, collision
assert(MODE == "assembly" || MODE == "part" || MODE == "collision");

// Nominal drawing envelope, not supplier CAD; pin stroke still needs confirmation.
module connector_plastic() {
  translate([0,RM_POGO_FACE_T,RM_POGO_PIN_Z]) {
    difference() {
      // Exclude only the intentional front seating contact during collision checks.
      translate([0,MODE == "collision" ? 0.01 : 0,0])
        pogo_capsule(RM_POGO_FLANGE_SIZE,
                     RM_POGO_FLANGE_SIZE[2]-(MODE == "collision" ? 0.01 : 0));
      for(side=[-1,1])
        translate([side*RM_POGO_MOUNT_PITCH/2,-RM_EPS,0])
          rotate([-90,0,0])
            cylinder(h=RM_POGO_FLANGE_SIZE[2]+2*RM_EPS,d=RM_POGO_MOUNT_HOLE_D);
    }
    translate([0,RM_POGO_FLANGE_SIZE[2],0])
      pogo_capsule([RM_POGO_REAR_BODY[0],RM_POGO_REAR_BODY[2]],RM_POGO_REAR_BODY[1]);
  }
}

module connector_contacts() {
  // Five-millimetre projection is illustrative, not a working-stroke specification.
  for(side=[-1,1]) {
    translate([side*RM_POGO_PIN_PITCH/2,RM_POGO_FACE_T-5+RM_POGO_PIN_D/2,
               RM_POGO_PIN_Z]) {
      sphere(d=RM_POGO_PIN_D,$fn=64);
      rotate([-90,0,0]) cylinder(h=5-RM_POGO_PIN_D/2,d=RM_POGO_PIN_D,$fn=64);
    }
    translate([side*RM_POGO_PIN_PITCH/2,
               RM_POGO_FACE_T+RM_POGO_FLANGE_SIZE[2]+RM_POGO_REAR_BODY[1],
               RM_POGO_PIN_Z]) rotate([-90,0,0]) cylinder(h=2,d=3.3);
  }
}

module clearance_envelope() {
  connector_plastic();
  connector_contacts();
  // Open cable route begins at the rear body and continues beyond the feet.
  translate([-12,RM_POGO_FACE_T+RM_POGO_FLANGE_SIZE[2]+RM_POGO_REAR_BODY[1],5])
    cube([24,25,8]);
  for(side=[-1,1]) {
    // RobotSkin screw heads and straight driver paths.
    translate([side*2.5*RM_GRID,8,RM_JOIN_T+0.01])
      cylinder(h=25,d=RM_M3_HEAD_CLEARANCE_D);
    // Rear M2 washer/head and driver clearance.
    translate([side*RM_POGO_MOUNT_PITCH/2,
               RM_POGO_FACE_T+RM_POGO_FLANGE_SIZE[2]+0.01,RM_POGO_PIN_Z])
      rotate([-90,0,0]) cylinder(h=20,d=5);
  }
}

if(MODE == "part") pogo_pin_mount();
if(MODE == "assembly") {
  color([0.2,0.24,0.29]) pogo_pin_mount();
  color([0.07,0.08,0.09]) connector_plastic();
  color([0.8,0.66,0.32]) connector_contacts();
  for(side=[-1,1])
    translate([side*RM_POGO_MOUNT_PITCH/2,
               RM_POGO_FACE_T+RM_POGO_FLANGE_SIZE[2],RM_POGO_PIN_Z])
      rotate([-90,0,0]) color([0.6,0.62,0.65]) difference() {
        union() { cylinder(h=0.3,d=5); cylinder(h=1.6,d=3.8); }
        translate([0,0,1.3]) cylinder(h=0.4,d=1.7,$fn=6);
      }
}
if(MODE == "collision") {
  translate([100,100,100]) cube(1); // Known volume makes empty intersections testable.
  intersection() { pogo_pin_mount(); clearance_envelope(); }
}
