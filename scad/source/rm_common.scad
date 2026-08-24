// RobotMind: solid, double-sided panels with one blind mounting interface.
// One port does two jobs: press-fit peg (carriers) or bolted joint via an
// M3 brass heat-set insert (links). All dimensions are millimetres.
$fn = 32;

RM_EPS = 0.1;
RM_UNIT = 40;
RM_GRID = 10;
RM_EDGE_MARGIN = RM_GRID/2;
RM_PANEL_T = 8;
RM_CORNER_R = 3;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

// One hexagonal blind port. The hexagonal ring accepts a tool-free peg; the
// central bore seats an M3 brass heat-set insert for bolted links.
RM_PORT_OD = 8;       // hexagon corner-to-corner
RM_PORT_DEPTH = 2.2;  // hex ring depth
RM_INSERT_OD = 4.0;   // M3 brass knurled heat-set insert, outer diameter
RM_INSERT_BORE = 3.4; // printed blind bore for the insert (melt-press fit)
RM_INSERT_DEPTH = 3.0;// blind bore depth; 2x this must stay under panel thickness
RM_PEG_BORE = RM_INSERT_OD+0.2; // peg centre bore clears a seated insert
RM_PEG_ENTRY = 0.2;
RM_PEG_GRIP = 0.2;

RM_M3_CLEARANCE = 3.4;
RM_M3_HEAD_D = 6.2;
RM_M3_HEAD_DEPTH = 2;

// Bolted links. Brackets screw into heat-set inserts seated in panel ports.
RM_LINK_T = 4;   // bracket thickness
RM_LINK_W = 24;  // bracket width across the seam
RM_LINK_ROW = RM_GRID/2;                       // flat rows: 5 mm off the seam
RM_CORNER_ROW = RM_UNIT/2-RM_PANEL_T-RM_EDGE_MARGIN; // 7: fold to first row

function rm_port_od() = RM_PORT_OD+2*RM_FIT;
function rm_insert_bore() = RM_INSERT_BORE+2*RM_FIT;
function rm_peg_root_od(delta=0) = RM_PORT_OD+RM_PEG_GRIP-2*RM_FIT+delta;
function rm_peg_tip_od(delta=0) = RM_PORT_OD-RM_PEG_ENTRY-2*RM_FIT+delta;

function grid_count(span) = floor((span-2*RM_EDGE_MARGIN)/RM_GRID)+1;
function grid_position(i,span) = -span/2+RM_EDGE_MARGIN+i*RM_GRID;
function link_cols(length) =
  [for(k=[0:length/RM_UNIT-1]) RM_GRID/2+2*RM_GRID*k];
function link_hole_xs(length) =
  [for(x=link_cols(length), t=[-1,1]) t*x];

assert(RM_UNIT%RM_GRID == 0, "The unit must contain a whole mounting grid");
assert(grid_count(RM_UNIT) == 4,
       "The 40 mm unit must expose a 4x4 port grid");
assert(RM_PANEL_T-RM_INSERT_DEPTH >= RM_INSERT_DEPTH,
       "Opposed face insert bores must not meet through the membrane");
assert(RM_PANEL_T-RM_INSERT_DEPTH >= 2,
       "Blind insert bore needs a continuous membrane");
assert(RM_INSERT_BORE >= RM_M3_CLEARANCE,
       "Insert bore must clear the M3 shaft");
assert(RM_PEG_BORE > RM_INSERT_OD, "Peg bore must clear a seated insert");
assert(rm_peg_root_od() > rm_port_od() &&
       rm_port_od() > rm_peg_tip_od(),
       "RM_FIT is outside the hexagonal peg range");
assert(RM_GRID-RM_PORT_OD > 1,
       "Mounting ports need enough material between them");
