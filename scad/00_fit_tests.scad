include <rm_common.scad>

PART="hex"; // hex or hinge
assert(PART=="hex" || PART=="hinge", "PART must be hex or hinge");

module hex_fit_pair() {
  // Socket coupon.
  translate([-18,0,0]) difference() {
    translate([-14,-14,0]) rounded_box([28,28,RM_PANEL_T],1.5);
    socket_pair();
  }
  // Carrier coupon; the integral plug is already in print orientation.
  translate([18,0,RM_SOCKET_DEPTH-0.25]) union() {
    translate([-14,-14,0]) rounded_box([28,28,2],1.5);
    integral_hex_plug();
  }
}

module hinge_fit_pair() {
  // Two loose coupons in one print: bead edge above, channel edge below.
  translate([0,13,0]) union() {
    translate([-14,-8,0]) rounded_box([28,16,RM_PANEL_T],1);
    edge_a(28,8);
  }
  translate([0,-13,0]) union() {
    translate([-14,-8,0]) rounded_box([28,16,RM_PANEL_T],1);
    edge_b(28,8);
  }
}

if(PART=="hex") hex_fit_pair();
if(PART=="hinge") hinge_fit_pair();
