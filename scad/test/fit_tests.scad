// Fit coupons as minimal (20x20 mm) flat square system tiles.
// Port coupon: one real blind port + insert seat in the tile face.
// Peg coupon: the real integral male proud of the tile face, with the
// full-depth centre bore so an M3 screw passes the whole tile.
// Each tile carries an engraved letter mark so the four are identifiable.
include <../source/rm_common.scad>

PART="port"; // port, peg_small, peg_nominal or peg_large
assert(PART=="port" || PART=="peg_small" || PART=="peg_nominal" ||
       PART=="peg_large", "Unknown fit-test part");

GRIP = 20; // 20x20 mm square tile
MARK_DEPTH = 0.8; // engraved stroke depth

// Letter engraved from the top face, offset to one side so it clears the
// centre port or peg. Lazy geometry: cut an extruded text 0.4 mm above the
// face so the stroke never z-fights with it.
module engraved_mark(letter, face_z) {
  translate([7,0,face_z-MARK_DEPTH+0.4])
    linear_extrude(height=MARK_DEPTH+0.4)
      text(letter, size=6, halign="center", valign="center");
}

module port_coupon() {
  TILE=RM_INSERT_DEPTH+2; // 5 mm
  difference() {
    rounded_panel(size=[GRIP,GRIP], t=TILE);
    blind_port_cut();
    translate([0,0,-RM_EPS]) cylinder(h=TILE+2*RM_EPS, d=RM_INSERT_BORE);
    engraved_mark("P", TILE);
  }
}

module peg_coupon(delta=0, letter="N") {
  tile_h = RM_INSERT_DEPTH; // 3 mm flat tile
  difference() {
    union() {
      translate([-GRIP/2,-GRIP/2,0]) rounded_box([GRIP,GRIP,tile_h],2);
      translate([0,0,tile_h]) mount_peg(delta); // real male proud of face
    }
    translate([0,0,-RM_EPS]) cylinder(h=tile_h+RM_PORT_DEPTH+2*RM_EPS,
                                      d=RM_PEG_BORE);
    engraved_mark(letter, tile_h);
  }
}

if(PART=="port") port_coupon();
if(PART=="peg_small") peg_coupon(-0.1,"S");
if(PART=="peg_nominal") peg_coupon(0,"N");
if(PART=="peg_large") peg_coupon(0.1,"L");