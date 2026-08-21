include <rm_common.scad>
use <03_grove_20x20_carrier.scad>

SCENE="overview"; // overview, flat, corner or grove
assert(SCENE=="overview" || SCENE=="flat" ||
       SCENE=="corner" || SCENE=="grove", "Unknown preview scene");

PLATE_COLOR=[0.60,0.72,0.84];
CONNECTOR_COLOR=[1.00,0.68,0.05];
PIN_COLOR=[0.95,0.20,0.12];
CARRIER_COLOR=[0.16,0.38,0.64];
PCB_COLOR=[0.10,0.55,0.25];

module grove_board() {
  difference() {
    translate([-10,-10,0]) rounded_box([20,20,1.6],1);
    for(x=[-RM_GRID,RM_GRID], y=[-RM_GRID,RM_GRID])
      translate([x,y,-RM_EPS]) cylinder(h=1.6+2*RM_EPS,d=2.2);
  }
  color("silver") translate([-5,7,1.6]) cube([10,6,4]);
}

module overview_scene() {
  color(PLATE_COLOR) {
    translate([-55,5,0]) plate([80,80]);
    translate([45,25,0]) plate([80,40]);
    translate([25,-30,0]) plate([40,40]);
  }
  color(CONNECTOR_COLOR) {
    translate([62,-30,0]) flat_link();
    translate([92,-25,0]) angle_link();
  }
  color(PIN_COLOR)
    for(x=[48,58,68]) translate([x,-52,0]) push_pin();
  color(CARRIER_COLOR) translate([88,18,0]) grove_20x20_carrier();
}

module flat_scene() {
  color(PLATE_COLOR) {
    translate([-RM_UNIT/2,0,20]) plate();
    translate([ RM_UNIT/2,0,20]) plate();
  }
  color(CONNECTOR_COLOR) translate([0,0,6]) flat_link();
  color(PIN_COLOR)
    for(x=[-RM_GRID/2,RM_GRID/2], y=[-RM_GRID,RM_GRID])
      translate([x,y,-11]) push_pin();
}

module corner_scene() {
  color(PLATE_COLOR) translate([0,-RM_UNIT/2,0]) plate();
  color(PLATE_COLOR)
    translate([0,RM_PLATE_T,RM_PLATE_T+RM_UNIT/2])
      rotate([90,0,0]) plate();
  color(CONNECTOR_COLOR) translate([0,0,RM_PLATE_T]) angle_link();
  color(PIN_COLOR) {
    for(x=[-RM_GRID,RM_GRID])
      translate([x,-RM_GRID/2,20])
        rotate([180,0,0]) push_pin();
    for(x=[-RM_GRID,RM_GRID])
      translate([x,-18,
                 RM_PLATE_T+RM_GRID/2])
        rotate([-90,0,0]) push_pin();
  }
}

module grove_scene() {
  color(PLATE_COLOR) translate([0,0,10]) plate();
  color(CARRIER_COLOR) translate([0,0,25]) grove_20x20_carrier();
  color(PCB_COLOR) translate([0,0,43]) grove_board();
  color(PIN_COLOR)
    for(x=[-2*RM_GRID,2*RM_GRID])
      translate([x,0,-11]) push_pin();
}

if(SCENE=="overview") overview_scene();
if(SCENE=="flat") flat_scene();
if(SCENE=="corner") corner_scene();
if(SCENE=="grove") grove_scene();
