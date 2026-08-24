include <rm_common.scad>
use <grove_carrier.scad>

SCENE="overview"; // overview, pair, corner, grove or cube
assert(SCENE=="overview" || SCENE=="pair" || SCENE=="corner" ||
       SCENE=="grove" || SCENE=="cube", "Unknown preview scene");

PANEL_COLOR=[0.60,0.72,0.84];
LINK_COLOR=[1.00,0.68,0.05];
CARRIER_COLOR=[0.16,0.38,0.64];
PCB_COLOR=[0.10,0.55,0.25];
LID_COLOR=[0.72,0.80,0.90];

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
    translate([66,-30,RM_PANEL_T]) flat_link();
    translate([102,-20,RM_PANEL_T]) rotate([0,0,90]) angle_link();
  }
  color(CARRIER_COLOR) translate([102,30,0]) grove_20x20_carrier();
}

// Two panels join edge-to-edge through one flat link bridging the seam.
module pair_scene() {
  color(PANEL_COLOR) panel();
  color(PANEL_COLOR) translate([0,RM_UNIT,0]) panel();
  color(LINK_COLOR) translate([0,RM_UNIT/2,RM_PANEL_T]) flat_link();
}

// A 90-degree corner: floor, wall and one angle link in the inner corner.
module corner_scene() {
  color(PANEL_COLOR) panel();
  color(LID_COLOR) translate([0,12,20]) rotate([90,0,0]) panel();
  color(LINK_COLOR) translate([0,12,8]) angle_link();
}

module grove_scene() {
  color(PANEL_COLOR) panel();
  color(CARRIER_COLOR) translate([0,0,18]) grove_20x20_carrier();
  translate([0,0,34]) grove_board();
}

// Closed cube: floor, four walls, lid, and four angle links on the inner
// corners. Wall corners overlap (each wall spans the full panel length);
// the links carry the structure.
module cube_scene() {
  color(PANEL_COLOR) panel(); // floor
  color(LID_COLOR) {
    translate([0,-12,20]) rotate([90,0,0]) panel();  // north wall
    translate([0,12,20]) rotate([-90,0,0]) panel();  // south wall
    translate([12,0,20]) rotate([0,90,0]) panel();   // east wall
    translate([-12,0,20]) rotate([0,-90,0]) panel(); // west wall
    translate([0,0,RM_UNIT+RM_PANEL_T+8]) rotate([180,0,0]) panel(); // lid
  }
  color(LINK_COLOR) {
    translate([0,12,8]) angle_link();
    translate([0,-12,8]) rotate([0,0,180]) angle_link();
    translate([12,0,8]) rotate([0,0,-90]) angle_link();
    translate([-12,0,8]) rotate([0,0,90]) angle_link();
  }
}

if(SCENE=="overview") overview_scene();
if(SCENE=="pair") pair_scene();
if(SCENE=="corner") corner_scene();
if(SCENE=="grove") grove_scene();
if(SCENE=="cube") cube_scene();
