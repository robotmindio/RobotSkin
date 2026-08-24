// RobotMind Rev A: one slide-in interface for every payload carrier.
// Dimensions are mm; tune clearance on a short fit coupon before full prints.
$fn = 32;

RM_EPS = 0.1;
RM_CLEARANCE = 0.28;
RM_M3_CLEARANCE = 3.4;

RM_DOCK_W = 32;
RM_DOCK_L = 36;
RM_DOCK_H = 8;
RM_RAIL_X = 10;
RM_RAIL_ROOT = 4.8;
RM_RAIL_HEAD = 7.0;
RM_RAIL_H = 3.0;
RM_RAIL_L = 30;

assert(RM_RAIL_HEAD > RM_RAIL_ROOT, "Rail must retain the carrier");
assert(RM_DOCK_H > RM_RAIL_H, "Dock needs material below the rail");
assert(RM_RAIL_L + 2*RM_CLEARANCE < RM_DOCK_L,
       "Rail needs an open insertion end and rear stop");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

// The profile is narrow at the carrier root and wider at its free end.
module rail_profile(root=RM_RAIL_ROOT, head=RM_RAIL_HEAD, h=RM_RAIL_H) {
  polygon(points=[[-root/2,0], [root/2,0], [head/2,h], [-head/2,h]]);
}

// Runs along +Y and projects below Z=0. Carriers place this at their underside.
module male_rail(length=RM_RAIL_L) {
  translate([0,-length/2,0]) rotate([-90,0,0])
    linear_extrude(height=length) rail_profile();
}

module male_interface() {
  for(x=[-RM_RAIL_X,RM_RAIL_X])
    translate([x,0,0]) male_rail();
}

// Matching void, open at the front (-Y); material at +Y is the hard stop.
module rail_channel(length=RM_RAIL_L+2*RM_CLEARANCE) {
  translate([0,-RM_DOCK_L/2-RM_EPS,RM_DOCK_H+RM_EPS]) rotate([-90,0,0])
    linear_extrude(height=length)
      rail_profile(RM_RAIL_ROOT+2*RM_CLEARANCE,
                   RM_RAIL_HEAD+2*RM_CLEARANCE,
                   RM_RAIL_H+RM_EPS);
}

module universal_dock() {
  difference() {
    translate([-RM_DOCK_W/2,-RM_DOCK_L/2,0])
      rounded_box([RM_DOCK_W,RM_DOCK_L,RM_DOCK_H],3);
    for(x=[-RM_RAIL_X,RM_RAIL_X]) translate([x,0,0]) rail_channel();
    for(x=[-11,11], y=[-11,11])
      translate([x,y,-RM_EPS]) cylinder(h=RM_DOCK_H+2*RM_EPS,d=RM_M3_CLEARANCE);
  }
}

// Place a carrier's Z=0 plane at the dock surface; its rails fill the recess.
function docked_carrier_z() = RM_DOCK_H;
// Centre position after the rail reaches the rear stop.
function docked_carrier_y() = -RM_DOCK_L/2 - RM_EPS +
                              RM_RAIL_L/2 + 2*RM_CLEARANCE;
