include <rm_common.scad>

PLATE=[80,80]; // 40×40, 80×40 or 80×80 mm
SHELL="assembly"; // assembly, a or b
assert(SHELL=="assembly" || SHELL=="a" || SHELL=="b",
       "Unknown injection shell");

if(SHELL=="assembly") injection_plate_assembly(PLATE);
if(SHELL=="a")
  translate([0,0,RM_PLATE_T/2]) rotate([180,0,0])
    injection_shell_a(PLATE);
if(SHELL=="b")
  translate([0,0,-RM_PLATE_T/2]) injection_shell_b(PLATE);
