include <rm_common.scad>

RM_TAG_SIZE = 60;
RM_TAG_BORDER = 3;
RM_TAG_RAIL_BORDER = RM_TAG_BORDER+0.3;

module tag_insert(tag_size=RM_TAG_SIZE, border=RM_TAG_BORDER, t=1) {
  W=tag_size+2*border;
  H=tag_size+2*border;
  union() {
    translate([-W/2,-H/2,0]) rounded_box([W,H,t],1.2);
    translate([-8,-H/2-4,0]) rounded_box([16,5,t],1.2);
  }
}

module tag_insert_rails(tag_size=RM_TAG_SIZE, border=RM_TAG_RAIL_BORDER,
                        rail=1.5, depth=2.2, clearance=0.25,
                        lip=0.8, lip_t=0.6) {
  W=tag_size+2*border;
  H=tag_size+2*border;
  for(sx=[-1,1]) {
    x=sx>0 ? W/2+clearance : -W/2-clearance-rail;
    translate([x,-H/2-clearance,0])
      cube([rail,H+2*clearance+rail,depth]);
    translate([sx>0 ? W/2-lip : -W/2-clearance-rail,
               -H/2-clearance,depth-lip_t])
      cube([rail+clearance+lip,H+2*clearance+rail,lip_t]);
  }
  translate([-W/2-clearance-rail,H/2+clearance,0])
    cube([W+2*(clearance+rail),rail,depth]);
}
