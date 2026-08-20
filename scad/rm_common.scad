// RobotMind V1 mechanical standard. All dimensions are millimetres.
$fn = 48;

RM_UNIT = 40;
RM_PLATE_T = 16;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

// One carrier joint: a progressive hex press fit plus an optional M3 lock.
RM_SOCKET_DEPTH = 5;
RM_HEX_AF = 16;
RM_HEX_R = RM_HEX_AF/sqrt(3);
RM_HEX_TAPER = 0.28;
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

module rounded_box(size=[20,20,3], r=2, center=false) {
  x=size[0]; y=size[1]; z=size[2];
  translate(center ? [-x/2,-y/2,-z/2] : [0,0,0])
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
                   RM_SOCKET_DEPTH+0.1);
    translate([0,0,RM_PLATE_T-RM_SOCKET_DEPTH-RM_M3_BLIND_DEPTH])
      cylinder(h=RM_M3_BLIND_DEPTH+0.1,d=RM_M3_INSERT_HOLE,$fn=24);
  }
}

module bottom_socket_cut() {
  union() {
    translate([0,0,-0.1])
      hex_frustum(RM_HEX_R,
                   RM_HEX_R-RM_HEX_TAPER,
                   RM_SOCKET_DEPTH+0.1);
    translate([0,0,RM_SOCKET_DEPTH-0.1])
      cylinder(h=RM_M3_BLIND_DEPTH+0.1,d=RM_M3_INSERT_HOLE,$fn=24);
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
      translate([p-root_w/2,plate_half-0.05,0])
        cube([root_w,0.1,RM_PLATE_T]);
      translate([p-tip_w/2,plate_half+RM_JOIN_LENGTH-0.05,0])
        cube([tip_w,0.1,RM_PLATE_T]);
    }
}

// Selected tabs accept the same 5 mm M3 heat-set insert as carrier sockets.
module male_edge_insert_cuts(edge_len, plate_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    if(is_m3_join(p,edge_len))
      translate([p,plate_half+RM_JOIN_LENGTH+0.1,RM_PLATE_T/2])
        rotate([90,0,0])
          cylinder(h=RM_M3_INSERT_LENGTH+0.2,
                   d=RM_M3_INSERT_HOLE,$fn=24);
}

// Female B edge (-Y): open slots accept tabs from either face at 90°.
module female_edge_cuts(edge_len, plate_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2]) {
    translate([p-RM_JOIN_W/2,
               -plate_half-0.1,-0.1])
      cube([RM_JOIN_W,
            RM_PLATE_T+0.1,
            RM_JOIN_LENGTH+0.1]);
    translate([p-RM_JOIN_W/2,
               -plate_half-0.1,RM_PLATE_T-RM_JOIN_LENGTH])
      cube([RM_JOIN_W,
            RM_PLATE_T+0.1,
            RM_JOIN_LENGTH+0.1]);
    if(is_m3_join(p,edge_len)) {
      translate([p,-plate_half+RM_PLATE_T/2,-0.1])
        cylinder(h=RM_PLATE_T+0.2,d=RM_M3_CLEARANCE,$fn=24);
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
  translate([0,0,-RM_SOCKET_DEPTH+0.2])
    hex_frustum(RM_HEX_R-RM_HEX_TAPER-RM_HEX_ENTRY_CLEARANCE,
                 RM_HEX_R+RM_HEX_GRIP,
                 RM_SOCKET_DEPTH+0.1);
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
    translate([0,0,-0.01])
      cylinder(h=2.21,d=RM_M3_HEAD,$fn=32);
  }
}

module sensor_carrier(pcb=[20,20], wall=1.7, floor=1.8, clearance=0.5) {
  W=pcb[0]+2*(wall+clearance);
  L=pcb[1]+2*(wall+clearance);
  assert(W >= 2*(RM_HEX_R+RM_HEX_GRIP),
         "Carrier is narrower than its integral hex plug");
  carrier_mount() union() {
    translate([-W/2,-L/2,0]) difference() {
      rounded_box([W,L,floor+3.1],2);
      translate([wall,wall,floor])
        rounded_box([pcb[0]+2*clearance,pcb[1]+2*clearance,5],1);
      translate([W/2-6,-0.2,floor+0.5]) cube([12,wall+1,3.5]);
    }
    for(x=[-W/2+2.2,W/2-2.2], y=[-L/2+2.2,L/2-2.2])
      translate([x,y,floor+2.5]) cylinder(h=1.3,d=2.2);
  }
}

module tag_insert(tag=[60,60], border=3, t=1) {
  W=tag[0]+2*border; H=tag[1]+2*border;
  union() {
    translate([-W/2,-H/2,0]) rounded_box([W,H,t],1.2);
    translate([-8,-H/2-4,0]) rounded_box([16,5,t],1.2);
  }
}

module tag_insert_rails(tag=[60,60], border=4, rail=1.5,
                        depth=2.2, clearance=0.25, lip=0.8, lip_t=0.6) {
  W=tag[0]+2*border; H=tag[1]+2*border;
  for(sx=[-1,1]) {
    x=sx>0 ? W/2+clearance : -W/2-clearance-rail;
    translate([x,-H/2-clearance,0])
      cube([rail,H+2*clearance+rail,depth]);
    translate([sx>0 ? W/2-lip : -W/2-clearance-rail,
               -H/2-clearance,depth-lip_t])
      cube([rail+clearance+lip,H+2*clearance+rail,lip_t]);
  }
  translate([-W/2-clearance-rail,H/2+clearance,0])
    cube([W+2*(clearance+rail),rail,depth]);
}
