// RobotMind V4: solid, double-sided panels with one blind mounting interface.
// All dimensions are millimetres.
$fn = 32;

RM_EPS = 0.1;
RM_UNIT = 40;
RM_GRID = 10;
RM_EDGE_MARGIN = RM_GRID/2;
RM_PANEL_T = 8;
RM_CORNER_R = 3;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

// One hexagonal blind port. The hexagonal ring accepts a tool-free peg; the
// circular centre boss accepts an optional M3 screw without piercing the
// waterproof membrane.
RM_PORT_OD = 8;
RM_PORT_BOSS_D = 5;
RM_PORT_DEPTH = 2.2;
RM_PORT_PILOT_D = 2.7;
RM_PORT_PILOT_DEPTH = 3;
RM_PEG_ENTRY = 0.2;
RM_PEG_GRIP = 0.2;
RM_PEG_INNER_CLEARANCE = 0.3;

RM_LINK_T = 3.2;
RM_LINK_LEG = 2*RM_GRID;
RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_M3_HEAD_DEPTH = 2;

RM_GASKET_W = 5;
RM_GASKET_T = 0.8;
RM_GASKET_GROOVE = 0.4;

function rm_port_od() = RM_PORT_OD+2*RM_FIT;
function rm_port_boss_d() = RM_PORT_BOSS_D-2*RM_FIT;
function rm_pilot_d() = RM_PORT_PILOT_D+2*RM_FIT;
function rm_peg_root_od(delta=0) = RM_PORT_OD+RM_PEG_GRIP-2*RM_FIT+delta;
function rm_peg_tip_od(delta=0) = RM_PORT_OD-RM_PEG_ENTRY-2*RM_FIT+delta;
function rm_peg_id() = RM_PORT_BOSS_D+RM_PEG_INNER_CLEARANCE+2*RM_FIT;
function grid_count(span) = floor((span-2*RM_EDGE_MARGIN)/RM_GRID)+1;
function grid_position(i,span) = -span/2+RM_EDGE_MARGIN+i*RM_GRID;
function link_anchor_positions(length) =
  [for(i=[0:grid_count(length)-1]) grid_position(i,length)];

assert(RM_UNIT%RM_GRID == 0, "The unit must contain a whole mounting grid");
assert(grid_count(RM_UNIT) == 4,
       "The 40 mm unit must expose a 4x4 port grid");
assert(RM_PANEL_T > 2*RM_PORT_PILOT_DEPTH,
       "Blind pilots need a continuous waterproof membrane");
assert(rm_peg_root_od() > rm_port_od() &&
       rm_port_od() > rm_peg_tip_od(),
       "RM_FIT is outside the hexagonal peg range");
assert(rm_peg_id() > rm_port_boss_d() &&
       rm_port_boss_d() > rm_pilot_d(),
       "The port boss must separate peg and screw fits");
assert(RM_GRID-RM_PORT_OD > 1,
       "Mounting ports need enough material between them");
assert(RM_EDGE_MARGIN > RM_LINK_T,
       "Perpendicular optional screws must not intersect");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module rounded_panel(size=[RM_UNIT,RM_UNIT], t=RM_PANEL_T,
                     r=RM_CORNER_R) {
  translate([-size[0]/2,-size[1]/2,0]) rounded_box([size[0],size[1],t],r);
}

// Cut from a face at Z=0 into material extending in +Z.
module blind_port_cut() {
  union() {
    difference() {
      translate([0,0,-RM_EPS])
        cylinder(h=RM_PORT_DEPTH+RM_EPS,d=rm_port_od(),$fn=6);
      translate([0,0,-2*RM_EPS])
        cylinder(h=RM_PORT_DEPTH+3*RM_EPS,d=rm_port_boss_d());
    }
    translate([0,0,-RM_EPS])
      cylinder(h=RM_PORT_PILOT_DEPTH+RM_EPS,d=rm_pilot_d());
  }
}

module face_port_cuts(size=[RM_UNIT,RM_UNIT], top=false) {
  for(ix=[0:grid_count(size[0])-1], iy=[0:grid_count(size[1])-1]) {
    p=[grid_position(ix,size[0]),grid_position(iy,size[1])];
    if(top)
      translate([p[0],p[1],RM_PANEL_T]) mirror([0,0,1]) blind_port_cut();
    else
      translate([p[0],p[1],0]) blind_port_cut();
  }
}

