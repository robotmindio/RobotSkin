// RobotSkin public design library.
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
RM_STS3215_HUB_RADIUS = 7;
RM_H25T_HUB_HOLE_D = RM_M3_CLEARANCE;
RM_H25T_HUB_COUNTERBORE_DEPTH = 3;
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
RM_UNO_SIZE = [68.58,53.34];
RM_UNO_HOLES = [[14,2.54],[66.04,7.62],[66.04,35.56],[15.24,50.8]];
RM_UNO_BORDER = 4;
RM_UNO_STANDOFF_H = 5;
RM_UNO_STANDOFF_D = 7;
RM_UNO_LOCK_X = 15;
RM_UNO_LOCK_Y = 15;
RM_LD06_HOLE_D = 2.4;
RM_LD06_HOLE_SPACING = 28.2;

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
function inside_wall_rows(depth_ports,plate_t=RM_PLATE_T) =
  [for(row=edge_rows(depth_ports)) row-plate_t];
function grove_hole_spacing(board_size) =
  [board_size[0]-RM_GROVE_EDGE,board_size[1]-RM_GROVE_EDGE];
function grove_lock_x(board_width) = board_width/2+RM_GRID/2;
function grid_station_outside(distance) =
  ceil((distance-RM_GRID/2)/RM_GRID)*RM_GRID+RM_GRID/2;
function centred_points(points,size) =
  [for(point=points) [point[0]-size[0]/2,point[1]-size[1]/2]];
function near(a,b,tolerance=0.001) = abs(a-b) <= tolerance;
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

// Heat-set insert pocket. Subtract downward from an exposed face.
module heat_set_insert_cut(bore=RM_INSERT_BORE) {
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_DEPTH+RM_EPS,d=bore);
  translate([0,0,-RM_EPS])
    cylinder(h=RM_INSERT_LEAD+RM_EPS,d1=insert_entry_d(),d2=bore);
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
  heat_set_insert_cut(pilot);
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
module plate_body(columns,rows,thickness=RM_PLATE_T) {
  translate([-grid_size(columns)/2,-grid_size(rows)/2,0])
    rounded_box([grid_size(columns),grid_size(rows),thickness],RM_PLATE_R);
}

module plate_port_cuts(columns,rows,thickness=RM_PLATE_T) {
  for(column=[0:columns-1],row=[0:rows-1])
    translate([grid_positions(columns)[column],
               grid_positions(rows)[row],thickness])
      mirror([0,0,1]) port_cut();
}

module plate_corner_through_cuts(columns,rows,thickness=RM_PLATE_T) {
  for(column=[0:columns-1],row=[0:rows-1])
    if(is_corner_index(column,row,columns,rows))
      translate([grid_positions(columns)[column],grid_positions(rows)[row],
                 -RM_EPS])
        cylinder(h=thickness+2*RM_EPS,d=RM_M3_CLEARANCE);
}

module plate_all_through_cuts(columns,rows,thickness=RM_PLATE_T) {
  for(x=grid_positions(columns),y=grid_positions(rows))
    translate([x,y,-RM_EPS])
      cylinder(h=thickness+2*RM_EPS,d=RM_M3_CLEARANCE);
}

// Public plate: dimensions are port counts, not millimetres.
module plate(columns,rows,thickness=RM_PLATE_T) {
  assert(columns >= 2 && rows >= 2 &&
         columns == floor(columns) && rows == floor(rows),
         "Plate dimensions must be integers of at least 2x2");
  assert(thickness >= RM_PLATE_T,
         "Plate thickness must retain the 4 mm interface minimum");
  difference() {
    plate_body(columns,rows,thickness);
    plate_port_cuts(columns,rows,thickness);
    plate_corner_through_cuts(columns,rows,thickness);
  }
}

// Plate with an M3 clearance path through every otherwise standard port.
module through_plate(columns,rows,thickness=RM_PLATE_T) {
  assert(columns >= 2 && rows >= 2 &&
         columns == floor(columns) && rows == floor(rows),
         "Through-plate dimensions must be integers of at least 2x2");
  assert(thickness >= RM_PLATE_T,
         "Plate thickness must retain the 4 mm interface minimum");
  difference() {
    plate_body(columns,rows,thickness);
    plate_port_cuts(columns,rows,thickness);
    plate_all_through_cuts(columns,rows,thickness);
  }
}

