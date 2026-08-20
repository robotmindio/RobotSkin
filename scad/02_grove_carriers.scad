include <rm_common.scad>

PCB=[20,20];
W=PCB[0]+2*(1.7+0.5);
print_on_x_edge(W) sensor_carrier(PCB);
