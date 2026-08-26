// RobotMind public design library.
$fn = 32;

// Mechanical standard: tune fits here, not in individual parts.
RM_EPS = 0.1;
RM_PORT_FIT = 0;
RM_PEG_FIT = 0.20;
RM_GRID = 10;
RM_PLATE_T = 4;
RM_PORT_AF = 8;
RM_PORT_DEPTH = 2.2;
RM_INSERT_BORE = 3.7;
RM_INSERT_OD = 4.0;
RM_INSERT_DEPTH = 3;
RM_INSERT_LEAD = 0.8;
RM_INSERT_ENTRY_CLEARANCE = 0.6;
RM_PORT_BOSS_D = 5.6;
RM_PEG_BOSS_CLEARANCE = 0.3;
RM_PEG_ENTRY = 0.22;
RM_PEG_GRIP = 0.5;
RM_PEG_MIN_WALL = 0.7;
RM_M3_NOMINAL_D = 3.0;
RM_M3_CLEARANCE = 3.4;
RM_LOCK_SCREW_LENGTH = 6;
RM_PLATE_R = 1;
RM_JOIN_T = 4;
RM_JOIN_PANEL_R = 3;
RM_CARRIER_T = RM_JOIN_T;
RM_CARRIER_R = 3;
RM_GROVE_EDGE = 4;
RM_GROVE_STANDOFF_H = 3;
RM_GROVE_STANDOFF_D = 5;
RM_GROVE_M2_5_PILOT_D = 2.1;
RM_GROVE_M2_5_PILOT_DEPTH = 5;
RM_ADAPTER_R = 3;
RM_M3_HEAD_CLEARANCE_D = 6.2;
RM_M5_CLEARANCE_D = 5.5;
RM_TAG_BORDER = 3;
RM_TAG_CARD_T = 0.4;
RM_TAG_TAB = 4;
RM_TRIPOD_BODY_T = 8;
RM_TRIPOD_CLEARANCE_D = 6.8;
RM_TRIPOD_NUT_AF = 11.3;
RM_TRIPOD_NUT_H = 5.8;
RM_DIN_WIDTH = 35;
RM_DIN_CLEARANCE = 0.4;
RM_DIN_HOOK_T = 2.5;
RM_DIN_HOOK_DEPTH = 2;
RM_DIN_LIP_T = 1.5;
RM_CABLE_W = 7.5;
RM_CABLE_H = 2.2;

// Calibration-part standard.
RM_TEST_MALE_FITS = [0,0.05,0.10,0.15,0.20];
RM_TEST_PAD_SIZE = 12;
RM_TEST_PAD_R = 2;
RM_TEST_PAD_PITCH = 14;
RM_TEST_TILE_R = 2;
RM_TEST_INSERT_BORES = [3.75,3.80,3.85,3.90,3.95];
RM_TEST_INSERT_PAD = 12;
RM_TEST_INSERT_R = 2;
RM_TEST_INSERT_PITCH = 14;

// Grid language.
function grid_size(count) = count*RM_GRID;
function grid_positions(count) =
  [for(i=[0:count-1]) (i-(count-1)/2)*RM_GRID];
function is_corner_index(column,row,columns,rows) =
  (column == 0 || column == columns-1) &&
  (row == 0 || row == rows-1);
function edge_rows(depth_ports) =
  [for(i=[0:depth_ports-1]) RM_GRID/2+i*RM_GRID];
function flat_rows(depth_ports) =
  concat([for(i=[depth_ports-1:-1:0]) -edge_rows(depth_ports)[i]],
         edge_rows(depth_ports));
function outer_rows(depth_ports,plate_t=RM_PLATE_T) =
  [for(row=edge_rows(depth_ports)) plate_t+row];
function grove_hole_spacing(board_size) =
  [board_size[0]-RM_GROVE_EDGE,board_size[1]-RM_GROVE_EDGE];
function grove_lock_x(board_width) = board_width/2+RM_GRID/2;
function grid_station_outside(distance) =
  ceil((distance-RM_GRID/2)/RM_GRID)*RM_GRID+RM_GRID/2;