assert(RM_PORT_OD > RM_INSERT_BORE+3,
       "Hex ring needs walls around the insert bore");

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module rounded_panel(size=[RM_UNIT,RM_UNIT], t=RM_PANEL_T,
                     r=RM_CORNER_R) {
  translate([-size[0]/2,-size[1]/2,0]) rounded_box([size[0],size[1],t],r);
}

// Cut from a face at Z=0 into material extending in +Z. One blind port:
// hexagonal ring for the press-fit peg, central bore as insert seat.
module blind_port_cut(depth=RM_PORT_DEPTH,
                      bore_d=rm_insert_bore(),
                      bore_depth=RM_INSERT_DEPTH) {
  union() {
    translate([0,0,-RM_EPS])
      cylinder(h=depth+RM_EPS,d=rm_port_od(),$fn=6);
    translate([0,0,-RM_EPS])
      cylinder(h=bore_depth+RM_EPS,d=bore_d);
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

// Every carrier reuses this exact integral peg: solid hex frustum with a
// centre bore that clears a seated insert and passes an M3 screw.
module mount_peg(delta=0, h=RM_PORT_DEPTH) {
  difference() {
    cylinder(h=h,
             d1=rm_peg_root_od(delta),d2=rm_peg_tip_od(delta),$fn=6);
    translate([0,0,-RM_EPS])
      cylinder(h=h+2*RM_EPS,d=RM_PEG_BORE);
  }
}

// Cut from an exposed surface at Z=0 into material extending in +Z.
module optional_screw_cut(depth=RM_PANEL_T) {
  translate([0,0,-RM_EPS])
    cylinder(h=depth+2*RM_EPS,d=RM_M3_CLEARANCE);
  translate([0,0,-RM_EPS])
    cylinder(h=RM_M3_HEAD_DEPTH+RM_EPS,d=RM_M3_HEAD_D);
}

// Bolted links. Both print flat, features up, support-free; screw heads sit
// proud of the bracket (no counterbore). Rows land on the seam-adjacent port
// rows; columns repeat every 20 mm along the seam.

// One M3 pass-through hole: shaft clearance, drilled right through a 4 mm
// bracket in +Z, or in +Y for the fold leg of an angle link.
module link_bolt_hole(x, y, up=true) {
  if(up) translate([x,y,-RM_EPS])
    cylinder(h=RM_LINK_T+2*RM_EPS,d=RM_M3_CLEARANCE);
  else translate([x,y,0]) rotate([90,0,0])
    cylinder(h=RM_LINK_T+2*RM_EPS,d=RM_M3_CLEARANCE);
}

// flat_link(length): bridges a coplanar seam. Holes at +/-5 mm off the
// seam line (the two seam-adjacent port rows of each panel).
module flat_link(length=RM_UNIT) {
  assert(length%RM_UNIT == 0, "Link length must use 40 mm units");
  difference() {
    translate([-length/2,-RM_LINK_W/2,0])
      rounded_box([length,RM_LINK_W,RM_LINK_T],3);
    for(x=link_hole_xs(length), y=[-RM_LINK_ROW,RM_LINK_ROW])
      link_bolt_hole(x,y);
  }
}

// angle_link(length): a 90-degree bracket for box corners. The fold line
// sits at the inner corner; the floor leg extends -Y, the wall leg +Z, so
// holes land on the first two free port rows of each panel.
module angle_link(length=RM_UNIT) {
  assert(length%RM_UNIT == 0, "Link length must use 40 mm units");
  ys=[-RM_CORNER_ROW-RM_GRID, -RM_CORNER_ROW];
  difference() {
    union() {
      translate([-length/2,-RM_LINK_W,0])
        rounded_box([length,RM_LINK_W,RM_LINK_T],3);
      translate([-length/2,-RM_LINK_T,0]) rotate([90,0,0])
        rounded_box([length,RM_LINK_W,RM_LINK_T],3);
    }
    for(x=link_hole_xs(length), y=ys, up=[true,false])
      link_bolt_hole(x,y,up=up);
  }
}