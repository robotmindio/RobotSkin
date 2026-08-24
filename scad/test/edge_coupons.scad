include <../source/rm_common.scad>

// One 1 U battlement edge on a handle strip. Print two: they mate flush
// with one coupon flipped over, in both tab-first directions. Prints lying
// on a long side face, features upward, support-free.

module edge_coupon() {
  union() {
    translate([-20,-12,0]) rounded_box([40,12,RM_PANEL_T],2);
    edge_run_x(RM_UNIT, 0, 1, 0);
  }
}

rotate([90,0,0]) edge_coupon();
