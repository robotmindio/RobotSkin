include <../source/rm_common.scad>

PART="port"; // port, peg_small, peg_nominal or peg_large
assert(PART=="port" || PART=="peg_small" || PART=="peg_nominal" ||
       PART=="peg_large", "Unknown fit-test part");

// Square XY grips: the coupons are hand-held, so both are plain rounded
// slabs at the same grip footprint as a 12 mm circle.
GRIP=12;

module port_coupon() {
  coupon_t=RM_INSERT_DEPTH+2;
  difference() {
    translate([-GRIP/2,-GRIP/2,0]) rounded_box([GRIP,GRIP,coupon_t],2);
    blind_port_cut();
    // full-depth seat so the insert presses through and pushes out for
    // reuse; a real panel keeps the blind bottom, this coupon is for swap
    translate([0,0,-RM_EPS]) cylinder(h=coupon_t+2*RM_EPS,d=RM_INSERT_BORE);
  }
}

// Same integral system as the real carriers, reduced to a coupon: hex
// frustum + a full-depth centre bore so an M3 screw passes all the way
// through the peg and the grip.
module peg_coupon(delta=0) {
  base=3.2;
  difference() {
    union() {
      translate([-GRIP/2,-GRIP/2,0]) rounded_box([GRIP,GRIP,base+0.2],2);
      translate([0,0,base]) mount_peg(delta);
    }
    translate([0,0,-RM_EPS])
      cylinder(h=base+RM_PORT_DEPTH+2*RM_EPS,d=RM_PEG_BORE);
  }
}

if(PART=="port") port_coupon();
if(PART=="peg_small") peg_coupon(-0.1);
if(PART=="peg_nominal") peg_coupon();
if(PART=="peg_large") peg_coupon(0.1);