function octagon_d(af) = af/cos(22.5);
function port_af(fit=RM_PORT_FIT) = RM_PORT_AF+2*fit;
function insert_bore(fit=RM_PORT_FIT) = RM_INSERT_BORE+fit;
function insert_entry_d() = RM_INSERT_OD+RM_INSERT_ENTRY_CLEARANCE;
function port_boss_d(fit=RM_PORT_FIT) = RM_PORT_BOSS_D-2*fit;
function peg_root_af(fit=RM_PEG_FIT) = RM_PORT_AF+RM_PEG_GRIP-2*fit;
function peg_tip_af(fit=RM_PEG_FIT) = RM_PORT_AF-RM_PEG_ENTRY-2*fit;
function peg_bore(fit=RM_PEG_FIT) = RM_PORT_BOSS_D+RM_PEG_BOSS_CLEARANCE;
function peg_wall(af,fit=RM_PEG_FIT) = af/2-peg_bore(fit)/2;

assert(RM_PLATE_T-RM_INSERT_DEPTH >= 1,
       "The insert bore needs at least 1 mm of backing wall");
assert(RM_PORT_FIT >= 0 && RM_PORT_FIT <= 0.15,
       "RM_PORT_FIT must stay within 0..0.15 mm");
assert(RM_PEG_FIT >= 0 && RM_PEG_FIT <= 0.20,
       "RM_PEG_FIT must stay within 0..0.20 mm");
assert(peg_root_af() > port_af() && port_af() > peg_tip_af(),
       "Peg needs a lead-in and final grip");
assert(RM_INSERT_OD > insert_bore(),
       "The heat-set insert needs deliberate melt-press interference");
assert(port_boss_d() > insert_entry_d(),
       "The insert needs a supporting centre boss");
assert(peg_bore() > port_boss_d(),
       "The peg must clear the centre boss");
assert(peg_wall(peg_tip_af()) >= RM_PEG_MIN_WALL,
       "Peg wall must remain printable at its tip");
assert(RM_LOCK_SCREW_LENGTH-RM_JOIN_T > 0 &&
       RM_LOCK_SCREW_LENGTH-RM_JOIN_T < RM_INSERT_DEPTH,
       "The lock screw must engage without bottoming in the blind insert");

// Geometry primitives.
module rounded_box(size,r) {
  linear_extrude(height=size[2])
    offset(r=r) offset(delta=-r) square([size[0],size[1]]);
}

module octagonal_prism(height,af) {
  cylinder(h=height,d=octagon_d(af),$fn=8);
}

module hexagonal_prism(height,af) {
  cylinder(h=height,d=af/cos(30),$fn=6);
}

// Female interface primitive. Subtract this from a body.
module port_cut(fit=RM_PORT_FIT,bore=undef) {
  pilot = is_undef(bore) ? insert_bore(fit) : bore;
  difference() {
    translate([0,0,-RM_EPS])
      octagonal_prism(RM_PORT_DEPTH+RM_EPS,port_af(fit));
    translate([0,0,-2*RM_EPS])
      cylinder(h=RM_PORT_DEPTH+3*RM_EPS,d=port_boss_d(fit));
  }
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=pilot);
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_LEAD+RM_EPS,d1=insert_entry_d(),d2=pilot);
}

// Male interface primitive.
module peg(fit=RM_PEG_FIT) {
  difference() {
    cylinder(h=RM_PORT_DEPTH,
             d1=octagon_d(peg_root_af(fit)),
             d2=octagon_d(peg_tip_af(fit)),$fn=8);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_PORT_DEPTH+2*RM_EPS,d=peg_bore(fit));
  }
}

module heat_set_insert() {
  difference() {
    cylinder(h=RM_INSERT_DEPTH,d=RM_INSERT_OD);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_INSERT_DEPTH+2*RM_EPS,d=RM_M3_NOMINAL_D);
  }
}

// Oriented connector subcomponents.
module connector_peg(direction="down",fit=RM_PEG_FIT) {
  if(direction == "down")
    translate([0,0,RM_EPS]) rotate([180,0,0]) peg(fit);
  else if(direction == "forward")
    translate([0,-RM_EPS,0]) rotate([-90,0,0]) peg(fit);
  else if(direction == "up")
    translate([0,0,-RM_EPS]) peg(fit);
  else if(direction == "backward")
    translate([0,RM_EPS,0]) rotate([90,0,0]) peg(fit);
  else assert(false,str("Unknown connector direction: ",direction));
}

