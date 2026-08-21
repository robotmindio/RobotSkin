// RobotMind V3 mechanical standard. All dimensions are millimetres.
$fn = 32;

RM_EPS = 0.1;
RM_UNIT = 40;
RM_GRID = 8;
RM_PLATE_T = 3.2;
RM_HOLE_D = 5.0;
RM_FIT = 0; // positive is looser; tune in 0.05 mm steps

RM_CORNER_R = 3;
RM_PIN_HEAD_D = 8;
RM_PIN_HEAD_T = 1.6;
RM_PIN_STEM_D = 4.7-2*RM_FIT;
RM_PIN_GRIP_D = 5.3-2*RM_FIT;
RM_PIN_TIP_D = 4.2-2*RM_FIT;
RM_PIN_SPLIT = 1.0;
RM_PIN_STACK = 2*RM_PLATE_T;
RM_PIN_TIP_LENGTH = 1.6;

assert(RM_UNIT%RM_GRID == 0, "The 40 mm unit must follow the 8 mm grid");
assert(RM_PLATE_T > 0 && RM_HOLE_D+2*RM_FIT > 0,
       "Plate and hole dimensions must stay positive");
assert(RM_PIN_GRIP_D > RM_PIN_STEM_D && RM_PIN_STEM_D > RM_PIN_TIP_D,
       "RM_FIT is outside the printable pin range");
assert(RM_PIN_TIP_D > 0, "RM_FIT makes the push pin invalid");

function rm_hole_d(delta=0) = RM_HOLE_D+2*RM_FIT+delta;
function grid_count(span) = round(span/RM_GRID);
function grid_position(i,span) = -span/2+RM_GRID/2+i*RM_GRID;

module rounded_box(size=[20,20,3], r=2) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module rounded_plate(size=[RM_UNIT,RM_UNIT], t=RM_PLATE_T,
                     r=RM_CORNER_R) {
  translate([-size[0]/2,-size[1]/2,0]) rounded_box([size[0],size[1],t],r);
}

module hole_at(point=[0,0], t=RM_PLATE_T, d=rm_hole_d()) {
  translate([point[0],point[1],-RM_EPS])
    cylinder(h=t+2*RM_EPS,d=d);
}

module grid_holes(size=[RM_UNIT,RM_UNIT], t=RM_PLATE_T) {
  for(ix=[0:grid_count(size[0])-1], iy=[0:grid_count(size[1])-1])
    hole_at([grid_position(ix,size[0]),grid_position(iy,size[1])],t);
}

module plate(size=[RM_UNIT,RM_UNIT]) {
  assert(size[0]%RM_UNIT == 0 && size[1]%RM_UNIT == 0,
         "Plate dimensions must be whole 40 mm units");
  difference() {
    rounded_plate(size);
    grid_holes(size);
  }
}

// Four pins, two per plate, make a rigid coplanar seam. Mount below the
// plates when the visible surface must stay flat.
module flat_link() {
  size=[2*RM_GRID,3*RM_GRID];
  difference() {
    rounded_plate(size,RM_PLATE_T,RM_CORNER_R);
    for(x=[-RM_GRID/2,RM_GRID/2], y=[-RM_GRID,RM_GRID])
      hole_at([x,y]);
  }
}

// The same plate holes accept this plain inside bracket at 90 degrees.
module angle_link() {
  width=3*RM_GRID;
  leg=1.5*RM_GRID;
  difference() {
    union() {
      translate([-width/2,-leg,0]) cube([width,leg,RM_PLATE_T]);
      translate([-width/2,-RM_PLATE_T,0])
        cube([width,RM_PLATE_T,leg]);
    }
    for(x=[-RM_GRID,RM_GRID]) {
      hole_at([x,-RM_GRID/2]);
      translate([x,RM_EPS,RM_GRID/2]) rotate([90,0,0])
        cylinder(h=RM_PLATE_T+2*RM_EPS,d=rm_hole_d());
    }
  }
}

// One split pin joins any two RM_PLATE_T layers. The head and flexible tip
// provide tool-free assembly; the same holes also accept M4 bolts.
module push_pin(grip_delta=0) {
  grip=RM_PIN_GRIP_D+grip_delta;
  difference() {
    union() {
      cylinder(h=RM_PIN_HEAD_T,d=RM_PIN_HEAD_D);
      translate([0,0,RM_PIN_HEAD_T])
        cylinder(h=RM_PIN_STACK-0.8,d=RM_PIN_STEM_D);
      translate([0,0,RM_PIN_HEAD_T+RM_PIN_STACK-0.8])
        cylinder(h=1,d1=RM_PIN_STEM_D,d2=grip);
      translate([0,0,RM_PIN_HEAD_T+RM_PIN_STACK+0.2])
        cylinder(h=RM_PIN_TIP_LENGTH-0.2,d1=grip,d2=RM_PIN_TIP_D);
    }
    translate([-RM_PIN_SPLIT/2,-grip,
               RM_PIN_HEAD_T+1.5])
      cube([RM_PIN_SPLIT,2*grip,
            RM_PIN_STACK+RM_PIN_TIP_LENGTH]);
  }
}
