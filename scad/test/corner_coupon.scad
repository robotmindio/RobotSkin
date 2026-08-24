include <../source/rm_common.scad>

// 90-degree fold probe. Two battlement leaves own the seam a real panel
// pair yields; a thin hinge web ties them low on the seam so the pair
// stays one part and folds about the seam axis.
//
// Flat, the leaves interleave exactly as a panel seam should: leaf A
// leads tabs on even grid lines, leaf B leads tabs on odd lines, so tabs
// enter sockets across the whole edge.
//
// Fold the leaves up about the hinge to 90 and press them together:
// either the teeth engage and the fold holds on its own, or they slip and
// a corner needs a part.

module leaf(sy, phase) {
  difference() {
    union() {
      translate([-20, sy>0 ? -12 : 0, 0]) rounded_box([40, 12, RM_PANEL_T], 2);
      edge_tabs_x(RM_UNIT, 0, sy, phase);
    }
    edge_sockets_x(RM_UNIT, 0, sy, phase);
  }
}

module corner_coupon() {
  leaf(+1, 0);  // A: phase 0, teeth +y
  leaf(-1, 1);  // B: phase 1, teeth -y
  // Hinge web: short central band across the seam, fused into both leaves
  // below the teeth. The free ends let the teeth interact while the web
  // keeps the pair one part; bending it to 90 is the test.
  translate([-10, -0.5, 0]) cube([20, 1.0, 1.2]);
}

corner_coupon();