// LeKiwi top plate: 3x5 RobotSkin end, flat LD06 end, and wheel clearance.
module lekiwi_lidar_base(ld06_hole_d=RM_LD06_HOLE_D) {
  assert(ld06_hole_d >= 2 && ld06_hole_d <= 3,
         "LD06 M2 clearance must stay within 2..3 mm");
  difference() {
    union() {
      translate([0,0,RM_PLATE_T])
        linear_extrude(height=2*RM_PLATE_T)
          offset(r=RM_GRID/2) offset(delta=-RM_GRID/2)
            polygon([[-40,-25],[40,-25],[40,15],[-10,15],
                     [-10,25],[-40,25]]);
      translate([-40,-25,0])
        rounded_box([30,50,RM_PLATE_T],RM_GRID/2);
    }
    for(x=[-35,-25,-15,-5],y=grid_positions(5))
      if(x != -5 || y != 20)
        translate([x,y,3*RM_PLATE_T]) mirror([0,0,1]) port_cut();
    for(x=[-35,-25,-15,-5],y=grid_positions(5))
      if(x != -5 || y != 20)
        translate([x,y,-RM_EPS])
          cylinder(h=3*RM_PLATE_T+2*RM_EPS,d=RM_M3_CLEARANCE);
    for(side=[-1,1])
      translate([20+side*RM_LD06_HOLE_SPACING/2,
                 -5+side*RM_LD06_HOLE_SPACING/2,
                 RM_PLATE_T-RM_EPS])
        cylinder(h=2*RM_PLATE_T+2*RM_EPS,d=ld06_hole_d);
  }
}

// 3x3 drive plate for the LeRobot STS3215 H25T horn.  Its 4xM3 horn holes
// sit 7 mm from the centre, so the four corner stations remain RobotSkin.
// The underside pocket clears the horn's centre-screw head; install that
// supplied screw before bolting this plate to the horn.
module h25t_horn_plate_3x3(thickness=2*RM_PLATE_T,
                            hub_radius=RM_STS3215_HUB_RADIUS) {
  assert(thickness >= 2*RM_PLATE_T,
         "The H25T horn plate requires 8 mm thickness");
  assert(hub_radius > 0 && hub_radius < RM_GRID,
         "STS3215 horn radius must fit inside the 3x3 plate");
  difference() {
    plate_body(3,3,thickness);
    for(x=grid_positions(3),y=grid_positions(3))
      if(x != 0 && y != 0)
        translate([x,y,thickness]) mirror([0,0,1]) port_cut();
    plate_corner_through_cuts(3,3,thickness);
    translate([0,0,-RM_EPS])
      cylinder(h=thickness+2*RM_EPS,d=RM_M3_CLEARANCE);
    translate([0,0,-RM_EPS])
      cylinder(h=RM_H25T_HUB_COUNTERBORE_DEPTH+RM_EPS,
               d=RM_M3_HEAD_CLEARANCE_D);
    for(angle=[0:90:270])
      rotate([0,0,angle]) translate([hub_radius,0,0]) {
      translate([0,0,-RM_EPS])
        cylinder(h=thickness+2*RM_EPS,d=RM_H25T_HUB_HOLE_D);
      translate([0,0,thickness-RM_H25T_HUB_COUNTERBORE_DEPTH])
        cylinder(h=RM_H25T_HUB_COUNTERBORE_DEPTH+RM_EPS,
                 d=RM_M3_HEAD_CLEARANCE_D);
      }
  }
}