// Negative screw path paired with connector_peg. Subtract from the body.
module connector_screw_cut(direction="down",body_t=RM_JOIN_T) {
  if(direction == "down")
    translate([0,0,-RM_PORT_DEPTH-RM_EPS])
      cylinder(h=body_t+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  else if(direction == "forward")
    translate([0,-body_t-RM_EPS,0]) rotate([-90,0,0])
      cylinder(h=body_t+RM_EPS,d=RM_M3_CLEARANCE);
  else if(direction == "up")
    translate([0,0,-body_t-RM_EPS])
      cylinder(h=body_t+RM_PORT_DEPTH+2*RM_EPS,d=RM_M3_CLEARANCE);
  else if(direction == "backward")
    translate([0,body_t+RM_EPS,0]) rotate([90,0,0])
      cylinder(h=body_t+RM_EPS,d=RM_M3_CLEARANCE);
  else assert(false,str("Unknown connector direction: ",direction));
}

module connector_grid(columns,rows,direction="down",cut=false,
                      body_t=RM_JOIN_T,fit=RM_PEG_FIT) {
  assert(columns >= 1 && rows >= 1 &&
         columns == floor(columns) && rows == floor(rows),
         "Connector-grid dimensions must be positive integers");
  for(x=grid_positions(columns),y=grid_positions(rows))
    translate([x,y,0])
      if(cut)
        connector_screw_cut(direction,body_t);
      else
        connector_peg(direction,fit);
}

// Plate components.
module plate_body(columns,rows) {
  translate([-grid_size(columns)/2,-grid_size(rows)/2,0])
    rounded_box([grid_size(columns),grid_size(rows),RM_PLATE_T],RM_PLATE_R);
}

module plate_port_cuts(columns,rows) {
  for(column=[0:columns-1],row=[0:rows-1])
    translate([grid_positions(columns)[column],
               grid_positions(rows)[row],RM_PLATE_T])
      mirror([0,0,1]) port_cut();
}

module plate_corner_through_cuts(columns,rows) {
  for(column=[0:columns-1],row=[0:rows-1])
    if(is_corner_index(column,row,columns,rows))
      translate([grid_positions(columns)[column],grid_positions(rows)[row],
                 -RM_EPS])
        cylinder(h=RM_PLATE_T+2*RM_EPS,d=RM_M3_CLEARANCE);
}

// Public plate: dimensions are port counts, not millimetres.
module plate(columns,rows) {
  assert(columns >= 2 && rows >= 2 &&
         columns == floor(columns) && rows == floor(rows),
         "Plate dimensions must be integers of at least 2x2");
  difference() {
    plate_body(columns,rows);
    plate_port_cuts(columns,rows);
    plate_corner_through_cuts(columns,rows);
  }
}

// Join components.
module join_panel(width,min_row,max_row) {
  translate([-width/2,min_row,0])
    rounded_box([width,max_row-min_row,RM_JOIN_T],RM_JOIN_PANEL_R);
}

module join_leg(width,length) {
  linear_extrude(height=RM_JOIN_T) union() {
    translate([-width/2,-length+RM_JOIN_PANEL_R])
      square([width,length-RM_JOIN_PANEL_R]);
    hull()
      for(x=[-width/2+RM_JOIN_PANEL_R,width/2-RM_JOIN_PANEL_R])
        translate([x,-length+RM_JOIN_PANEL_R]) circle(r=RM_JOIN_PANEL_R);
  }
}

module corner_body(width,depth_ports,outer=false,plate_t=RM_PLATE_T) {
  depth = grid_size(depth_ports);
  if(outer) {
    length = RM_JOIN_T+plate_t+depth;
    translate([0,RM_JOIN_T,-RM_JOIN_T]) join_leg(width,length);
    translate([0,0,-RM_JOIN_T]) rotate([-90,0,0]) join_leg(width,length);
  } else {
    join_leg(width,depth);
    rotate([90,0,0]) mirror([0,1,0]) join_leg(width,depth);
  }
}

// Public join parts.
module flat_join(width_ports=2,depth_ports=2) {
  assert(width_ports >= 1 && width_ports == floor(width_ports),
         "width_ports must be a positive integer");
  assert(depth_ports >= 1 && depth_ports == floor(depth_ports),
         "depth_ports must be a positive integer");
  width = grid_size(width_ports);
  rows = flat_rows(depth_ports);
  difference() {
    union() {
      join_panel(width,-grid_size(depth_ports),grid_size(depth_ports));
      for(x=grid_positions(width_ports),y=rows)
        translate([x,y,0]) connector_peg();
    }
    for(x=grid_positions(width_ports),y=rows)
      translate([x,y,0]) connector_screw_cut();
  }
}

module angle_join(width_ports=2,depth_ports=2) {
  assert(width_ports >= 1 && width_ports == floor(width_ports),
         "width_ports must be a positive integer");
  assert(depth_ports >= 1 && depth_ports == floor(depth_ports),
         "depth_ports must be a positive integer");
  width = grid_size(width_ports);
  rows = edge_rows(depth_ports);
  difference() {
    union() {
      corner_body(width,depth_ports);
      for(x=grid_positions(width_ports),y=rows)
        translate([x,-y,0]) connector_peg();
      for(x=grid_positions(width_ports),z=rows)
        translate([x,0,z]) connector_peg("forward");
    }
    for(x=grid_positions(width_ports),y=rows)
      translate([x,-y,0]) connector_screw_cut();
    for(x=grid_positions(width_ports),z=rows)
      translate([x,0,z]) connector_screw_cut("forward");
  }
}

module outer_angle_join(width_ports=2,depth_ports=2,plate_t=RM_PLATE_T) {
  assert(width_ports >= 1 && width_ports == floor(width_ports),
         "width_ports must be a positive integer");
  assert(depth_ports >= 1 && depth_ports == floor(depth_ports),
         "depth_ports must be a positive integer");
  width = grid_size(width_ports);
  rows = outer_rows(depth_ports,plate_t);
  difference() {
    union() {
      corner_body(width,depth_ports,outer=true,plate_t=plate_t);
      for(x=grid_positions(width_ports),y=rows)
        translate([x,-y,0]) connector_peg("up");
      for(x=grid_positions(width_ports),z=rows)
        translate([x,0,z]) connector_peg("backward");
    }
    for(x=grid_positions(width_ports),y=rows)
      translate([x,-y,0]) connector_screw_cut("up");
    for(x=grid_positions(width_ports),z=rows)
      translate([x,0,z]) connector_screw_cut("backward");
  }
}

module pcb_standoff(position) {
  translate([position[0],position[1],RM_CARRIER_T])
    cylinder(h=RM_GROVE_STANDOFF_H,d=RM_GROVE_STANDOFF_D);
}

// Grove carrier. Board width is 20 or 40 mm; length is 20, 40, or 60 mm.
module grove_carrier(board_size=[20,20]) {
  assert((board_size[0] == 20 || board_size[0] == 40) &&
         (board_size[1] == 20 || board_size[1] == 40 || board_size[1] == 60),
         "Grove board_size must use a documented 20/40 x 20/40/60 mm format");
  hole_spacing = grove_hole_spacing(board_size);
  lock_x = grove_lock_x(board_size[0]);
  body_size = [board_size[0]+2*RM_GRID,board_size[1]+2*RM_GROVE_EDGE];
  difference() {
    union() {
      translate([-body_size[0]/2,-body_size[1]/2,0])
        rounded_box([body_size[0],body_size[1],RM_CARRIER_T],RM_CARRIER_R);
      for(x=[-lock_x,lock_x])
        translate([x,0,0]) connector_peg();
      for(x=[-hole_spacing[0]/2,hole_spacing[0]/2],
          y=[-hole_spacing[1]/2,hole_spacing[1]/2])
        pcb_standoff([x,y]);
    }
    for(x=[-lock_x,lock_x])
      translate([x,0,0]) connector_screw_cut(body_t=RM_CARRIER_T);
    for(x=[-hole_spacing[0]/2,hole_spacing[0]/2],
        y=[-hole_spacing[1]/2,hole_spacing[1]/2])
      translate([x,y,RM_CARRIER_T+RM_GROVE_STANDOFF_H-
                         RM_GROVE_M2_5_PILOT_DEPTH])
        cylinder(h=RM_GROVE_M2_5_PILOT_DEPTH+RM_EPS,
                 d=RM_GROVE_M2_5_PILOT_D);
    translate([-hole_spacing[0]/2+RM_GROVE_STANDOFF_D/2,
               -hole_spacing[1]/2+RM_GROVE_STANDOFF_D/2,-RM_EPS])
      rounded_box([hole_spacing[0]-RM_GROVE_STANDOFF_D,
                   hole_spacing[1]-RM_GROVE_STANDOFF_D,
                   RM_CARRIER_T+2*RM_EPS],1);
  }
}

module apriltag_holder(tag_size=50,border=RM_TAG_BORDER) {
  assert(!is_list(tag_size) || len(tag_size) == 2,
         "AprilTag size must be a number or [width,height]");
  tag = is_list(tag_size) ? tag_size : [tag_size,tag_size];
  assert(tag[0] > 0 && tag[1] > 0 && border >= RM_TAG_BORDER,
         "AprilTag size must be positive and border at least RM_TAG_BORDER");
  outer = [tag[0]+2*border,tag[1]+2*border];
  lock_x = grid_station_outside(outer[0]/2+RM_M3_HEAD_CLEARANCE_D/2);
  difference() {
    union() {
      difference() {
        translate([-outer[0]/2,-outer[1]/2,0])
          rounded_box([outer[0],outer[1],RM_JOIN_T],RM_ADAPTER_R);
        translate([-tag[0]/2,-tag[1]/2,-RM_EPS])
          cube([tag[0],tag[1],RM_JOIN_T+2*RM_EPS]);
      }
      for(side=[-1,1])
        linear_extrude(height=RM_JOIN_T) hull() {
          translate([side*lock_x,0]) circle(d=RM_GRID);
          translate([side*(outer[0]/2-border/2),0])
            square([border,2*border],center=true);
        }
      for(x=[-tag[0]/2-border,tag[0]/2-RM_TAG_TAB],
          y=[-tag[1]/2-border,tag[1]/2-RM_TAG_TAB]) {
        translate([x,y,0])
          cube([RM_TAG_TAB+border,RM_TAG_TAB+border,RM_JOIN_T-1]);
        translate([x,y,RM_JOIN_T-RM_TAG_CARD_T])
          cube([RM_TAG_TAB+border,RM_TAG_TAB+border,RM_TAG_CARD_T]);
      }
      for(x=[-lock_x,lock_x]) translate([x,0,0]) connector_peg();
    }
    for(x=[-lock_x,lock_x])
      translate([x,0,0]) connector_screw_cut(body_t=RM_JOIN_T);
  }
}

module tripod_adapter() {
  lock_x = 3*RM_GRID/2;
  difference() {
    union() {
      translate([-2*RM_GRID,-RM_GRID,0])
        rounded_box([4*RM_GRID,2*RM_GRID,RM_TRIPOD_BODY_T],RM_ADAPTER_R);
      for(x=[-lock_x,lock_x])
        translate([x,0,RM_TRIPOD_BODY_T]) connector_peg("up");
    }
    for(x=[-lock_x,lock_x]) {
      translate([x,0,RM_TRIPOD_BODY_T])
        connector_screw_cut("up",RM_TRIPOD_BODY_T);
      translate([x,0,-RM_EPS])
        cylinder(h=RM_TRIPOD_BODY_T-RM_JOIN_T+RM_EPS,
                 d=RM_M3_HEAD_CLEARANCE_D);
    }
    translate([0,0,RM_TRIPOD_BODY_T-RM_TRIPOD_NUT_H])
      hexagonal_prism(RM_TRIPOD_NUT_H+RM_EPS,RM_TRIPOD_NUT_AF);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_TRIPOD_BODY_T+2*RM_EPS,d=RM_TRIPOD_CLEARANCE_D);
  }
}

