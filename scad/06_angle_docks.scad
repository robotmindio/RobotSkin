include <rm_common.scad>
ANGLE=30; // 0, 15, 30 or 45. 90 is a wall bracket style in its dedicated file.
if(ANGLE==0) universal_dock();
else {
  L=RM_DOCK_L+4; MINH=3; DH=tan(ANGLE)*L;
  union(){
    angle_wedge(ANGLE);
    translate([0,0,MINH+DH/2+RM_DOCK_H/2]) rotate([ANGLE,0,0]) universal_dock();
  }
}
