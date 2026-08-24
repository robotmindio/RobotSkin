// RobotMind: solid, double-sided panels with one blind mounting interface
// and hermaphrodite battlement edges. All dimensions are millimetres.
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
// opposite face.
RM_PORT_OD = 8;
RM_PORT_BOSS_D = 5;
RM_PORT_DEPTH = 2.2;
RM_PORT_PILOT_D = 2.7;
RM_PORT_PILOT_DEPTH = 3;
RM_PEG_ENTRY = 0.2;
RM_PEG_GRIP = 0.2;
RM_PEG_INNER_CLEARANCE = 0.3;

RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_M3_HEAD_DEPTH = 2;

// Hermaphrodite battlement edge. Every panel is identical and point
// symmetric: north and west edges lead with a tab, south and east with a
// socket, so any edge mates any neighbouring edge with no connector parts.
// Flips are always allowed; 90-degree in-plane twists are not.
RM_TAB_W = 6;     // feature width along the edge
RM_TAB_T = 3;     // feature thickness, centred in the panel
RM_TAB_PROUD = 4; // tab protrusion == socket depth

function rm_tab_w() = RM_TAB_W-2*RM_FIT;
function rm_socket_w() = RM_TAB_W+2*RM_FIT;
function rm_port_od() = RM_PORT_OD+2*RM_FIT;
function rm_port_boss_d() = RM_PORT_BOSS_D-2*RM_FIT;
function rm_pilot_d() = RM_PORT_PILOT_D+2*RM_FIT;
function rm_peg_root_od(delta=0) = RM_PORT_OD+RM_PEG_GRIP-2*RM_FIT+delta;
function rm_peg_tip_od(delta=0) = RM_PORT_OD-RM_PEG_ENTRY-2*RM_FIT+delta;
function rm_peg_id() = RM_PORT_BOSS_D+RM_PEG_INNER_CLEARANCE+2*RM_FIT;

function grid_count(span) = floor((span-2*RM_EDGE_MARGIN)/RM_GRID)+1;
function grid_position(i,span) = -span/2+RM_EDGE_MARGIN+i*RM_GRID;

assert(RM_UNIT%RM_GRID == 0, "The unit must contain a whole mounting grid");
assert(grid_count(RM_UNIT) == 4,
       "The 40 mm unit must expose a 4x4 port grid");
assert(RM_PANEL_T > 2*RM_PORT_PILOT_DEPTH,
       "Blind pilots need a continuous membrane");
assert(rm_peg_root_od() > rm_port_od() &&
       rm_port_od() > rm_peg_tip_od(),
       "RM_FIT is outside the hexagonal peg range");
assert(rm_peg_id() > rm_port_boss_d() &&
       rm_port_boss_d() > rm_pilot_d(),
       "The port boss must separate peg and screw fits");
assert(RM_GRID-RM_PORT_OD > 1,
       "Mounting ports need enough material between them");
assert(RM_PANEL_T-RM_TAB_T >= 4, "Battlements need 2 mm skins");
assert(RM_TAB_W < RM_GRID, "Battlements must clear each other and corners");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module rounded_panel(size=[RM_UNIT,RM_UNIT], t=RM_PANEL_T,
                     r=RM_CORNER_R) {
  translate([-size[0]/2,-size[1]/2,0]) rounded_box([size[0],size[1],t],r);
}

