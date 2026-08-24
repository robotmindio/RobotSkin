include <../source/rm_common.scad>

// Actual blind port and actual hollow peg; print this before the full set.
difference() {
  translate([-10,-10,0]) rounded_box([20,20,RM_PLATE_T],2);
  translate([0,0,RM_PLATE_T]) mirror([0,0,1]) blind_port_cut();
}
translate([20,-10,0]) rounded_box([20,20,3],2);
translate([30,0,3]) mount_peg();
