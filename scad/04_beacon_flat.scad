include <rm_common.scad>
// AprilTag + beacon carrier with two integral hex plugs.
TAG=60;
PCB=[28,45,8]; // provisional beacon PCB envelope; measure actual board before final print.
W=max(TAG+8,PCB[0]+8); H=max(TAG+8,PCB[1]+8); D=14;

union(){
  difference(){
    translate([-W/2,-H/2,0]) rounded_box([W,H,D],3);
    // rear electronics cavity open to rear side
    translate([-PCB[0]/2,-PCB[1]/2,4]) cube([PCB[0],PCB[1],D+1]);
    // large RF keep-out / ventilation opening behind antenna region
    translate([W/2-18,-16,6]) cube([20,32,D]);
  }
  two_integral_plugs();
}
// front rails + hard stop for interchangeable tag insert
translate([0,0,D-0.1]) tag_insert_rails([TAG,TAG],border=3.3,rail=1.3,depth=2.0);
