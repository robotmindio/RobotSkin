include <../lib/robotskin.scad>
translate([0,0,RM_ESP32_DEVKITC_BODY_SIZE[1]/2])
  rotate([90,0,0]) esp32_devkitc_carrier();
