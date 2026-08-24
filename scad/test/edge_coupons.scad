include <../source/rm_common.scad>

// Hermaphrodite battlement coupon A: a panel's phase-0 edge.
// Body lies behind the seam; tabs point +y on even grid lines,
// sockets are blind cuts at odd grid lines opening toward the seam.
module edge_coupon_a() {
  difference() {
    union() {
      translate([-20,-12,0]) rounded_box([40,12,RM_PANEL_T],2);
      edge_tabs_x(RM_UNIT, 0, 1, 0);
    }
    edge_sockets_x(RM_UNIT, 0, 1, 0);
  }
}

// Coupon B is its mirror: the mating phase-1 edge. Body on the
// other side of the seam so the flat pair closes around y=0.
module edge_coupon_b() {
  difference() {
    union() {
      translate([-20,0,0]) rounded_box([40,12,RM_PANEL_T],2);
      edge_tabs_x(RM_UNIT, 0, -1, 1);
    }
    edge_sockets_x(RM_UNIT, 0, -1, 1);
  }
}

// Both coupons print flat, features up, support-free.
rotate([90,0,0]) edge_coupon_a();
translate([0,0,40]) rotate([90,0,0]) edge_coupon_b();