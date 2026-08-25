// RobotMind canonical model: dimensions, interface, and every part definition.
$fn = 32;

RM_EPS = 0.1;
RM_FIT = 0; // positive loosens port, boss, peg, and heat-set pilot together
RM_PLATE = 80;
RM_GRID = 10;
RM_PLATE_T = 8;
RM_PORT_INSET = 5;
RM_PORT_COUNT = 8;
RM_PORT_AF = 8;
RM_PORT_DEPTH = 2.2;
RM_INSERT_BORE = 3.7; // pilot for a 4.0 mm-OD M3x3x4 heat-set insert
RM_INSERT_OD = 4.0;
RM_INSERT_DEPTH = 3;
RM_INSERT_LEAD = 0.6;
RM_PORT_BOSS_AF = 6.2;
RM_PEG_ENTRY = 0.3;
RM_PEG_GRIP = 0.3;
RM_PEG_BORE = RM_PORT_BOSS_AF + 0.4; // clears the boss and seated insert
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_JOIN_T = 4;
RM_JOIN_L = RM_PLATE;
RM_SEAL_W = 3;
RM_SEAL_D = 0.9;
RM_JOIN_EDGE_MARGIN = 5;
RM_JOIN_RAIL_W = 4;
RM_JOIN_PAD_AF = 8.8;

function port_position(i) = -RM_PLATE/2 + RM_PORT_INSET + i*RM_GRID;
function port_indices() = [0:RM_PORT_COUNT-1];
function join_columns() = [for(i=port_indices()) port_position(i)];
function inner_join_rows() = [for(i=[0:1]) RM_PORT_INSET+i*RM_GRID];
function outer_join_rows() = [for(row=inner_join_rows()) RM_PLATE_T+row];
function octagon_d(af) = af/cos(22.5);
function join_leg(rows) = max(rows)+octagon_d(peg_root_af())/2+RM_JOIN_EDGE_MARGIN;
function port_af() = RM_PORT_AF+2*RM_FIT;
function insert_bore() = RM_INSERT_BORE+RM_FIT;
function port_boss_af() = RM_PORT_BOSS_AF-2*RM_FIT;
function peg_root_af() = RM_PORT_AF+RM_PEG_GRIP-2*RM_FIT;
function peg_tip_af() = RM_PORT_AF-RM_PEG_ENTRY-2*RM_FIT;
function peg_bore() = RM_PEG_BORE+2*RM_FIT;

assert(RM_PLATE_T - 2*RM_INSERT_DEPTH >= 2,
       "Opposing blind insert bores need a centre membrane");
assert(RM_PLATE == 2*RM_PORT_INSET + (RM_PORT_COUNT-1)*RM_GRID,
       "The full plate grid must terminate at both edges");
assert(RM_FIT >= 0 && RM_FIT <= 0.15, "RM_FIT must stay within 0..0.15 mm");
assert(peg_root_af() > port_af() && port_af() > peg_tip_af(),
       "Peg needs a lead-in and final grip");
assert(RM_INSERT_OD > insert_bore(),
       "The heat-set insert needs deliberate melt-press interference");
assert(port_boss_af() > RM_INSERT_OD,
       "The insert needs a supporting centre boss");
assert(peg_bore() > port_boss_af(),
       "The peg must clear the centre boss");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module octagonal_prism(h, af) {
  cylinder(h=h,d=octagon_d(af),$fn=8);
}

module blind_port_cut() {
  difference() {
    translate([0,0,-RM_EPS])
      octagonal_prism(RM_PORT_DEPTH+RM_EPS,port_af());
    translate([0,0,-2*RM_EPS])
      octagonal_prism(RM_PORT_DEPTH+3*RM_EPS,port_boss_af());
  }
  translate([0,0,-RM_EPS]) cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=insert_bore());
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_LEAD+RM_EPS,d1=RM_INSERT_OD+0.3,d2=insert_bore());
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
    cylinder(h=RM_PORT_DEPTH,d1=octagon_d(peg_root_af()),d2=octagon_d(peg_tip_af()),$fn=8);
    translate([0,0,-RM_EPS]) cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=peg_bore());
  }
}

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

