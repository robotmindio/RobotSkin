// RobotMind canonical model: dimensions, interface, and every part definition.
$fn = 32;

RM_EPS = 0.1;
RM_PORT_FIT = 0; // positive loosens the female port and insert pilot
RM_PEG_FIT = 0; // positive loosens the male peg; select this from the coupon
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
RM_INSERT_ENTRY_CLEARANCE = 0.3;
RM_PORT_BOSS_AF = 6.2;
RM_PEG_ENTRY = 0.3;
RM_PEG_GRIP = 0.3;
RM_PEG_BORE = RM_PORT_BOSS_AF + 0.4; // clears the boss and seated insert
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_M3_HEAD_DEPTH = 2;
RM_LOCK_SCREW_LENGTH = 7;
RM_PLATE_R = 3;
RM_JOIN_T = 4;
RM_JOIN_L = RM_PLATE;
RM_SEAL_W = 3;
RM_SEAL_D = 0.9;
RM_JOIN_EDGE_MARGIN = 1.5;
RM_JOIN_PANEL_R = 3;
RM_PLAQUE_SIZE = 28;
RM_PLAQUE_T = 3;
RM_PLAQUE_R = 3;
RM_PLAQUE_PEG_X = 5;
RM_PLAQUE_SLOT_XY = 8;
RM_PLAQUE_SLOT_LENGTH = 4;
RM_PLAQUE_SLOT_D = 2.8;
RM_TEST_MALE_FITS = [-0.10,-0.05,0,0.05,0.10];
RM_TEST_PAD_SIZE = 12;
RM_TEST_PAD_T = RM_JOIN_T;
RM_TEST_PAD_R = 2;
RM_TEST_PAD_PITCH = 14;
RM_TEST_TILE_SIZE = 2*RM_GRID;
RM_TEST_TILE_T = RM_PLATE_T;
RM_TEST_TILE_R = 2;

function port_position(i) = -RM_PLATE/2 + RM_PORT_INSET + i*RM_GRID;
function port_indices() = [0:RM_PORT_COUNT-1];
function join_columns() = [for(i=port_indices()) port_position(i)];
function inner_join_rows() = [for(i=[0:1]) RM_PORT_INSET+i*RM_GRID];
function outer_join_rows() = [for(row=inner_join_rows()) RM_PLATE_T+row];
function flat_peg_rows() = concat([for(row=inner_join_rows()) -row],inner_join_rows());
function inner_floor_rows() = inner_join_rows();
function inner_wall_rows() = outer_join_rows();
function outer_floor_rows() = outer_join_rows();
function outer_wall_rows() = outer_join_rows();
function octagon_d(af) = af/cos(22.5);
function join_leg(rows) = max(rows)+octagon_d(peg_root_af())/2+RM_JOIN_EDGE_MARGIN;
function port_af(fit=RM_PORT_FIT) = RM_PORT_AF+2*fit;
function insert_bore(fit=RM_PORT_FIT) = RM_INSERT_BORE+fit;
function port_boss_af(fit=RM_PORT_FIT) = RM_PORT_BOSS_AF-2*fit;
function peg_root_af(fit=RM_PEG_FIT) = RM_PORT_AF+RM_PEG_GRIP-2*fit;
function peg_tip_af(fit=RM_PEG_FIT) = RM_PORT_AF-RM_PEG_ENTRY-2*fit;
function peg_bore(fit=RM_PEG_FIT) = RM_PEG_BORE+2*fit;
function test_male_x(i) = (i-(len(RM_TEST_MALE_FITS)-1)/2)*RM_TEST_PAD_PITCH;
function test_tile_positions() = [-RM_GRID/2,RM_GRID/2];

assert(RM_PLATE_T - 2*RM_INSERT_DEPTH >= 2,
       "Opposing blind insert bores need a centre membrane");
assert(RM_PLATE == 2*RM_PORT_INSET + (RM_PORT_COUNT-1)*RM_GRID,
       "The full plate grid must terminate at both edges");
assert(RM_PORT_FIT >= 0 && RM_PORT_FIT <= 0.15,
       "RM_PORT_FIT must stay within 0..0.15 mm");
assert(RM_PEG_FIT >= 0 && RM_PEG_FIT <= 0.10,
       "RM_PEG_FIT must stay within 0..0.10 mm");
