include <rm_common.scad>
// Set SIZE to one of 0..4 before export.
SIZE = 0;
sizes=[[20,20],[20,40],[20,60],[40,40],[40,60]];
sensor_carrier(sizes[SIZE]);
