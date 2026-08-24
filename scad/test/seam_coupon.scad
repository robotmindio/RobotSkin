// Seam coupon: one slab reproducing the coupling surface of a real flat
// joint. Four through-bores land exactly on the flat_link_40 hole grid,
// split across a centre seam line. Seat M3x3x4 inserts (pressed from the
// face), lay the real flat_link_40 on top, run M3 screws through the link
// into the inserts — the full bolted-coupling path in a single small print.
// Bores are through so inserts can be pressed in from one side and pushed
// out for re-use.
include <../source/rm_common.scad>

module seam_coupon() {
  len = RM_UNIT;          // matches the flat_link-40 length
  half = RM_LINK_W/2 + 2; // 14: link centre band + material margin
  difference() {
    translate([-len/2, -half, 0]) cube([len, 2*half, RM_PANEL_T]);
    for(x=[-RM_GRID/2, RM_GRID/2], y=[-RM_LINK_ROW, RM_LINK_ROW])
      translate([x, y, -RM_EPS]) cylinder(h=RM_PANEL_T+2*RM_EPS,d=rm_insert_bore());
  }
}

seam_coupon();