module profile_2020_adapter() {
  difference() {
    translate([-2*RM_GRID,-RM_GRID,0])
      rounded_box([4*RM_GRID,2*RM_GRID,RM_JOIN_T],RM_ADAPTER_R);
    for(x=grid_positions(2))
      translate([x,0,RM_JOIN_T]) mirror([0,0,1]) port_cut();
    for(x=[-3*RM_GRID/2,3*RM_GRID/2])
      translate([x,0,-RM_EPS])
        cylinder(h=RM_JOIN_T+2*RM_EPS,d=RM_M5_CLEARANCE_D);
  }
}

module din_hook(side,length) {
  rail_edge = RM_DIN_WIDTH/2+RM_DIN_CLEARANCE/2;
  x = side*(rail_edge+RM_DIN_HOOK_T/2);
  translate([x,0,-RM_DIN_HOOK_DEPTH/2])
    cube([RM_DIN_HOOK_T,length,RM_DIN_HOOK_DEPTH],center=true);
  translate([side*(rail_edge-RM_DIN_HOOK_T/2),0,
             -RM_DIN_HOOK_DEPTH-RM_DIN_LIP_T/2])
    cube([2*RM_DIN_HOOK_T,length,RM_DIN_LIP_T],center=true);
}

// Rigid end-slide adapter for EN 60715 TH35 rail.
module din_rail_adapter() {
  size = [4*RM_GRID,3*RM_GRID,RM_JOIN_T];
  difference() {
    union() {
      translate([-size[0]/2,-size[1]/2,0])
        rounded_box(size,RM_ADAPTER_R);
      din_hook(-1,size[1]);
      din_hook(1,size[1]);
    }
    for(x=grid_positions(2),y=grid_positions(2))
      translate([x,y,RM_JOIN_T]) mirror([0,0,1]) port_cut();
  }
}

