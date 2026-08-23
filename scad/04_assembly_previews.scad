include <rm_common.scad>
use <03_grove_20x20_carrier.scad>

SCENE="overview"; // overview, flat, corner, grove, double or edges
assert(SCENE=="overview" || SCENE=="flat" || SCENE=="corner" ||
       SCENE=="grove" || SCENE=="double" || SCENE=="edges",
       "Unknown preview scene");

PANEL_COLOR=[0.60,0.72,0.84];
LINK_COLOR=[1.00,0.68,0.05];
GASKET_COLOR=[0.05,0.75,0.72];
CARRIER_COLOR=[0.16,0.38,0.64];
PCB_COLOR=[0.10,0.55,0.25];

module grove_board() {
  color(PCB_COLOR) difference() {
    translate([-10,-10,0]) rounded_box([20,20,1.6],1);
    for(x=[-8,8], y=[-8,8])
      translate([x,y,-RM_EPS]) cylinder(h=1.6+2*RM_EPS,d=2.2);
  }
  color("silver") translate([-5,7,1.6]) cube([10,6,4]);
}

module overview_scene() {
  color(PANEL_COLOR) {
    translate([-55,5,0]) panel([80,80]);
    translate([45,25,0]) panel([80,40]);
    translate([25,-30,0]) panel();
  }
  color(LINK_COLOR) {
    translate([66,-30,0]) flat_link();
    translate([102,-22,0]) angle_link();
  }
  color(GASKET_COLOR) {
    translate([66,-55,0]) rotate([0,0,90]) flat_gasket();
    translate([100,5,0]) angle_gasket();
  }
  color(CARRIER_COLOR) translate([102,30,0]) grove_20x20_carrier();
}

module flat_scene() {
  color(PANEL_COLOR) {
    translate([-RM_UNIT/2,0,14]) panel();
    translate([ RM_UNIT/2,0,14]) panel();
  }
  color(LINK_COLOR) flat_link();
  color(GASKET_COLOR)
    translate([0,0,RM_LINK_T-RM_GASKET_GROOVE]) flat_gasket();
}

module corner_scene() {
  color(PANEL_COLOR) translate([0,-RM_UNIT/2,0]) panel();
  color(PANEL_COLOR)
    translate([0,RM_PANEL_T,RM_PANEL_T+RM_UNIT/2])
      rotate([90,0,0]) panel();
  color(LINK_COLOR) translate([0,0,RM_PANEL_T]) angle_link();
  color(GASKET_COLOR) translate([0,0,RM_PANEL_T]) angle_gasket();
}

module grove_scene() {
  color(PANEL_COLOR) panel();
  color(CARRIER_COLOR) translate([0,0,18]) grove_20x20_carrier();
  translate([0,0,34]) grove_board();
}

module double_scene() {
  color([PANEL_COLOR[0],PANEL_COLOR[1],PANEL_COLOR[2],0.72])
    translate([0,0,20]) rotate([90,0,0]) panel([80,40]);
  color(CARRIER_COLOR)
    translate([-20,20,20]) rotate([-90,0,0]) grove_20x20_carrier();
  color(CARRIER_COLOR)
    translate([20,-28,20]) rotate([90,0,0]) rotate([0,0,90])
      grove_20x20_carrier();
}

// Two panels joined north-edge-to-south-edge, plus an exploded pair showing
// the integral edge pegs and edge ports.
module edge_scene() {
  color(PANEL_COLOR) {
    panel();
    translate([0,RM_UNIT,0]) panel();
    translate([70,-RM_UNIT/2,0]) panel();
    translate([70,RM_UNIT/2+RM_UNIT+10,0]) panel();
  }
}

if(SCENE=="overview") overview_scene();
if(SCENE=="flat") flat_scene();
if(SCENE=="corner") corner_scene();
if(SCENE=="grove") grove_scene();
if(SCENE=="double") double_scene();
if(SCENE=="edges") edge_scene();
