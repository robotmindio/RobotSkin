include <rm_common.scad>
use <plate_8x8.scad>
use <flat_join.scad>
use <angle_join.scad>
use <grove_plaque.scad>

SCENE = "overview"; // overview, port, flat, angle
assert(SCENE=="overview" || SCENE=="port" || SCENE=="flat" || SCENE=="angle",
       "Unknown preview scene");

PLATE_COLOR = [0.60,0.72,0.84];
JOIN_COLOR = [1.00,0.68,0.05];
PLAQUE_COLOR = [0.16,0.38,0.64];
INSERT_COLOR = [0.72,0.42,0.08];

module insert_demo() {
  color(INSERT_COLOR) cylinder(h=RM_INSERT_DEPTH,d=RM_INSERT_OD);
}

module overview_scene() {
  color(PLATE_COLOR) translate([-55,0,0]) plate_8x8();
  color(JOIN_COLOR) translate([45,-30,0]) flat_join();
  color(JOIN_COLOR) translate([45,35,0]) angle_join();
  color(PLAQUE_COLOR) translate([105,-10,0]) grove_plaque();
}

module port_scene() {
  // Half section exposes the blind bore, then shows the insert's final seat.
  color(PLATE_COLOR) intersection() {
    difference() {
      translate([-10,-10,0]) rounded_box([20,20,RM_PLATE_T],2);
      translate([0,0,RM_PLATE_T]) mirror([0,0,1]) blind_port_cut();
    }
    translate([-10,0,-RM_EPS]) cube([20,10,RM_PLATE_T+2*RM_EPS]);
  }
  translate([0,0,RM_PLATE_T-RM_INSERT_DEPTH]) insert_demo();
}

module flat_scene() {
  color(PLATE_COLOR) translate([0,-40,0]) plate_8x8();
  color(PLATE_COLOR) translate([0,40,0]) plate_8x8();
  color(JOIN_COLOR) translate([0,0,RM_PLATE_T]) flat_join();
}

module angle_scene() {
  color(PLATE_COLOR) plate_8x8();
  color(PLATE_COLOR) translate([0,40,48]) rotate([-90,0,0]) plate_8x8();
  color(JOIN_COLOR) translate([0,40,RM_PLATE_T]) angle_join();
}

if(SCENE=="overview") overview_scene();
if(SCENE=="port") port_scene();
if(SCENE=="flat") flat_scene();
if(SCENE=="angle") angle_scene();
