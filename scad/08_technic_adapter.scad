include <rm_common.scad>

SIZE=[40,24];
HOLE_D=4.9+2*RM_FIT;

module technic_adapter() {
  carrier_mount() difference() {
    translate([-SIZE[0]/2,-SIZE[1]/2,0]) rounded_box([SIZE[0],SIZE[1],3],2);
    for(x=[-16,-8,8,16], y=[-8,0,8])
      translate([x,y,-0.1]) cylinder(h=3.2,d=HOLE_D,$fn=32);
  }
}

print_on_y_edge(SIZE[1]) technic_adapter();
