include <../lib/robotskin.scad>

assert(grid_size(8) == 80 && grid_size(3) == 30,
       "Plate size must be derived from its port count");
assert(2*RM_PLATE_T == 8 && RM_STS3215_HUB_RADIUS == 7,
       "The H25T horn plate must remain a double-thickness 3x3 interface");
assert(grid_size(3) == 30 && RM_M3_CLEARANCE < RM_INSERT_BORE,
       "The H25T hub must retain its 30 mm body and M3 lock paths");
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
       "Grove board and RobotSkin stations must remain grid-derived");
assert(grid_station_outside(31) == 35 && grid_station_outside(28) == 35,
       "External lock stations must remain on the RobotSkin grid");
assert(RM_TRIPOD_BODY_T-RM_TRIPOD_NUT_H >= 2,
       "Tripod nut pocket must retain a structural roof");
uno_holes = centred_points(RM_UNO_HOLES,RM_UNO_SIZE);
assert(near(uno_holes[0][0],-20.29) && near(uno_holes[0][1],-24.13) &&
       near(uno_holes[2][0],31.75) && near(uno_holes[2][1],8.89),
       "UNO mounting holes must retain the official asymmetric layout");
assert(RM_UNO_LOCK_X+RM_GRID/2 < RM_UNO_SIZE[0]/2 &&
       RM_UNO_LOCK_Y+RM_GRID/2 < RM_UNO_SIZE[1]/2,
       "UNO RobotSkin locks must remain hidden below the board");
assert(RM_RPI5_SIZE == [85,56] &&
       RM_WAVESHARE_USB_C_SIZE == [87,37.5] &&
       RM_WAVESHARE_USB_C_HOLE_SPACING == [58,30.5],
       "Raspberry Pi 5 and Waveshare Board (C) footprints must remain exact");
assert(RM_RPI5_USB_CARRIER_SIZE[0] >=
       RM_RPI5_SIZE[1]+RM_RPI5_USB_GAP+RM_WAVESHARE_USB_C_SIZE[1] &&
       RM_RPI5_USB_CARRIER_SIZE[1] >= RM_WAVESHARE_USB_C_SIZE[0],
       "Raspberry Pi 5 carrier must retain both PCB clearances");
assert(len(rpi5_usb_locks()) == 8 &&
       len(waveshare_usb_c_holes()) == 4,
       "Raspberry Pi 5 carrier needs eight RobotSkin locks and four USB-board mounts");
assert(near(-39+RM_GRID/2,-29-RM_GRID/2) &&
       near(19+RM_GRID/2,29-RM_GRID/2),
       "Raspberry Pi 5 and Waveshare screw rows must stay aligned");
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
translate([0,-50,0]) plate(3,3,thickness=2*RM_PLATE_T);
translate([50,-50,0]) h25t_horn_plate_3x3();
translate([100,-50,0]) h25t_port_cube_3x3();
translate([0,50,0]) through_plate(5,3);
translate([0,100,0]) through_plate(5,8);
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
translate([380,100,0]) uno_carrier();
translate([500,100,0]) rpi5_usb_carrier();
translate([100,0,0]) connector_grid(2,2,direction="up");
translate([130,0,0])
  difference() {
    cube([grid_size(2),grid_size(2),RM_PLATE_T],center=true);
    connector_grid(2,2,direction="up",cut=true,body_t=RM_PLATE_T);
  }
