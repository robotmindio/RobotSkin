include <rm_common.scad>
// Cube beacon with 4 side AprilTag inserts + top insert, same universal lower interface.
TAG=42; BORDER=3; S=TAG+2*BORDER; WALL=2.0;
module face_rails(){ tag_insert_rails([TAG,TAG],border=BORDER,rail=1.2,depth=1.8); }

difference(){
  union(){
    translate([-S/2,-S/2,0]) rounded_box([S,S,S],3);
    translate([0,0,-RM_RAIL_H]) male_interface();
  }
  translate([-S/2+WALL,-S/2+WALL,WALL]) cube([S-2*WALL,S-2*WALL,S]);
  // side openings reduce mass and preserve RF paths
  for(a=[0,90,180,270]) rotate([0,0,a]) translate([0,-S/2-0.1,S/2]) rotate([90,0,0]) cube([TAG-6,TAG-6,WALL+1],center=true);
}
// rails offset just outside each face
for(a=[0,90,180,270]) rotate([0,0,a]) translate([0,-S/2-0.8,S/2]) rotate([90,0,0]) face_rails();
translate([0,0,S+0.8]) face_rails();
