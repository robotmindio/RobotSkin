include <rm_common.scad>

PART="pin"; // pin, flat or angle
assert(PART=="pin" || PART=="flat" || PART=="angle",
       "Unknown connector");

if(PART=="pin") push_pin();
if(PART=="flat") flat_link();
if(PART=="angle") angle_link();