assert(peg_root_af() > port_af() && port_af() > peg_tip_af(),
       "Peg needs a lead-in and final grip");
assert(RM_INSERT_OD > insert_bore(),
       "The heat-set insert needs deliberate melt-press interference");
assert(port_boss_af() > RM_INSERT_OD,
       "The insert needs a supporting centre boss");
assert(peg_bore() > port_boss_af(),
       "The peg must clear the centre boss");
assert(RM_PLAQUE_T >= RM_M3_HEAD_DEPTH,
       "The plaque must fully recess the specified screw head");

module rounded_box(size, r) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module octagonal_prism(h, af) {
  cylinder(h=h,d=octagon_d(af),$fn=8);
}

module blind_port_cut(fit=RM_PORT_FIT) {
  difference() {
    translate([0,0,-RM_EPS])
      octagonal_prism(RM_PORT_DEPTH+RM_EPS,port_af(fit));
    translate([0,0,-2*RM_EPS])
      octagonal_prism(RM_PORT_DEPTH+3*RM_EPS,port_boss_af(fit));
  }
  translate([0,0,-RM_EPS]) cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=insert_bore(fit));
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_LEAD+RM_EPS,
             d1=RM_INSERT_OD+RM_INSERT_ENTRY_CLEARANCE,d2=insert_bore(fit));
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
      rounded_box([RM_PLATE,RM_PLATE,RM_PLATE_T],RM_PLATE_R);
    plate_port_cuts();
    plate_port_cuts(top=true);
  }
}

module mount_peg(fit=RM_PEG_FIT) {
  difference() {
    cylinder(h=RM_PORT_DEPTH,d1=octagon_d(peg_root_af(fit)),d2=octagon_d(peg_tip_af(fit)),$fn=8);
    translate([0,0,-RM_EPS]) cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=peg_bore(fit));
  }
}

module downward_peg(fit=RM_PEG_FIT) {
  translate([0,0,RM_EPS]) rotate([180,0,0]) mount_peg(fit);
}

module forward_peg(fit=RM_PEG_FIT) {
  translate([0,-RM_EPS,0]) rotate([-90,0,0]) mount_peg(fit);
}

module upward_peg(fit=RM_PEG_FIT) {
  translate([0,0,-RM_EPS]) mount_peg(fit);
}

module backward_peg(fit=RM_PEG_FIT) {
  translate([0,RM_EPS,0]) rotate([90,0,0]) mount_peg(fit);
}

module top_screw_cut(body_t=RM_JOIN_T) {
  translate([0,0,-RM_PORT_DEPTH-RM_EPS])
    cylinder(h=body_t+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,body_t-RM_M3_HEAD_DEPTH])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

module side_screw_cut() {
  translate([0,-RM_JOIN_T-RM_EPS,0]) rotate([-90,0,0])
    cylinder(h=RM_JOIN_T+RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,-RM_JOIN_T-RM_EPS,0]) rotate([-90,0,0])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

module bottom_screw_cut() {
  translate([0,0,-RM_JOIN_T-RM_EPS])
    cylinder(h=RM_JOIN_T+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,-RM_JOIN_T-RM_EPS])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

module backward_screw_cut() {
  translate([0,RM_JOIN_T+RM_EPS,0]) rotate([90,0,0])
    cylinder(h=RM_JOIN_T+RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,RM_JOIN_T+RM_EPS,0]) rotate([90,0,0])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

// One continuous panel joins every lock station and retains the silicone bead.
module join_panel(min_row, max_row) {
  translate([-RM_JOIN_L/2,min_row,0])
    rounded_box([RM_JOIN_L,max_row-min_row,RM_JOIN_T],RM_JOIN_PANEL_R);
}