// Single-print 30x30 mm end-effector hub for the H25T drive plate.  The top
// has five ports (centre plus corners); each vertical face has its central
// vertical line of three full ports.  Four M3x35 screws lock the hub.
module h25t_port_cube_3x3() {
  size = grid_size(3);
  difference() {
    union() {
      translate([-size/2,-size/2,0])
        rounded_box([size,size,size],RM_PLATE_R);
      for(x=grid_positions(3),y=grid_positions(3))
        if(x != 0 && y != 0)
          translate([x,y,0]) connector_peg();
    }
    // Top face.
    for(x=grid_positions(3),y=grid_positions(3))
      if((x == 0 && y == 0) || (x != 0 && y != 0))
        translate([x,y,size]) mirror([0,0,1]) port_cut();
    // Front, back, left, and right faces; Z uses the same 3x3 grid.
    for(x=grid_positions(3),z=grid_positions(3)) {
      if(x == 0) {
        translate([x,-size/2,z+size/2]) rotate([-90,0,0]) port_cut();
        translate([x,size/2,z+size/2]) rotate([90,0,0]) port_cut();
      }
    }
    for(y=grid_positions(3),z=grid_positions(3)) {
      if(y == 0) {
        translate([-size/2,y,z+size/2]) rotate([0,90,0]) port_cut();
        translate([size/2,y,z+size/2]) rotate([0,-90,0]) port_cut();
      }
    }
    for(x=grid_positions(3),y=grid_positions(3))
      if(x != 0 && y != 0)
        translate([x,y,0]) connector_screw_cut(body_t=size);
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
    translate([0,0,-plate_t])
      rotate([90,0,0]) mirror([0,1,0]) join_leg(width,depth+plate_t);
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
  floor_rows = edge_rows(depth_ports);
  wall_rows = inside_wall_rows(depth_ports);
  difference() {
    union() {
      corner_body(width,depth_ports);
      for(x=grid_positions(width_ports),y=floor_rows)
        translate([x,-y,0]) connector_peg();
      for(x=grid_positions(width_ports),z=wall_rows)
        translate([x,0,z]) connector_peg("forward");
    }
    for(x=grid_positions(width_ports),y=floor_rows)
      translate([x,-y,0]) connector_screw_cut();
    for(x=grid_positions(width_ports),z=wall_rows)
      translate([x,0,z]) connector_screw_cut("forward");
  }
}

module outer_angle_join(width_ports=2,depth_ports=2,plate_t=RM_PLATE_T) {
  assert(width_ports >= 1 && width_ports == floor(width_ports),
         "width_ports must be a positive integer");
  assert(depth_ports >= 1 && depth_ports == floor(depth_ports),
         "depth_ports must be a positive integer");
  width = grid_size(width_ports);
  floor_rows = outer_rows(depth_ports,plate_t);
  wall_rows = edge_rows(depth_ports);
  difference() {
    union() {
      corner_body(width,depth_ports,outer=true,plate_t=plate_t);
      for(x=grid_positions(width_ports),y=floor_rows)
        translate([x,-y,0]) connector_peg("up");
      for(x=grid_positions(width_ports),z=wall_rows)
        translate([x,0,z]) connector_peg("backward");
    }
    for(x=grid_positions(width_ports),y=floor_rows)
      translate([x,-y,0]) connector_screw_cut("up");
    for(x=grid_positions(width_ports),z=wall_rows)
      translate([x,0,z]) connector_screw_cut("backward");
  }
}

module pcb_standoff(position) {
  translate([position[0],position[1],RM_CARRIER_T-RM_EPS])
    cylinder(h=RM_GROVE_STANDOFF_H+RM_EPS,d=RM_GROVE_STANDOFF_D);
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

module uno_standoff(position,cut=false) {
  if(cut)
    translate([position[0],position[1],
               RM_CARRIER_T+RM_UNO_STANDOFF_H])
      mirror([0,0,1])
        heat_set_insert_cut();
  else
    translate([position[0],position[1],RM_CARRIER_T-RM_EPS])
      cylinder(h=RM_UNO_STANDOFF_H+RM_EPS,d=RM_UNO_STANDOFF_D);
}

module uno_carrier() {
  holes = centred_points(RM_UNO_HOLES,RM_UNO_SIZE);
  outer = [RM_UNO_SIZE[0]+2*RM_UNO_BORDER,
           RM_UNO_SIZE[1]+2*RM_UNO_BORDER];
  locks = [for(x=[-RM_UNO_LOCK_X,RM_UNO_LOCK_X],
               y=[-RM_UNO_LOCK_Y,RM_UNO_LOCK_Y]) [x,y]];
  difference() {
    union() {
      translate([-outer[0]/2,-outer[1]/2,0])
        rounded_box([outer[0],outer[1],RM_CARRIER_T],RM_ADAPTER_R);
      for(position=holes) uno_standoff(position);
      for(position=locks) {
        translate([position[0],position[1],0]) connector_peg();
      }
    }
    for(position=holes) uno_standoff(position,cut=true);
    for(position=locks)
      translate([position[0],position[1],0])
        connector_screw_cut(body_t=RM_CARRIER_T);
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
