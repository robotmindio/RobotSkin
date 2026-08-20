// RobotMind V1 mechanical standard. All dimensions are millimetres.
$fn = 48;

RM_EPS = 0.1; // overlap for reliable boolean cuts
RM_UNIT = 40;
RM_PLATE_T = 16;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

// One carrier joint: a progressive hex press fit plus an optional M3 lock.
RM_SOCKET_DEPTH = 5;
RM_HEX_AF = 16;
RM_HEX_R = RM_HEX_AF/sqrt(3);
RM_HEX_TAPER = 0.28;
RM_PLUG_OVERLAP = 0.2;
RM_HEX_ENTRY_CLEARANCE = 0.10+RM_FIT;
RM_HEX_GRIP = 0.20-RM_FIT;
RM_HEX_PITCH = 20;
RM_HEX_X = RM_HEX_PITCH;
RM_HEX_Y = sqrt(3)/2*RM_HEX_PITCH;

// Plate-to-plate 90° box joint: integral tabs enter open edge slots.
RM_JOIN_PITCH = 10;
RM_JOIN_LENGTH = 5;
RM_JOIN_W = 7;
RM_JOIN_ENTRY_CLEARANCE = 0.10+RM_FIT;
RM_JOIN_GRIP = 0.15-RM_FIT;
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD = 6.2;
RM_M3_HEAD_DEPTH = 2.2;
RM_M3_INSERT_HOLE = 4.0; // tune for the chosen M3 heat-set insert
RM_M3_INSERT_LENGTH = 5.0;
RM_M3_MEMBRANE = 0.3;
RM_M3_BLIND_DEPTH =
  (RM_PLATE_T-2*RM_SOCKET_DEPTH-RM_M3_MEMBRANE)/2;

assert(RM_PLATE_T > 2 * RM_SOCKET_DEPTH,
       "Plate needs a solid web between its two carrier sockets");
assert(RM_HEX_ENTRY_CLEARANCE >= 0 && RM_HEX_GRIP > 0 &&
       RM_JOIN_ENTRY_CLEARANCE >= 0 && RM_JOIN_GRIP > 0,
       "RM_FIT is outside the printable range");
assert(RM_M3_BLIND_DEPTH > 0,
       "Plate is too thin for double-sided M3 insert pockets");
assert(2*RM_M3_BLIND_DEPTH+RM_M3_MEMBRANE >= RM_M3_INSERT_LENGTH,
       "Plate web is too thin for the M3 insert");

module rounded_box(size=[20,20,3], r=2) {
  x=size[0]; y=size[1]; z=size[2];
  linear_extrude(height=z)
    offset(r=r) offset(delta=-r) square([x,y]);
}

module print_on_x_edge(span) {
  translate([0,0,span/2]) rotate([0,90,0]) children();
}

module print_on_y_edge(span) {
  translate([0,0,span/2]) rotate([90,0,0]) children();
}

module hex_frustum(r1=RM_HEX_R, r2=RM_HEX_R, h=1) {
  rotate([0,0,30]) cylinder(r1=r1,r2=r2,h=h,$fn=6);
}

module top_socket_cut() {
  union() {
    translate([0,0,RM_PLATE_T-RM_SOCKET_DEPTH])
      hex_frustum(RM_HEX_R-RM_HEX_TAPER,
                   RM_HEX_R,
                   RM_SOCKET_DEPTH+RM_EPS);
    translate([0,0,RM_PLATE_T-RM_SOCKET_DEPTH-RM_M3_BLIND_DEPTH])
      cylinder(h=RM_M3_BLIND_DEPTH+RM_EPS,
               d=RM_M3_INSERT_HOLE,$fn=24);
  }
}

module bottom_socket_cut() {
  union() {
    translate([0,0,-RM_EPS])
      hex_frustum(RM_HEX_R,
                   RM_HEX_R-RM_HEX_TAPER,
                   RM_SOCKET_DEPTH+RM_EPS);
    translate([0,0,RM_SOCKET_DEPTH-RM_EPS])
      cylinder(h=RM_M3_BLIND_DEPTH+RM_EPS,
               d=RM_M3_INSERT_HOLE,$fn=24);
  }
}

module socket_pair() {
  top_socket_cut();
  bottom_socket_cut();
}

