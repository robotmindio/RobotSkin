include <rm_common.scad>
TYPE="magnet"; // magnet or tripod
assert(TYPE=="magnet" || TYPE=="tripod", "TYPE must be magnet or tripod");
difference(){
  rounded_box([38,42,5],3,center=true);
  if(TYPE=="magnet") for(x=[-12,12],y=[-14,14]) translate([x,y,1.5]) cylinder(h=3.2,d=6.2,center=true);
  if(TYPE=="tripod") cylinder(h=8,d=6.5,center=true); // clearance for 1/4-20 heat-set/metal insert
}
translate([0,0,5]) universal_dock();
