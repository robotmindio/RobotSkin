include <../lib/robotskin.scad>
translate([0,0,(RM_UNO_SIZE[1]+2*RM_UNO_BORDER)/2])
  rotate([90,0,0]) uno_carrier();
