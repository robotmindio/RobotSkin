include <rm_common.scad>
// 90-degree wall mount: plate + horizontal universal dock shelf.
union(){
  translate([-20,-2,-20]) rounded_box([40,4,40],2);
  translate([0,RM_DOCK_L/2+1,-16]) rotate([90,0,0]) universal_dock();
  // gussets
  for(x=[-14,14]) hull(){
    translate([x,0,-15]) cube([2,4,2]);
    translate([x,14,-15]) cube([2,2,14]);
  }
}
