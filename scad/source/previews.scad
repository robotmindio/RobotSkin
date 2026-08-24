include <rm_common.scad>
use <grove_carrier.scad>

SCENE="overview"; // overview, pair, corner, grove or cube
assert(SCENE=="overview" || SCENE=="pair" || SCENE=="corner" ||
       SCENE=="grove" || SCENE=="cube", "Unknown preview scene");

PANEL_COLOR=[0.60,0.72,0.84];
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
  color(CARRIER_COLOR) translate([102,30,0]) grove_20x20_carrier();
}

// Two panels mate with both edges plain: no flips, no twists.
module pair_scene() {
  color(PANEL_COLOR) panel();
  color(LID_COLOR) translate([0,RM_UNIT,0]) panel();
}

// A direct 90 degree fold with no connector parts.
module corner_scene() {
  color(PANEL_COLOR) panel();
  color(LID_COLOR)
    translate([0,RM_TAB_PROUD+RM_PANEL_T,RM_UNIT/2])
      rotate([90,0,0]) panel();
}

module grove_scene() {
  color(PANEL_COLOR) panel();
  color(CARRIER_COLOR) translate([0,0,18]) grove_20x20_carrier();
  translate([0,0,34]) grove_board();
}

// Exploded view: five walls in their folded poses, lid above. Wall-to-wall
// vertical seams are still being validated; each wall is lifted so the
// view shows intent, not asserted contacts.
module cube_scene() {
  lift=RM_TAB_PROUD;
  color(PANEL_COLOR) {
    panel();
    translate([0,lift+RM_PANEL_T+18,RM_UNIT/2+30])
      rotate([90,0,0]) panel();
    translate([0,-lift-RM_PANEL_T-18,RM_UNIT/2+60])
      rotate([-90,0,0]) panel();
    rotate([0,0,-90]) translate([0,lift+RM_PANEL_T+36,RM_UNIT/2+18])
      rotate([90,0,0]) panel();
    rotate([0,0,90]) translate([0,lift+RM_PANEL_T+54,RM_UNIT/2+42])
      rotate([90,0,0]) panel();
  }
  color(LID_COLOR) translate([0,0,RM_UNIT+RM_PANEL_T+80])
    rotate([180,0,0]) panel();
}

if(SCENE=="overview") overview_scene();
if(SCENE=="pair") pair_scene();
if(SCENE=="corner") corner_scene();
if(SCENE=="grove") grove_scene();
if(SCENE=="cube") cube_scene();
