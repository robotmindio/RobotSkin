// RobotMind V2 mechanical standard. All dimensions are millimetres.
$fn = 48;

RM_EPS = 0.1; // overlap for reliable boolean cuts
RM_UNIT = 40;
RM_PLATE_T = 12;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

// One carrier joint: a progressive hex press fit plus an optional M3 lock.
RM_SOCKET_DEPTH = 4;
RM_SOCKET_WALL = 1.8;
RM_HEX_AF = 16;
RM_HEX_R = RM_HEX_AF/sqrt(3);
RM_HEX_TAPER = 0.28;
RM_PLUG_OVERLAP = 0.2;
RM_HEX_ENTRY_CLEARANCE = 0.10+RM_FIT;
RM_HEX_GRIP = 0.20-RM_FIT;
RM_HEX_PITCH = 20;
RM_HEX_X = RM_HEX_PITCH;
RM_HEX_Y = sqrt(3)/2*RM_HEX_PITCH;

// One hermaphroditic box edge. Its square engagement envelope means the same
// tongue and notch mate coplanar or after a 90 degree rotation.
RM_JOIN_BAY = 20;
RM_JOIN_LENGTH = RM_PLATE_T;
RM_JOIN_W = 7;
RM_JOIN_ENTRY_CLEARANCE = 0.15+RM_FIT;
RM_JOIN_GRIP = 0.10-RM_FIT;
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD = 6.2;
RM_M3_HEAD_DEPTH = 2.2;
RM_M3_INSERT_HOLE = 4.0; // tune for the chosen M3 heat-set insert
RM_M3_INSERT_LENGTH = 4.0;
RM_SOCKET_WEB = RM_PLATE_T-2*RM_SOCKET_DEPTH;
RM_MOLD_SKIN = 2.0;
RM_MOLD_RIB = 1.5;
RM_MOLD_RIM = 2.4;

assert(RM_HEX_ENTRY_CLEARANCE >= 0 && RM_HEX_GRIP > 0 &&
       RM_JOIN_ENTRY_CLEARANCE >= 0 && RM_JOIN_GRIP > 0,
       "RM_FIT is outside the printable range");
assert(RM_SOCKET_WEB >= RM_M3_INSERT_LENGTH,
       "The plate needs enough central web for the M3 insert");
assert(RM_JOIN_LENGTH == RM_PLATE_T,
       "The 0/90 joint requires square depth and plate thickness");
assert((RM_UNIT/RM_JOIN_BAY)%2 == 0,
       "Each 40 mm unit needs complementary tongue/notch pairs");
assert(RM_MOLD_SKIN < RM_PLATE_T/2 && RM_MOLD_RIB < RM_MOLD_SKIN,
       "Injection walls must fit inside each shell");

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
    translate([0,0,RM_PLATE_T-RM_SOCKET_DEPTH-RM_M3_INSERT_LENGTH])
      cylinder(h=RM_M3_INSERT_LENGTH+RM_EPS,
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
      cylinder(h=RM_M3_INSERT_LENGTH+RM_EPS,
               d=RM_M3_INSERT_HOLE,$fn=24);
  }
}

module socket_pair() {
  top_socket_cut();
  bottom_socket_cut();
}

module socket_boss() {
  hex_frustum(RM_HEX_R+RM_SOCKET_WALL,
              RM_HEX_R+RM_SOCKET_WALL,
              RM_PLATE_T);
}

module dense_socket_positions(size=[2*RM_UNIT,2*RM_UNIT]) {
  rows=ceil(size[1]/RM_HEX_Y)+2;
  cols=ceil(size[0]/RM_HEX_X)+2;
  edge_margin=RM_JOIN_LENGTH;
  for(row=[-rows:rows], col=[-cols:cols]) {
    y=row*RM_HEX_Y;
    x=(col + ((abs(row)%2)==1 ? 0.5 : 0))*RM_HEX_X;
    if(x-RM_HEX_AF/2 >= -size[0]/2+edge_margin &&
       x+RM_HEX_AF/2 <= size[0]/2-edge_margin &&
       y-RM_HEX_R >= -size[1]/2+edge_margin &&
       y+RM_HEX_R <= size[1]/2-edge_margin)
      translate([x,y,0]) children();
  }
}

module dense_socket_grid(size=[2*RM_UNIT,2*RM_UNIT]) {
  dense_socket_positions(size) socket_pair();
}

module dense_socket_bosses(size=[2*RM_UNIT,2*RM_UNIT]) {
  dense_socket_positions(size) socket_boss();
}

function join_position(i,edge_len) =
  -edge_len/2+RM_JOIN_BAY/2+i*RM_JOIN_BAY;
function join_bays(edge_len) = round(edge_len/RM_JOIN_BAY);
function is_join_tongue(i) = i%2 == 0;

// Loose tips guide insertion; the final travel wedges only across the edge.
module uniform_edge_tongues(edge_len, plate_half) {
  root_w=RM_JOIN_W+2*RM_JOIN_GRIP;
  tip_w=RM_JOIN_W-2*RM_JOIN_ENTRY_CLEARANCE;
  for(i=[0:join_bays(edge_len)-1])
    if(is_join_tongue(i))
      hull() {
        translate([join_position(i,edge_len)-root_w/2,
                   plate_half-RM_EPS/2,
                   0])
          cube([root_w,RM_EPS,RM_PLATE_T]);
        translate([join_position(i,edge_len)-tip_w/2,
                   plate_half+RM_JOIN_LENGTH-RM_EPS/2,
                   0])
          cube([tip_w,RM_EPS,RM_PLATE_T]);
      }
}

