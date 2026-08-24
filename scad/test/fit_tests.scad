include <../source/rm_common.scad>

PART="port"; // port, peg_small, peg_nominal or peg_large
assert(PART=="port" || PART=="peg_small" || PART=="peg_nominal" ||
       PART=="peg_large", "Unknown fit-test part");

module port_coupon() {
  coupon_t=RM_INSERT_DEPTH+2;
  difference() {
    cylinder(h=coupon_t,d=12);
    blind_port_cut();
    // full-depth seat so the insert presses through and pushes out for
    // reuse; a real panel keeps the blind bottom, this coupon is for swap
    translate([0,0,-RM_EPS]) cylinder(h=coupon_t+2*RM_EPS,d=RM_INSERT_BORE);
  }
}

module peg_coupon(delta=0) {
  base=3.2;
  union() {
    cylinder(h=base+0.2,d=10); // overlap fuses handle and peg into one solid
    translate([0,0,base]) mount_peg(delta);
  }
}

if(PART=="port") port_coupon();
if(PART=="peg_small") peg_coupon(-0.1);
if(PART=="peg_nominal") peg_coupon();
if(PART=="peg_large") peg_coupon(0.1);
