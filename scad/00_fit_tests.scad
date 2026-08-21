include <rm_common.scad>

PART="holes"; // holes, pin_small, pin_nominal, pin_large or previews
assert(PART=="holes" || PART=="pin_small" || PART=="pin_nominal" ||
       PART=="pin_large" || PART=="preview_flat" || PART=="preview_90",
       "Unknown fit-test part");

module hole_fit_test() {
  difference() {
    rounded_plate([32,12]);
    for(x=[-8,0,8]) hole_at([x,0]);
  }
}

module preview_flat() {
  color("lightsteelblue") {
    translate([-RM_UNIT/2,0,0]) plate();
    translate([ RM_UNIT/2,0,0]) plate();
  }
  color("gold") translate([0,0,-RM_PLATE_T]) flat_link();
  color("tomato")
    for(x=[-RM_GRID/2,RM_GRID/2], y=[-RM_GRID,RM_GRID])
      translate([x,y,-RM_PLATE_T-RM_PIN_HEAD_T]) push_pin();
}

module preview_90() {
  color("lightsteelblue") translate([0,-RM_UNIT/2,0]) plate();
  color("lightsteelblue")
    translate([0,RM_PLATE_T,RM_PLATE_T+RM_UNIT/2])
      rotate([90,0,0]) plate();
  color("gold") translate([0,0,RM_PLATE_T]) angle_link();
}

if(PART=="holes") hole_fit_test();
if(PART=="pin_small") push_pin(-0.1);
if(PART=="pin_nominal") push_pin();
if(PART=="pin_large") push_pin(0.1);
if(PART=="preview_flat") preview_flat();
if(PART=="preview_90") preview_90();