module grove_cable_clip() {
  inner_w = RM_CABLE_W+0.5;
  difference() {
    union() {
      translate([-RM_GRID,-6,0])
        rounded_box([2*RM_GRID,12,RM_JOIN_T],RM_ADAPTER_R);
      translate([-RM_GRID/2,0,0]) connector_peg();
      translate([-2,-5,RM_JOIN_T])
        difference() {
          cube([12,10,6]);
          translate([(12-inner_w)/2,-RM_EPS,1.5])
            cube([inner_w,10+2*RM_EPS,RM_CABLE_H+2.4]);
          translate([(12-(RM_CABLE_W-1.5))/2,-2*RM_EPS,4])
            cube([RM_CABLE_W-1.5,10+4*RM_EPS,3]);
        }
    }
    translate([-RM_GRID/2,0,0]) connector_screw_cut(body_t=RM_JOIN_T);
  }
}

// Calibration parts.
function test_male_x(i) =
  (i-(len(RM_TEST_MALE_FITS)-1)/2)*RM_TEST_PAD_PITCH;
function test_insert_x(i) =
  (i-(len(RM_TEST_INSERT_BORES)-1)/2)*RM_TEST_INSERT_PITCH;

module tolerance_male_set() {
  for(i=[0:len(RM_TEST_MALE_FITS)-1])
    translate([test_male_x(i),0,0]) difference() {
      union() {
        translate([-RM_TEST_PAD_SIZE/2,-RM_TEST_PAD_SIZE/2,0])
          rounded_box([RM_TEST_PAD_SIZE,RM_TEST_PAD_SIZE,RM_JOIN_T],
                      RM_TEST_PAD_R);
        connector_peg(fit=RM_TEST_MALE_FITS[i]);
      }
      connector_screw_cut(body_t=RM_JOIN_T);
      if(i > 0)
        for(mark=[1:i])
          translate([-RM_TEST_PAD_SIZE/2+mark*2,-RM_TEST_PAD_SIZE/2,-RM_EPS])
            cube([1,2,RM_JOIN_T+2*RM_EPS]);
    }
}

