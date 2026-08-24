// RobotMind's sole interface: blind hex port, hollow hex peg, optional M3 lock.
$fn = 32;

RM_EPS = 0.1;
RM_FIT = 0; // positive loosens port, boss, peg, and heat-set pilot together
RM_PLATE = 80;
RM_GRID = 10;
RM_PLATE_T = 8;
RM_PORT_INSET = 5;
RM_PORT_COUNT = 8;
RM_PORT_OD = 8;
RM_PORT_DEPTH = 2.2;
RM_INSERT_BORE = 3.4; // pilot for a 4.0 mm-OD M3x3x4 heat-set insert
RM_INSERT_OD = 4.0;
RM_INSERT_DEPTH = 3;
RM_PORT_BOSS_D = 5.0;
RM_PEG_ENTRY = 0.2;
RM_PEG_GRIP = 0.2;
RM_PEG_BORE = RM_PORT_BOSS_D + 0.3; // clears the boss and seated insert
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_JOIN_T = 4;
RM_JOIN_L = RM_PLATE;
RM_SEAL_W = 3;
RM_SEAL_D = 0.9;
RM_JOIN_EDGE_MARGIN = 5;

function port_position(i) = -RM_PLATE/2 + RM_PORT_INSET + i*RM_GRID;
function port_indices() = [0:RM_PORT_COUNT-1];
function join_columns() = [for(i=port_indices()) port_position(i)];
function inner_join_rows() = [for(i=[0:1]) RM_PORT_INSET+i*RM_GRID];
function outer_join_rows() = [for(row=inner_join_rows()) RM_PLATE_T+row];
function join_leg(rows) = max(rows)+RM_PORT_OD/2+RM_JOIN_EDGE_MARGIN;
function port_od() = RM_PORT_OD+2*RM_FIT;
function insert_bore() = RM_INSERT_BORE+2*RM_FIT;
function port_boss_d() = RM_PORT_BOSS_D-2*RM_FIT;
function peg_root_od() = RM_PORT_OD+RM_PEG_GRIP-2*RM_FIT;
function peg_tip_od() = RM_PORT_OD-RM_PEG_ENTRY-2*RM_FIT;
function peg_bore() = RM_PEG_BORE+2*RM_FIT;

assert(RM_PLATE_T - 2*RM_INSERT_DEPTH >= 2,
       "Opposing blind insert bores need a centre membrane");
assert(RM_PLATE == 2*RM_PORT_INSET + (RM_PORT_COUNT-1)*RM_GRID,
       "The full plate grid must terminate at both edges");
assert(RM_FIT >= 0 && RM_FIT <= 0.2, "RM_FIT must stay within 0..0.20 mm");
assert(peg_root_od() > port_od() && port_od() > peg_tip_od(),
       "Peg needs a lead-in and final grip");
assert(RM_INSERT_OD > insert_bore(),
       "The heat-set insert needs deliberate melt-press interference");
assert(port_boss_d() > RM_INSERT_OD,
       "The insert needs a supporting centre boss");
assert(peg_bore() > port_boss_d(),
       "The peg must clear the centre boss");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module blind_port_cut() {
  difference() {
    translate([0,0,-RM_EPS])
      cylinder(h=RM_PORT_DEPTH+RM_EPS,d=port_od(),$fn=6);
    translate([0,0,-2*RM_EPS])
      cylinder(h=RM_PORT_DEPTH+3*RM_EPS,d=port_boss_d());
  }
  translate([0,0,-RM_EPS]) cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=insert_bore());
}

module plate_port_cuts(top=false) {
  for(x=port_indices(), y=port_indices())
    if(top)
      translate([port_position(x),port_position(y),RM_PLATE_T])
        mirror([0,0,1]) blind_port_cut();
    else
      translate([port_position(x),port_position(y),0]) blind_port_cut();
}

module plate_8x8() {
  difference() {
    translate([-RM_PLATE/2,-RM_PLATE/2,0])
      rounded_box([RM_PLATE,RM_PLATE,RM_PLATE_T],3);
    plate_port_cuts();
    plate_port_cuts(top=true);
  }
}

module mount_peg() {
  difference() {
    cylinder(h=RM_PORT_DEPTH,d1=peg_root_od(),d2=peg_tip_od(),$fn=6);
    translate([0,0,-RM_EPS]) cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=peg_bore());
  }
}

// Overlap the join body: face-to-face contact exports as disconnected shells.
module downward_peg() {
  translate([0,0,RM_EPS]) rotate([180,0,0]) mount_peg();
}

module forward_peg() {
  translate([0,-RM_EPS,0]) rotate([-90,0,0]) mount_peg();
}

module upward_peg() {
  translate([0,0,-RM_EPS]) mount_peg();
}

module backward_peg() {
  translate([0,RM_EPS,0]) rotate([90,0,0]) mount_peg();
}

module top_screw_cut() {
  translate([0,0,-RM_PORT_DEPTH-RM_EPS])
    cylinder(h=RM_JOIN_T+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,RM_JOIN_T-2]) cylinder(h=2+RM_EPS,d=RM_M3_HEAD_D);
}

module side_screw_cut() {
  translate([0,-RM_JOIN_T-RM_EPS,0]) rotate([-90,0,0])
    cylinder(h=RM_JOIN_T+RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,-RM_JOIN_T-RM_EPS,0]) rotate([-90,0,0])
    cylinder(h=2+RM_EPS,d=RM_M3_HEAD_D);
}

module bottom_screw_cut() {
  translate([0,0,-RM_JOIN_T-RM_EPS])
    cylinder(h=RM_JOIN_T+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,-RM_JOIN_T-RM_EPS]) cylinder(h=2+RM_EPS,d=RM_M3_HEAD_D);
}

module backward_screw_cut() {
  translate([0,RM_JOIN_T+RM_EPS,0]) rotate([90,0,0])
    cylinder(h=RM_JOIN_T+RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,RM_JOIN_T+RM_EPS,0]) rotate([90,0,0])
    cylinder(h=2+RM_EPS,d=RM_M3_HEAD_D);
}
