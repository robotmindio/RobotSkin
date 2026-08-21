include <rm_common.scad>

PART="hex_socket"; // printable coupons or assembly previews
assert(PART=="hex_socket" || PART=="hex_plug" ||
       PART=="edge" || PART=="preview_flat" || PART=="preview_90",
       "Unknown fit-test part");

module hex_socket_coupon() {
  difference() {
    union() {
      translate([-14,-14,0]) rounded_box([28,28,RM_PLATE_T],1.5);
      socket_boss();
    }
    socket_pair();
  }
}

module hex_plug_coupon() {
  carrier_mount() {
    translate([-14,-14,0]) rounded_box([28,28,2],1.5);
  }
}

module edge_coupon() {
  difference() {
    union() {
      translate([-20,-10,0]) rounded_box([40,20,RM_PLATE_T],1);
      uniform_edge_tongues(40,10);
    }
    uniform_edge_socket_cuts(40,10);
    uniform_edge_insert_cuts(40,10);
  }
}

module preview_flat() {
  color("lightsteelblue") edge_coupon();
  color("gold") translate([0,20,0]) rotate([0,0,180])
    edge_coupon();
}

module preview_90() {
  color("lightsteelblue") edge_coupon();
  color("gold") translate([0,10,RM_PLATE_T+10])
    multmatrix([[-1,0,0,0],
                [0,0,-1,0],
                [0,-1,0,0],
                [0,0,0,1]]) edge_coupon();
}

if(PART=="hex_socket") hex_socket_coupon();
if(PART=="hex_plug") print_on_y_edge(28) hex_plug_coupon();
if(PART=="edge") edge_coupon();
if(PART=="preview_flat") preview_flat();
if(PART=="preview_90") preview_90();
