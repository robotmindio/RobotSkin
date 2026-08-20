include <rm_common.scad>

PART="hex_socket"; // printable coupons or preview_0 / preview_90
assert(PART=="hex_socket" || PART=="hex_plug" ||
       PART=="edge_male" || PART=="edge_female" ||
       PART=="preview_0" || PART=="preview_90",
       "Unknown fit-test part");

module hex_socket_coupon() {
  difference() {
    translate([-14,-14,0]) rounded_box([28,28,RM_PANEL_T],1.5);
    socket_pair();
  }
}

module hex_plug_coupon() {
  union() {
    translate([-14,-14,0]) rounded_box([28,28,2],1.5);
    integral_hex_plug();
  }
}

module edge_male_coupon() {
  difference() {
    union() {
      translate([-14,-10,0]) rounded_box([28,20,RM_PANEL_T],1);
      male_edge(28,10);
    }
    male_edge_m3_cuts(28,10);
  }
}

module edge_female_coupon() {
  difference() {
    translate([-14,-10,0]) rounded_box([28,20,RM_PANEL_T],1);
    female_edge_cuts(28,10);
    female_90_cuts(28,10);
  }
}

module preview_0() {
  color("lightsteelblue") edge_female_coupon();
  color("gold") translate([0,-20,0]) edge_male_coupon();
}

module preview_90() {
  color("lightsteelblue") edge_female_coupon();
  color("gold") translate([0,-10,20]) rotate([-90,0,0])
    edge_male_coupon();
}

if(PART=="hex_socket") hex_socket_coupon();
if(PART=="hex_plug") print_on_y_edge(28) hex_plug_coupon();
if(PART=="edge_male") edge_male_coupon();
if(PART=="edge_female") edge_female_coupon();
if(PART=="preview_0") preview_0();
if(PART=="preview_90") preview_90();