// Cut from a face at Z=0 into material extending in +Z.
module blind_port_cut(depth=RM_PORT_DEPTH,
                      pilot_d=rm_pilot_d(),
                      pilot_depth=RM_PORT_PILOT_DEPTH) {
  union() {
    difference() {
      translate([0,0,-RM_EPS])
        cylinder(h=depth+RM_EPS,d=rm_port_od(),$fn=6);
      translate([0,0,-2*RM_EPS])
        cylinder(h=depth+3*RM_EPS,d=rm_port_boss_d());
    }
    translate([0,0,-RM_EPS])
      cylinder(h=pilot_depth+RM_EPS,d=pilot_d);
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
  hw=size[0]/2;
  hh=size[1]/2;
  difference() {
    union() {
      rounded_panel(size);
      edge_tabs_x(size[0], hh, 1, 0);   // north leads with a tab
      edge_tabs_x(size[0], -hh, -1, 1); // south leads with a socket
      edge_tabs_y(size[1], hw, 1, 1);   // east leads with a socket
      edge_tabs_y(size[1], -hw, -1, 0); // west leads with a tab
    }
    edge_sockets_x(size[0], hh, 1, 0);   // north sockets at odd lines
    edge_sockets_x(size[0], -hh, -1, 1); // south sockets at even lines
    edge_sockets_y(size[1], hw, 1, 1);   // east sockets at even lines
    edge_sockets_y(size[1], -hw, -1, 0); // west sockets at odd lines
    face_port_cuts(size);
    face_port_cuts(size,true);
  }
}

// Every carrier reuses this exact integral hexagonal peg.
module mount_peg(delta=0, h=RM_PORT_DEPTH) {
  difference() {
    cylinder(h=h,
             d1=rm_peg_root_od(delta),d2=rm_peg_tip_od(delta),$fn=6);
    translate([0,0,-RM_EPS])
      cylinder(h=h+2*RM_EPS,d=rm_peg_id());
  }
}

// Cut from an exposed surface at Z=0 into material extending in +Z.
module optional_screw_cut(depth=RM_PANEL_T) {
  translate([0,0,-RM_EPS])
    cylinder(h=depth+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,-RM_EPS])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

// Battlement primitives. phase 0 puts tabs on even grid indices, phase 1 on
// odd indices. Edges running along X sit at y=y0 and open toward sy; edges
// along Y sit at x=x0 and open toward sx.
// Tabs are solids added to the panel; sockets are blind recesses cut into
// the same edge at the opposite parity. A socket always opens at the edge
// face (y0) and reaches INTO the panel body, i.e. in the -sy direction for
// an edge whose features point +sy.
module _tab(x, y0, sy) {
  translate([x-RM_TAB_W/2,
             sy>0 ? y0 : y0-RM_TAB_PROUD,
             (RM_PANEL_T-RM_TAB_T)/2])
    cube([RM_TAB_W,RM_TAB_PROUD,RM_TAB_T]);
}

module _socket(x, y0, sy) {
  translate([x-rm_socket_w()/2,
             sy>0 ? y0-RM_TAB_PROUD-RM_EPS : y0,
             (RM_PANEL_T-RM_TAB_T)/2])
    cube([rm_socket_w(),RM_TAB_PROUD+2*RM_EPS,RM_TAB_T]);
}

module edge_tabs_x(length, y0, sy, phase) {
  for(i=[0:grid_count(length)-1])
    if(i%2 == phase)
      _tab(grid_position(i,length),y0,sy);
}

module edge_sockets_x(length, y0, sy, phase) {
  for(i=[0:grid_count(length)-1])
    if(i%2 != phase)
      _socket(grid_position(i,length),y0,sy);
}

module edge_tabs_y(length, x0, sx, phase) {
  for(i=[0:grid_count(length)-1])
    if(i%2 == phase)
      translate([sx>0 ? x0 : x0-RM_TAB_PROUD,
                 grid_position(i,length)-RM_TAB_W/2,
                 (RM_PANEL_T-RM_TAB_T)/2])
        cube([RM_TAB_PROUD,RM_TAB_W,RM_TAB_T]);
}

module edge_sockets_y(length, x0, sx, phase) {
  for(i=[0:grid_count(length)-1])
    if(i%2 != phase)
      translate([sx>0 ? x0-RM_TAB_PROUD-RM_EPS : x0-RM_EPS,
                 grid_position(i,length)-rm_socket_w()/2,
                 (RM_PANEL_T-RM_TAB_T)/2])
        cube([RM_TAB_PROUD+2*RM_EPS,rm_socket_w(),RM_TAB_T]);
}
