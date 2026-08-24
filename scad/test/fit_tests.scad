// Fit coupons as minimal (1x1 = 40 mm) flat square system tiles.
// Port coupon: one real blind port + insert seat in the tile face.
// Peg coupon: the real integral male proud of the tile face, with the
// full-depth centre bore so an M3 screw passes the whole tile.
include <../source/rm_common.scad>

PART="port"; // port, peg_small, peg_nominal or peg_large
assert(PART=="port" || PART=="peg_small" || PART=="peg_nominal" ||
       PART=="peg_large", "Unknown fit-test part");

GRIP = RM_UNIT; // 40 mm square tile

module port_coupon() {
  difference() {
    rounded_panel(size=[GRIP,GRIP], t=RM_INSERT_DEPTH+2);
    blind_port_cut();
    translate([0,0,-RM_EPS]) cylinder(h=RM_INSERT_DEPTH+2, d=RM_INSERT_BORE);
  }
}

module peg_coupon(delta=0) {
  tile_h = RM_INSERT_DEPTH; // 3 mm flat tile
  difference() {
    union() {
      translate([-GRIP/2,-GRIP/2,0]) rounded_box([GRIP,GRIP,tile_h],2);
      translate([0,0,tile_h]) mount_peg(delta); // real male proud of face
    }
    translate([0,0,-RM_EPS]) cylinder(h=tile_h+RM_PORT_DEPTH+2*RM_EPS,
                                      d=RM_PEG_BORE);
  }
}

if(PART=="port") port_coupon();
if(PART=="peg_small") peg_coupon(-0.1);
if(PART=="peg_nominal") peg_coupon();
if(PART=="peg_large") peg_coupon(0.1);