module flat_join() {
  peg_rows = flat_peg_rows();
  leg = join_leg(inner_join_rows());
  difference() {
    union() {
      join_panel(-leg,leg);
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
  floor_rows = inner_floor_rows();
  wall_rows = inner_wall_rows();
  floor_leg = join_leg(floor_rows);
  wall_leg = join_leg(wall_rows);
  difference() {
    union() {
      join_panel(-floor_leg,0);
      rotate([90,0,0]) join_panel(0,wall_leg);
      for(x=join_columns(), y=[for(row=floor_rows) -row])
        translate([x,y,0]) downward_peg();
      for(x=join_columns(), z=wall_rows)
        translate([x,0,z]) forward_peg();
    }
    for(x=join_columns(), y=[for(row=floor_rows) -row])
      translate([x,y,0]) top_screw_cut();
    for(x=join_columns(), z=wall_rows)
      translate([x,0,z]) side_screw_cut();
    translate([-RM_JOIN_L/2,-RM_SEAL_W/2,-RM_EPS])
      cube([RM_JOIN_L,RM_SEAL_W,RM_SEAL_D+RM_EPS]);
    translate([-RM_JOIN_L/2,-RM_JOIN_T-RM_EPS,-RM_SEAL_W/2])
      cube([RM_JOIN_L,RM_SEAL_D+RM_EPS,RM_SEAL_W]);
  }
}

module outer_angle_join() {
  floor_rows = outer_floor_rows();
  wall_rows = outer_wall_rows();
  floor_leg = join_leg(floor_rows);
  wall_leg = join_leg(wall_rows);
  difference() {
    union() {
      translate([0,0,-RM_JOIN_T])
        join_panel(-floor_leg,0);
      translate([0,RM_JOIN_T,0]) rotate([90,0,0]) join_panel(0,wall_leg);
      for(x=join_columns(), y=[for(row=floor_rows) -row])
        translate([x,y,0]) upward_peg();
      for(x=join_columns(), z=wall_rows)
        translate([x,0,z]) backward_peg();
    }
    for(x=join_columns(), y=[for(row=floor_rows) -row])
      translate([x,y,0]) bottom_screw_cut();
    for(x=join_columns(), z=wall_rows)
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
      translate([-RM_PLAQUE_SIZE/2,-RM_PLAQUE_SIZE/2,0])
        rounded_box([RM_PLAQUE_SIZE,RM_PLAQUE_SIZE,RM_PLAQUE_T],RM_PLAQUE_R);
      for(x=[-RM_PLAQUE_PEG_X,RM_PLAQUE_PEG_X]) translate([x,0,0]) downward_peg();
    }
    for(x=[-RM_PLAQUE_PEG_X,RM_PLAQUE_PEG_X])
      translate([x,0,0]) top_screw_cut(RM_PLAQUE_T);
    for(x=[-RM_PLAQUE_SLOT_XY,RM_PLAQUE_SLOT_XY], y=[-RM_PLAQUE_SLOT_XY,RM_PLAQUE_SLOT_XY])
      translate([x,y,-RM_EPS]) linear_extrude(height=RM_PLAQUE_T+2*RM_EPS) hull() {
          translate([0,-RM_PLAQUE_SLOT_LENGTH/2]) circle(d=RM_PLAQUE_SLOT_D);
          translate([0,RM_PLAQUE_SLOT_LENGTH/2]) circle(d=RM_PLAQUE_SLOT_D);
        }
  }
}

module tolerance_male_set() {
  for(i=[0:len(RM_TEST_MALE_FITS)-1])
    translate([test_male_x(i),0,0]) difference() {
      union() {
        translate([-RM_TEST_PAD_SIZE/2,-RM_TEST_PAD_SIZE/2,0])
          rounded_box([RM_TEST_PAD_SIZE,RM_TEST_PAD_SIZE,RM_TEST_PAD_T],RM_TEST_PAD_R);
        downward_peg(RM_TEST_MALE_FITS[i]);
      }
      top_screw_cut(RM_TEST_PAD_T);
      if(i > 0)
        for(mark=[1:i])
          translate([-RM_TEST_PAD_SIZE/2+mark*2,-RM_TEST_PAD_SIZE/2,-RM_EPS])
            cube([1,2,RM_TEST_PAD_T+2*RM_EPS]);
    }
}

module tolerance_female_tile() {
  difference() {
    translate([-RM_TEST_TILE_SIZE/2,-RM_TEST_TILE_SIZE/2,0])
      rounded_box([RM_TEST_TILE_SIZE,RM_TEST_TILE_SIZE,RM_TEST_TILE_T],RM_TEST_TILE_R);
    for(x=test_tile_positions(), y=test_tile_positions())
      translate([x,y,RM_TEST_TILE_T]) mirror([0,0,1]) blind_port_cut();
  }
}
