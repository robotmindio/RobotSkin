include <../lib/robotskin.scad>

// Measured header bodies; PCB, solder and connector envelopes are nominal.
// This fixture checks geometry, not the strength or fit of an actual print.
MODE = "assembly";

module esp32_board_envelope() {
  pcb_z = esp32_s3_pcb_z();
  header_z = pcb_z+RM_ESP32_S3_DEVKITC_BOARD_T;
  // Exclude the intentional zero-clearance seat contact from boolean tests.
  contact = MODE == "collision" ? 0.01 : 0;
  color([0.08,0.2,0.14,0.65])
    translate([-28.5,-14,pcb_z+contact])
      cube([57,28,RM_ESP32_S3_DEVKITC_BOARD_T-contact]);
  for(y=[-12.5,12.5]) {
    color("Khaki") translate([-27.94,y-1.5,header_z]) cube([55.88,3,2]);
    for(i=[0:21]) {
      color("Silver") translate([-26.67+i*2.54-0.32,y-0.32,header_z+2])
        cube([0.64,0.64,6]);
      color("Silver") translate([-26.67+i*2.54,y,pcb_z-1])
        cylinder(d=2,h=1,$fn=16);
    }
  }
  color("Silver") for(y=[-6,6])
    translate([-30,y-4.5,pcb_z-3.5]) cube([9,9,3.5]);
  color("Silver") translate([7,-9,pcb_z-3.5]) cube([20,18,3.5]);
  color("DarkGreen") translate([27,-9,pcb_z-1]) cube([8,18,1]);
}

module esp32_access_envelope() {
  // Room for two cable plugs at the open USB end.
  for(y=[-6,6]) translate([-45,y-5,5]) cube([15,10,10]);
  // All 44 nominal 2.54 mm jumper bodies can seat above the plastic strips.
  for(y=[-12.5,12.5])
    translate([-27.94,y-1.27,esp32_s3_header_top()]) cube([55.88,2.54,8]);
}

if(MODE == "collision") {
  // A 1 mm cube is the sentinel: any other volume is an unwanted collision.
  translate([100,100,100]) cube(1);
  intersection() {
    esp32_s3_devkitc_carrier();
    union() { esp32_board_envelope(); esp32_access_envelope(); }
  }
  intersection() {
    esp32_board_envelope();
    for(p=esp32_s3_devkitc_locks())
      translate([p[0],p[1],RM_CARRIER_T]) cylinder(d=6.2,h=2.4);
  }
} else if(MODE == "part") {
  esp32_s3_devkitc_carrier();
} else {
  color("Gainsboro") esp32_s3_devkitc_carrier();
  esp32_board_envelope();
}