// Repeated octagonal lock stations keep every join visually and structurally consistent.
module join_ladder(rows, min_row, max_row) {
  for(row=rows)
    translate([-RM_JOIN_L/2,row-RM_JOIN_RAIL_W/2,0])
      rounded_box([RM_JOIN_L,RM_JOIN_RAIL_W,RM_JOIN_T],RM_JOIN_RAIL_W/2);
  for(x=join_columns(), row=rows)
    translate([x,row,0]) octagonal_prism(RM_JOIN_T,RM_JOIN_PAD_AF);
  for(x=[-RM_JOIN_L/2+RM_JOIN_RAIL_W/2,0,RM_JOIN_L/2-RM_JOIN_RAIL_W/2])
    translate([x-RM_JOIN_RAIL_W/2,min_row,0])
      rounded_box([RM_JOIN_RAIL_W,max_row-min_row,RM_JOIN_T],RM_JOIN_RAIL_W/2);
}

module flat_join() {
  rows = inner_join_rows();
  peg_rows = concat([-rows[0],-rows[1]],rows);
  leg = join_leg(rows);
  difference() {
    union() {
      join_ladder(peg_rows,-leg,leg);
      for(x=join_columns(), y=peg_rows)
        translate([x,y,0]) downward_peg();
    }
    for(x=join_columns(), y=peg_rows)
      translate([x,y,0]) top_screw_cut();
    translate([-RM_JOIN_L/2,-RM_SEAL_W/2,-RM_EPS])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
  }
}

module angle_join() {
  rows = inner_join_rows();
  leg = join_leg(rows);
  difference() {
    union() {
      join_ladder([for(row=rows) -row],-leg,0);
      rotate([90,0,0]) join_ladder(rows,0,leg);
      for(x=join_columns(), y=[for(row=rows) -row])
        translate([x,y,0]) downward_peg();
      for(x=join_columns(), z=rows)
        translate([x,0,z]) forward_peg();
    }
    for(x=join_columns(), y=[for(row=rows) -row]) translate([x,y,0]) top_screw_cut();
    for(x=join_columns(), z=rows)
      translate([x,0,z]) side_screw_cut();
    translate([-RM_JOIN_L/2,-RM_SEAL_W/2,-RM_EPS])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_JOIN_T-RM_EPS,-1.5])
      cube([RM_JOIN_L,RM_SEAL_D+RM_EPS,RM_SEAL_W]);
  }
}

module outer_angle_join() {
  rows = outer_join_rows();
  leg = join_leg(rows);
  difference() {
    union() {
      translate([0,0,-RM_JOIN_T]) join_ladder([for(row=rows) -row],-leg,0);
      translate([0,RM_JOIN_T,0]) rotate([90,0,0]) join_ladder(rows,0,leg);
      for(x=join_columns(), y=[for(row=rows) -row])
        translate([x,y,0]) upward_peg();
      for(x=join_columns(), z=rows)
        translate([x,0,z]) backward_peg();
    }
    for(x=join_columns(), y=[for(row=rows) -row])
      translate([x,y,0]) bottom_screw_cut();
    for(x=join_columns(), z=rows)
      translate([x,0,z]) backward_screw_cut();
    translate([-RM_JOIN_L/2,-RM_PLATE_T-RM_SEAL_W/2,-RM_SEAL_D])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_EPS,RM_PLATE_T-RM_SEAL_W/2])
      cube([RM_JOIN_L,RM_SEAL_D+RM_EPS,RM_SEAL_W]);
  }
}

module grove_plaque() {
  difference() {
    union() {
      translate([-14,-14,0]) rounded_box([28,28,3],3);
      for(x=[-5,5]) translate([x,0,0]) downward_peg();
    }
    for(x=[-5,5]) translate([x,0,0]) top_screw_cut();
    for(x=[-8,8], y=[-8,8])
      translate([x,y,-RM_EPS]) linear_extrude(height=3+2*RM_EPS) hull() {
          translate([0,-2]) circle(d=2.8);
          translate([0,2]) circle(d=2.8);
        }
  }
}