// Triangular lattice. Female edges reserve enough material for corner slots;
// the 5.5 mm origin shift keeps the 20 mm pitch and centers the usable area.
module dense_socket_grid(size=[2*RM_UNIT,2*RM_UNIT]) {
  rows=ceil(size[1]/RM_HEX_Y)+2;
  cols=ceil(size[0]/RM_HEX_X)+2;
  female_margin=RM_PLATE_T+1;
  male_margin=2;
  origin=(female_margin-male_margin)/2;
  for(row=[-rows:rows], col=[-cols:cols]) {
    y=origin+row*RM_HEX_Y;
    x=origin+(col + ((abs(row)%2)==1 ? 0.5 : 0))*RM_HEX_X;
    if(x-RM_HEX_AF/2 >= -size[0]/2+female_margin &&
       x+RM_HEX_AF/2 <= size[0]/2-male_margin &&
       y-RM_HEX_R >= -size[1]/2+female_margin &&
       y+RM_HEX_R <= size[1]/2-male_margin)
      translate([x,y,0]) socket_pair();
  }
}

function join_index(p,edge_len) =
  round((p+edge_len/2-RM_JOIN_PITCH/2)/RM_JOIN_PITCH);
function is_m3_join(p,edge_len) = join_index(p,edge_len)%4 == 1;

// Progressive tabs: a loose tip guides insertion and the root wedges firmly.
module male_edge(edge_len, plate_half) {
  root_w=RM_JOIN_W+2*RM_JOIN_GRIP;
  tip_w=RM_JOIN_W-2*RM_JOIN_ENTRY_CLEARANCE;
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    hull() {
      translate([p-root_w/2,plate_half-RM_EPS/2,0])
        cube([root_w,RM_EPS,RM_PLATE_T]);
      translate([p-tip_w/2,plate_half+RM_JOIN_LENGTH-RM_EPS/2,0])
        cube([tip_w,RM_EPS,RM_PLATE_T]);
    }
}

// Selected tabs accept the same 5 mm M3 heat-set insert as carrier sockets.
module male_edge_insert_cuts(edge_len, plate_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    if(is_m3_join(p,edge_len))
      translate([p,plate_half+RM_JOIN_LENGTH+RM_EPS,RM_PLATE_T/2])
        rotate([90,0,0])
          cylinder(h=RM_M3_INSERT_LENGTH+2*RM_EPS,
                   d=RM_M3_INSERT_HOLE,$fn=24);
}

// Female B edge (-Y): open slots accept tabs from either face at 90°.
module female_edge_cuts(edge_len, plate_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2]) {
    translate([p-RM_JOIN_W/2,
               -plate_half-RM_EPS,-RM_EPS])
      cube([RM_JOIN_W,
            RM_PLATE_T+RM_EPS,
            RM_JOIN_LENGTH+RM_EPS]);
    translate([p-RM_JOIN_W/2,
               -plate_half-RM_EPS,RM_PLATE_T-RM_JOIN_LENGTH])
      cube([RM_JOIN_W,
            RM_PLATE_T+RM_EPS,
            RM_JOIN_LENGTH+RM_EPS]);
    if(is_m3_join(p,edge_len)) {
      translate([p,-plate_half+RM_PLATE_T/2,-RM_EPS])
        cylinder(h=RM_PLATE_T+2*RM_EPS,d=RM_M3_CLEARANCE,$fn=24);
    }
  }
}

// Identical plates: tabs on +X/+Y and 90° slots on -X/-Y.
module plate(size=[2*RM_UNIT,2*RM_UNIT]) {
  assert(size[0] % RM_UNIT == 0 && size[1] % RM_UNIT == 0,
         "Plate dimensions must be whole 40 mm units");
  difference() {
    union() {
      translate([-size[0]/2,-size[1]/2,0])
        rounded_box([size[0],size[1],RM_PLATE_T],1.5);
      male_edge(size[0],size[1]/2);
      rotate([0,0,-90]) male_edge(size[1],size[0]/2);
    }
    dense_socket_grid(size);
    female_edge_cuts(size[0],size[1]/2);
    rotate([0,0,-90]) female_edge_cuts(size[1],size[0]/2);
    male_edge_insert_cuts(size[0],size[1]/2);
    rotate([0,0,-90]) male_edge_insert_cuts(size[1],size[0]/2);
  }
}

// The tip enters freely; the last fraction of travel supplies the grip.
module integral_hex_plug() {
  translate([0,0,-RM_SOCKET_DEPTH+RM_PLUG_OVERLAP])
    hex_frustum(RM_HEX_R-RM_HEX_TAPER-RM_HEX_ENTRY_CLEARANCE,
                 RM_HEX_R+RM_HEX_GRIP,
                 RM_SOCKET_DEPTH+RM_EPS);
}

// Adds the universal plug. M3 is optional: the press fit works alone.
module carrier_mount() {
  difference() {
    union() {
      children();
      integral_hex_plug();
    }
    translate([0,0,-RM_SOCKET_DEPTH])
      cylinder(h=RM_SOCKET_DEPTH+100,d=RM_M3_CLEARANCE,$fn=24);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD,$fn=32);
  }
}