// The exposed tongue face accepts an M3 insert from either plate face. A
// standard 9 mm washer bridges the notch when permanent locking is wanted.
module uniform_edge_insert_cuts(edge_len, plate_half) {
  for(i=[0:join_bays(edge_len)-1])
    if(is_join_tongue(i)) {
      p=join_position(i,edge_len);
      translate([p,plate_half+RM_JOIN_LENGTH/2,-RM_EPS])
        cylinder(h=RM_M3_INSERT_LENGTH+RM_EPS,
                 d=RM_M3_INSERT_HOLE,$fn=24);
      translate([p,plate_half+RM_JOIN_LENGTH/2,
                 RM_PLATE_T-RM_M3_INSERT_LENGTH])
        cylinder(h=RM_M3_INSERT_LENGTH+RM_EPS,
                 d=RM_M3_INSERT_HOLE,$fn=24);
    }
}

// A single open cuboid accepts the square tongue from the edge or either face.
module uniform_edge_socket_cuts(edge_len, plate_half) {
  for(i=[0:join_bays(edge_len)-1])
    if(!is_join_tongue(i)) {
      p=join_position(i,edge_len);
      translate([p-RM_JOIN_W/2,
                 plate_half-RM_JOIN_LENGTH,
                 -RM_EPS])
        cube([RM_JOIN_W,RM_JOIN_LENGTH+RM_EPS,
              RM_PLATE_T+2*RM_EPS]);
    }
}

module plate_edge_tongues(size) {
  for(a=[0:90:270])
    rotate([0,0,a])
      uniform_edge_tongues(a%180==0 ? size[0] : size[1],
                           a%180==0 ? size[1]/2 : size[0]/2);
}

module plate_edge_cuts(size) {
  for(a=[0:90:270])
    rotate([0,0,a]) {
      edge_len=a%180==0 ? size[0] : size[1];
      plate_half=a%180==0 ? size[1]/2 : size[0]/2;
      uniform_edge_socket_cuts(edge_len,plate_half);
      uniform_edge_insert_cuts(edge_len,plate_half);
    }
}

module plate_raw(size) {
  union() {
    translate([-size[0]/2,-size[1]/2,0])
      rounded_box([size[0],size[1],RM_PLATE_T],1.5);
    plate_edge_tongues(size);
    dense_socket_bosses(size);
  }
}

module plate_interface_cuts(size) {
  dense_socket_grid(size);
  plate_edge_cuts(size);
}

// FDM model: a closed solid lets the slicer choose the internal structure.
module plate(size=[2*RM_UNIT,2*RM_UNIT]) {
  assert(size[0] % RM_UNIT == 0 && size[1] % RM_UNIT == 0,
         "Plate dimensions must be whole 40 mm units");
  difference() {
    plate_raw(size);
    plate_interface_cuts(size);
  }
}

module molded_rim(size) {
  difference() {
    translate([-size[0]/2,-size[1]/2,0])
      rounded_box([size[0],size[1],RM_PLATE_T],1.5);
    translate([-size[0]/2+RM_MOLD_RIM,
               -size[1]/2+RM_MOLD_RIM,-RM_EPS])
      rounded_box([size[0]-2*RM_MOLD_RIM,
                   size[1]-2*RM_MOLD_RIM,
                   RM_PLATE_T+2*RM_EPS],1);
  }
}

module molded_ribs(size) {
  intersection() {
    union()
      dense_socket_positions(size)
        for(a=[0,60,120])
          rotate([0,0,a])
            translate([-RM_HEX_PITCH, -RM_MOLD_RIB/2,0])
              cube([2*RM_HEX_PITCH,RM_MOLD_RIB,RM_PLATE_T]);
    translate([-size[0]/2,-size[1]/2,0])
      rounded_box([size[0],size[1],RM_PLATE_T],1.5);
  }
}

module lower_mold_shell_raw(size) {
  half=RM_PLATE_T/2;
  union() {
    translate([-size[0]/2,-size[1]/2,0])
      rounded_box([size[0],size[1],RM_MOLD_SKIN],1.5);
    intersection() {
      molded_rim(size);
      translate([-size[0],-size[1],0])
        cube([2*size[0],2*size[1],half]);
    }
    intersection() {
      molded_ribs(size);
      translate([-size[0],-size[1],0])
        cube([2*size[0],2*size[1],half]);
    }
    intersection() {
      plate_edge_tongues(size);
      translate([-size[0],-size[1],0])
        cube([2*size[0],2*size[1],half]);
    }
    intersection() {
      dense_socket_bosses(size);
      translate([-size[0],-size[1],0])
        cube([2*size[0],2*size[1],half]);
    }
  }
}

// Complementary injection shells preserve smooth faces while removing the
// thick internal mass. Both use a straight Z pull; tooling supplies draft.
module injection_shell_a(size=[2*RM_UNIT,2*RM_UNIT]) {
  assert(size[0] % RM_UNIT == 0 && size[1] % RM_UNIT == 0,
         "Plate dimensions must be whole 40 mm units");
  difference() {
    lower_mold_shell_raw(size);
    plate_interface_cuts(size);
  }
}

module injection_shell_b(size=[2*RM_UNIT,2*RM_UNIT]) {
  translate([0,0,RM_PLATE_T]) mirror([0,0,1])
    injection_shell_a(size);
}

module injection_plate_assembly(size=[2*RM_UNIT,2*RM_UNIT]) {
  injection_shell_a(size);
  injection_shell_b(size);
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
