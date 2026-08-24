// RobotMind's sole interface: blind hex port, hollow hex peg, optional M3 lock.
$fn = 32;

RM_EPS = 0.1;
RM_PLATE = 80;
RM_GRID = 10;
RM_PLATE_T = 8;
RM_PORT_INSET = 5;
RM_PORT_OD = 8;
RM_PORT_DEPTH = 2.2;
RM_INSERT_BORE = 3.4; // pilot for a 4.0 mm-OD M3x3x4 heat-set insert
RM_INSERT_OD = 4.0;
RM_INSERT_DEPTH = 3;
RM_PEG_ENTRY = 0.2;
RM_PEG_GRIP = 0.2;
RM_PEG_BORE = 4.2;   // clears the seated insert
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_JOIN_T = 4;
RM_JOIN_L = RM_PLATE;

function port_position(i) = -RM_PLATE/2 + RM_PORT_INSET + i*RM_GRID;
function join_columns() = [-25,-5,5,25];
function peg_root_od() = RM_PORT_OD + RM_PEG_GRIP;
function peg_tip_od() = RM_PORT_OD - RM_PEG_ENTRY;

assert(RM_PLATE_T - 2*RM_INSERT_DEPTH >= 2,
       "Opposing blind insert bores need a centre membrane");
assert(peg_root_od() > RM_PORT_OD && RM_PORT_OD > peg_tip_od(),
       "Peg needs a lead-in and final grip");
assert(RM_INSERT_OD > RM_INSERT_BORE,
       "The heat-set insert needs deliberate melt-press interference");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module blind_port_cut() {
  translate([0,0,-RM_EPS]) cylinder(h=RM_PORT_DEPTH+RM_EPS,d=RM_PORT_OD,$fn=6);
  translate([0,0,-RM_EPS]) cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=RM_INSERT_BORE);
}

module plate_port_cuts(top=false) {
  for(x=[0:7], y=[0:7])
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
    translate([0,0,-RM_EPS]) cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=RM_PEG_BORE);
  }
}

// Overlap the join body: face-to-face contact exports as disconnected shells.
module downward_peg() {
  translate([0,0,RM_EPS]) rotate([180,0,0]) mount_peg();
}

module forward_peg() {
  translate([0,-RM_EPS,0]) rotate([-90,0,0]) mount_peg();
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
