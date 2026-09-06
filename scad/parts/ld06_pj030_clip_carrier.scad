include <../lib/robotskin.scad>
translate([0,0,RM_CARRIER_T+RM_PJ030_PCB_T-RM_PJ030_CLAMP_PRELOAD])
  rotate([180,0,0]) ld06_pj030_clamp_base();