module panel(size=[RM_UNIT,RM_UNIT]) {
  assert(size[0]%RM_UNIT == 0 && size[1]%RM_UNIT == 0,
         "Panel dimensions must be whole 40 mm units");
  difference() {
    rounded_panel(size);
    face_port_cuts(size);
    face_port_cuts(size,true);
  }
}

// Every carrier and connector reuses this exact integral hexagonal peg.
module mount_peg(delta=0) {
  difference() {
    cylinder(h=RM_PORT_DEPTH,
             d1=rm_peg_root_od(delta),d2=rm_peg_tip_od(delta),$fn=6);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=rm_peg_id());
  }
}

// Cut from an exposed surface at Z=0 into a connector extending in +Z.
module optional_screw_cut(depth=RM_LINK_T) {
  translate([0,0,-RM_EPS])
    cylinder(h=depth+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,-RM_EPS])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

module flat_link(length=RM_UNIT) {
  width=3*RM_GRID;
  anchors=link_anchor_positions(length);
  difference() {
    union() {
      rounded_panel([width,length],RM_LINK_T,RM_CORNER_R);
      for(x=[-RM_EDGE_MARGIN,RM_EDGE_MARGIN], y=anchors)
        translate([x,y,RM_LINK_T]) mount_peg();
    }
    for(x=[-RM_EDGE_MARGIN,RM_EDGE_MARGIN], y=anchors)
      translate([x,y,0]) optional_screw_cut(RM_LINK_T+RM_PORT_DEPTH);
    translate([-RM_GASKET_W/2,-length/2-RM_EPS,
               RM_LINK_T-RM_GASKET_GROOVE])
      cube([RM_GASKET_W,length+2*RM_EPS,
            RM_GASKET_GROOVE+2*RM_EPS]);
  }
}

module angle_link(length=RM_UNIT) {
  anchors=link_anchor_positions(length);
  rows=[RM_EDGE_MARGIN,RM_EDGE_MARGIN+RM_GRID];
  difference() {
    union() {
      translate([-length/2,-RM_LINK_LEG,0])
        cube([length,RM_LINK_LEG,RM_LINK_T]);
      translate([-length/2,-RM_LINK_T,0])
        cube([length,RM_LINK_T,RM_LINK_LEG]);
      for(x=anchors, row=rows) {
        translate([x,-row,0]) rotate([180,0,0]) mount_peg();
        translate([x,0,row]) rotate([-90,0,0]) mount_peg();
      }
    }
    for(x=anchors, row=rows) {
      translate([x,-row,RM_LINK_T]) rotate([180,0,0])
        optional_screw_cut(RM_LINK_T+RM_PORT_DEPTH);
      translate([x,-RM_LINK_T,row]) rotate([-90,0,0])
        optional_screw_cut(RM_LINK_T+RM_PORT_DEPTH);
    }
    translate([-length/2-RM_EPS,-RM_GASKET_W,-RM_EPS])
      cube([length+2*RM_EPS,RM_GASKET_W,
            RM_GASKET_GROOVE+RM_EPS]);
    translate([-length/2-RM_EPS,-RM_GASKET_GROOVE,-RM_EPS])
      cube([length+2*RM_EPS,RM_GASKET_GROOVE+RM_EPS,
            RM_GASKET_W+RM_EPS]);
  }
}

module flat_gasket(length=RM_UNIT) {
  translate([-RM_GASKET_W/2,-length/2,0])
    cube([RM_GASKET_W,length,RM_GASKET_T]);
}

module angle_gasket(length=RM_UNIT) {
  union() {
    translate([-length/2,-RM_GASKET_W,0])
      cube([length,RM_GASKET_W,RM_GASKET_T]);
    translate([-length/2,-RM_GASKET_T,0])
      cube([length,RM_GASKET_T,RM_GASKET_W]);
  }
  // ponytail: edge seals target splashes; add molded 3-way corner boots only
  // after a physical cube leak test proves they are needed.
}
