include <rm_common.scad>

PART="flat"; // flat, angle, flat_gasket or angle_gasket
LENGTH=40; // 40 or 80 mm
assert(PART=="flat" || PART=="angle" ||
       PART=="flat_gasket" || PART=="angle_gasket",
       "Unknown connector");
assert(LENGTH%RM_UNIT == 0, "Connector length must use 40 mm units");

if(PART=="flat") flat_link(LENGTH);
if(PART=="angle") angle_link(LENGTH);
if(PART=="flat_gasket") flat_gasket(LENGTH);
if(PART=="angle_gasket") angle_gasket(LENGTH);
