include <../lib/robotskin.scad>

SCENE = "overview"; // overview, port, flat, angle, outer_angle, grove, grove_family, uno, adapters
assert(SCENE=="overview" || SCENE=="port" || SCENE=="flat" || SCENE=="angle" ||
       SCENE=="outer_angle" || SCENE=="grove" || SCENE=="grove_family" ||
       SCENE=="uno" || SCENE=="adapters",
       "Unknown preview scene");

PLATE_COLOR = [0.60,0.72,0.84];
JOIN_COLOR = [1.00,0.68,0.05];
CARRIER_COLOR = [0.16,0.38,0.64];
INSERT_COLOR = [0.72,0.42,0.08];

module insert_demo() {
  color(INSERT_COLOR) heat_set_insert();
}

module overview_scene() {
  color(PLATE_COLOR) translate([-55,0,0]) plate(8,8);
  color(JOIN_COLOR) translate([45,-30,0]) flat_join();
  color(JOIN_COLOR) translate([45,35,0]) angle_join();
  color(JOIN_COLOR) translate([145,30,0]) outer_angle_join();
  color(CARRIER_COLOR) translate([105,-20,0]) grove_carrier();
}

module port_scene() {
  // Half section shows the actual plate port, seated insert, and joined peg.
  color(PLATE_COLOR) intersection() {
    difference() {
      translate([-10,-10,0]) rounded_box([20,20,RM_PLATE_T],2);
      translate([0,0,RM_PLATE_T]) mirror([0,0,1]) port_cut();
    }
    translate([-10,0,-RM_EPS]) cube([20,10,RM_PLATE_T+2*RM_EPS]);
  }
  color(JOIN_COLOR) intersection() {
    difference() {
      union() {
        translate([-8,-8,RM_PLATE_T]) rounded_box([16,16,RM_JOIN_T],2);
        translate([0,0,RM_PLATE_T]) connector_peg();
      }
      translate([0,0,RM_PLATE_T]) connector_screw_cut();
    }
    translate([-10,0,-RM_EPS]) cube([20,10,RM_PLATE_T+RM_JOIN_T+2*RM_EPS]);
  }
  translate([0,0,RM_PLATE_T-RM_INSERT_DEPTH]) insert_demo();
}

module flat_scene() {
  color(PLATE_COLOR) translate([0,-40,0]) plate(8,8);
  color(PLATE_COLOR) translate([0,40,0]) plate(8,8);
  color(JOIN_COLOR) translate([0,0,RM_PLATE_T]) flat_join();
}

module angle_scene() {
  plate_size = grid_size(8);
  color(PLATE_COLOR) plate(8,8);
  color(PLATE_COLOR)
    translate([0,plate_size/2+RM_PLATE_T,plate_size/2])
      rotate([90,0,0]) plate(8,8);
  color(JOIN_COLOR) translate([0,plate_size/2,RM_PLATE_T]) angle_join();
}

module outer_angle_scene() {
  plate_size = grid_size(8);
  color(PLATE_COLOR) plate(8,8);
  color(PLATE_COLOR)
    translate([0,plate_size/2,plate_size/2])
      rotate([-90,0,0]) plate(8,8);
  color(JOIN_COLOR)
    translate([0,plate_size/2+RM_PLATE_T,0]) outer_angle_join();
}

module grove_scene() {
  color(PLATE_COLOR) plate(5,4);
  color(CARRIER_COLOR) translate([0,0,RM_PLATE_T]) grove_carrier();
  color([0.10,0.55,0.28,0.85])
    translate([-10,-10,RM_PLATE_T+RM_CARRIER_T+RM_GROVE_STANDOFF_H])
      rounded_box([20,20,1.6],1);
}

module grove_family_scene() {
  color(CARRIER_COLOR) translate([-65,-35,0]) grove_carrier([20,20]);
  color(CARRIER_COLOR) translate([-15,-25,0]) grove_carrier([20,40]);
  color(CARRIER_COLOR) translate([35,-15,0]) grove_carrier([20,60]);
  color(CARRIER_COLOR) translate([95,-25,0]) grove_carrier([40,40]);
  color(CARRIER_COLOR) translate([165,-15,0]) grove_carrier([40,60]);
}

module uno_scene() {
  color(PLATE_COLOR) plate(8,8);
  color(CARRIER_COLOR) translate([0,0,RM_PLATE_T]) uno_carrier();
  color([0.32,0.16,0.42,0.85])
    translate([-RM_UNO_SIZE[0]/2,-RM_UNO_SIZE[1]/2,
               RM_PLATE_T+RM_CARRIER_T+RM_UNO_STANDOFF_H])
      rounded_box([RM_UNO_SIZE[0],RM_UNO_SIZE[1],1.6],1.6);
}

module adapters_scene() {
  color(CARRIER_COLOR) translate([-90,20,0]) apriltag_holder(50);
  color(JOIN_COLOR) translate([-20,20,0]) tripod_adapter();
  color(CARRIER_COLOR) translate([35,20,0]) profile_2020_adapter();
  color(CARRIER_COLOR) translate([90,20,0]) din_rail_adapter();
  color(JOIN_COLOR) translate([135,20,0]) grove_cable_clip();
}

if(SCENE=="overview") overview_scene();
if(SCENE=="port") port_scene();
if(SCENE=="flat") flat_scene();
if(SCENE=="angle") angle_scene();
if(SCENE=="outer_angle") outer_angle_scene();
if(SCENE=="grove") grove_scene();
if(SCENE=="grove_family") grove_family_scene();
if(SCENE=="uno") uno_scene();
if(SCENE=="adapters") adapters_scene();
