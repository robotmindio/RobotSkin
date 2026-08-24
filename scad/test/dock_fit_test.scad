include <../source/rm_common.scad>

// Real-profile mating check: front entry, captured head, and a rear stop.
universal_dock();
translate([0,docked_carrier_y(),docked_carrier_z()]) male_interface();
