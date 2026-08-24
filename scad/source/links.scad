include <rm_common.scad>

PART="flat"; // flat or angle
LENGTH=40;   // 40 or 80 mm
assert(PART=="flat" || PART=="angle", "Unknown link");
assert(LENGTH%RM_UNIT == 0, "Link length must use 40 mm units");

if(PART=="flat") flat_link(LENGTH);
if(PART=="angle") angle_link(LENGTH);
