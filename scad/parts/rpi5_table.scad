include <../lib/robotskin.scad>
translate([0,0,RM_RPI5_TABLE_CLEARANCE+RM_CARRIER_T])
  rotate([180,0,0]) rpi5_table();
