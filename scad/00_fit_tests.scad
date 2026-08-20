include <rm_common.scad>

PART="hex_socket"; // hex_socket, hex_plug, hinge_bead or hinge_channel
assert(PART=="hex_socket" || PART=="hex_plug" ||
       PART=="hinge_bead" || PART=="hinge_channel",
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

module hinge_bead_coupon() {
  union() {
    translate([-14,-8,0]) rounded_box([28,16,RM_PANEL_T],1);
    edge_a(28,8);
  }
}

module hinge_channel_coupon() {
  union() {
    translate([-14,-8,0]) rounded_box([28,16,RM_PANEL_T],1);
    edge_b(28,8);
  }
}

if(PART=="hex_socket") hex_socket_coupon();
if(PART=="hex_plug") print_on_y_edge(28) hex_plug_coupon();
if(PART=="hinge_bead") hinge_bead_coupon();
if(PART=="hinge_channel") hinge_channel_coupon();
