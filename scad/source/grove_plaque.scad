include <rm_common.scad>

// One generic 20 mm Grove plaque. Slots accept M2 screws or small zip ties.
module grove_plaque() {
  difference() {
    union() {
      translate([-14,-14,0]) rounded_box([28,28,3],3);
      for(x=[-5,5]) translate([x,0,0]) downward_peg();
    }
    for(x=[-5,5]) translate([x,0,0]) top_screw_cut();
    for(x=[-8,8], y=[-8,8])
      translate([x,y,-RM_EPS]) linear_extrude(height=3+2*RM_EPS) hull() {
          translate([0,-2]) circle(d=2.8);
          translate([0,2]) circle(d=2.8);
        }
  }
}

grove_plaque();