module tolerance_female_tile() {
  size = grid_size(2);
  difference() {
    translate([-size/2,-size/2,0])
      rounded_box([size,size,RM_PLATE_T],RM_TEST_TILE_R);
    for(x=grid_positions(2),y=grid_positions(2))
      translate([x,y,RM_PLATE_T]) mirror([0,0,1]) port_cut();
  }
}

module tolerance_insert_set() {
  length = RM_TEST_INSERT_PAD+
           (len(RM_TEST_INSERT_BORES)-1)*RM_TEST_INSERT_PITCH;
  difference() {
    translate([-length/2,-RM_TEST_INSERT_PAD/2,0])
      rounded_box([length,RM_TEST_INSERT_PAD,RM_PLATE_T],RM_TEST_INSERT_R);
    for(i=[0:len(RM_TEST_INSERT_BORES)-1]) {
      translate([test_insert_x(i),0,RM_PLATE_T])
        mirror([0,0,1]) port_cut(bore=RM_TEST_INSERT_BORES[i]);
      if(i > 0)
        for(mark=[1:i])
          translate([test_insert_x(i)-RM_TEST_INSERT_PAD/2+mark*2,
                     -RM_TEST_INSERT_PAD/2,-RM_EPS])
            cube([1,2,RM_PLATE_T+2*RM_EPS]);
    }
  }
}
