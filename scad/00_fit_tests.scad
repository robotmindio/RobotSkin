include <rm_common.scad>

PART="port"; // port, peg_small, peg_nominal, peg_large or previews
assert(PART=="port" || PART=="peg_small" || PART=="peg_nominal" ||
       PART=="peg_large" || PART=="preview_flat" ||
       PART=="preview_90", "Unknown fit-test part");

module port_coupon() {
  difference() {
    rounded_panel([20,20]);
    blind_port_cut();
    translate([0,0,RM_PANEL_T]) mirror([0,0,1]) blind_port_cut();
  }
}

module peg_coupon(delta=0) {
  difference() {
    union() {
      rounded_panel([16,16],RM_LINK_T,2);
      translate([0,0,RM_LINK_T]) mount_peg(delta);
    }
    optional_screw_cut(RM_LINK_T+RM_PORT_DEPTH);
  }
}

module preview_flat() {
  color("lightsteelblue") {
    translate([-RM_UNIT/2,0,RM_LINK_T]) panel();
    translate([ RM_UNIT/2,0,RM_LINK_T]) panel();
  }
  color("gold") flat_link();
  color("turquoise")
    translate([0,0,RM_LINK_T-RM_GASKET_GROOVE]) flat_gasket();
}

module preview_90() {
  color("lightsteelblue") translate([0,-RM_UNIT/2,0]) panel();
  color("lightsteelblue")
    translate([0,RM_PANEL_T,RM_PANEL_T+RM_UNIT/2])
      rotate([90,0,0]) panel();
  color("gold") translate([0,0,RM_PANEL_T]) angle_link();
  color("turquoise") translate([0,0,RM_PANEL_T]) angle_gasket();
}

if(PART=="port") port_coupon();
if(PART=="peg_small") peg_coupon(-0.1);
if(PART=="peg_nominal") peg_coupon();
if(PART=="peg_large") peg_coupon(0.1);
if(PART=="preview_flat") preview_flat();
if(PART=="preview_90") preview_90();
