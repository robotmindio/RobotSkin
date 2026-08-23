include <rm_common.scad>

PART="male"; // male or female
assert(PART=="male" || PART=="female", "Unknown edge coupon");

// Coupons simulate 1U panel edges. Male edges are flush with the panel
// profile. A female edge carries a 4 mm interior rib so its horizontal
// hexagonal ports keep real walls inside the 8 mm panel thickness.
// Both print lying on a long side face, features upward, support-free.

module edge_male() {
  translate([-20,-6,0]) rounded_box([40,12,RM_PANEL_T],2);
  for(x=edge_anchors(RM_UNIT))
    translate([x,6,RM_PANEL_T/2])
      rotate([-90,0,0]) mount_peg(h=RM_EDGE_PEG_L);
}

module edge_female() {
  difference() {
    union() {
      translate([-20,-6,0]) rounded_box([40,12,RM_PANEL_T],2);
      translate([-20,-6,RM_PANEL_T]) rounded_box([40,12,4],2);
    }
    for(x=edge_anchors(RM_UNIT))
      translate([x,-6,RM_PANEL_T+2])
        rotate([-90,0,0]) edge_port_cut();
  }
}

// Resting on a side face turns the horizontal peg/port axes upright.
if(PART=="male") rotate([90,0,0]) edge_male();
if(PART=="female") rotate([90,0,0]) edge_female();
