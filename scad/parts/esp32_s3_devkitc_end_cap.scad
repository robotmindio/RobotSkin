include <../lib/robotskin.scad>
translate([0,0,RM_ESP32_S3_DEVKITC_BODY_SIZE[0]/2+2.5])
  rotate([0,-90,0]) esp32_s3_devkitc_end_cap();
