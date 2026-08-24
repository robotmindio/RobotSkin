// Seam coupon: one slab reproducing the coupling surface of a real flat
// joint. Four blind bores land exactly on the flat_link_40 hole grid, split
// across a centre seam line. Seat M3x3x4 inserts, lay the real flat_link_40
// on the face, run M3 screws through the link into the inserts — the full
// bolted-coupling path in a single small print.
include <../source/rm_common.scad>

module seam_coupon() {
  len = RM_UNIT;          // matches the flat_link-40 length
  half = RM_LINK_W/2 + 2; // 14: link centre band + material margin
  difference() {
    translate([-len/2, -half, 0]) cube([len, 2*half, RM_PANEL_T]);
    for(x=[-RM_GRID/2, RM_GRID/2], y=[-RM_LINK_ROW, RM_LINK_ROW])
      translate([x, y, RM_PANEL_T]) mirror([0, 0, 1])
        blind_port_cut();
  }
}

seam_coupon();