include <../lib/robotmind.scad>

assert(grid_size(8) == 80 && grid_size(3) == 30,
       "Plate size must be derived from its port count");
assert(grid_positions(2) == [-5,5] &&
       grid_positions(3) == [-10,0,10] &&
       grid_positions(8) == [-35,-25,-15,-5,5,15,25,35],
       "Every grid must remain centred at 10 mm pitch");
assert(edge_rows(2) == [5,15] && flat_rows(2) == [-15,-5,5,15],
       "Join rows must derive from their depth port count");
assert(outer_rows(2) == [9,19],
       "Outer joins must offset their rows by plate thickness");
assert(is_corner_index(0,0,8,8) && is_corner_index(7,7,8,8) &&
       is_corner_index(2,4,3,5) && !is_corner_index(1,1,3,5),
       "Corner mounting ports must work for every plate size");
assert(grove_hole_spacing([20,20]) == [16,16] &&
       grove_hole_spacing([40,60]) == [36,56] &&
       grove_lock_x(20) == 15 && grove_lock_x(40) == 25,
       "Grove board and RobotMind stations must remain grid-derived");
assert(grid_station_outside(31) == 35 && grid_station_outside(28) == 35,
       "External lock stations must remain on the RobotMind grid");
assert(RM_TRIPOD_BODY_T-RM_TRIPOD_NUT_H >= 2,
       "Tripod nut pocket must retain a structural roof");
assert(RM_TEST_MALE_FITS == [0,0.05,0.10,0.15,0.20],
       "Tolerance coupon must retain its documented five male fits");
assert(RM_TEST_INSERT_BORES == [3.75,3.80,3.85,3.90,3.95],
       "Insert coupon must retain its documented five pilot bores");
for(bore=RM_TEST_INSERT_BORES)
  assert(bore < RM_INSERT_OD && bore > RM_M3_CLEARANCE,
         "Every insert pilot must be below insert OD and above M3 clearance");
for(fit=RM_TEST_MALE_FITS)
  assert(peg_root_af(fit) > port_af(0) && port_af(0) > peg_tip_af(fit),
         "Every coupon peg must fit the nominal female port");

// Small alternate instances keep the parameterized public API executable.
plate(2,3);
translate([30,0,0]) flat_join(1,1);
translate([50,0,0]) angle_join(1,1);
translate([75,0,0]) outer_angle_join(1,1);
translate([100,40,0]) grove_carrier([20,40]);
translate([100,100,0]) grove_carrier([40,60]);
translate([150,60,0]) apriltag_holder(20);
translate([190,60,0]) tripod_adapter();
translate([230,60,0]) profile_2020_adapter();
translate([270,60,0]) din_rail_adapter();
translate([310,60,0]) grove_cable_clip();
translate([100,0,0]) connector_grid(2,2,direction="up");
translate([130,0,0])
  difference() {
    cube([grid_size(2),grid_size(2),RM_PLATE_T],center=true);
    connector_grid(2,2,direction="up",cut=true,body_t=RM_PLATE_T);
  }
