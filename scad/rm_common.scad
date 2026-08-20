// RobotMind Modular Ecosystem — common library
// Rev A concept for FDM prototyping.
$fn = 48;

// ---- Global mechanical interface ----
RM_DOCK_W = 30;
RM_DOCK_L = 34;
RM_DOCK_H = 5;
RM_RAIL_H = 2.6;
RM_RAIL_W = 3.2;
RM_RAIL_INSET = 3.8;
RM_CLEARANCE = 0.28;   // FDM sliding clearance per side
RM_LATCH_W = 7;
RM_LATCH_L = 9;
RM_LATCH_T = 1.6;
RM_LATCH_HOOK = 1.1;
RM_M3 = 3.3;

module rounded_box(size=[20,20,3], r=2, center=false) {
    x=size[0]; y=size[1]; z=size[2];
    translate(center ? [-x/2,-y/2,-z/2] : [0,0,0])
    linear_extrude(height=z)
      offset(r=r)
      offset(delta=-r)
      square([x,y]);
}

// Male dovetail rail. The simplified trapezoid is robust in FDM and moldable.
module dovetail_rail(len=RM_DOCK_L-4) {
    w=RM_RAIL_W; h=RM_RAIL_H;
    linear_extrude(height=len)
      polygon(points=[[-w/2,0],[w/2,0],[w/2+1.0,h],[-w/2-1.0,h]]);
}

// Female channel cutter, slightly oversized.
module dovetail_channel(len=RM_DOCK_L) {
    w=RM_RAIL_W+2*RM_CLEARANCE; h=RM_RAIL_H+RM_CLEARANCE;
    linear_extrude(height=len)
      polygon(points=[[-w/2,0],[w/2,0],[w/2+1.15,h],[-w/2-1.15,h]]);
}

module male_interface() {
    // Interface origin centered X/Y, bottom at Z=0.
    for (sx=[-1,1])
      translate([sx*(RM_DOCK_W/2-RM_RAIL_INSET), -RM_DOCK_L/2+2, 0])
        rotate([-90,0,0]) dovetail_rail();
    // central catch boss engaged by dock latch
    translate([-RM_LATCH_W/2, RM_DOCK_L/2-7, 0])
      cube([RM_LATCH_W,4,1.25]);
}

module dock_body_base() {
    difference(){
      rounded_box([RM_DOCK_W,RM_DOCK_L,RM_DOCK_H],2.2,center=true);
      // open female dovetails from insertion side
      for (sx=[-1,1])
        translate([sx*(RM_DOCK_W/2-RM_RAIL_INSET), -RM_DOCK_L/2-0.2, -RM_DOCK_H/2+1.1])
          rotate([-90,0,0]) dovetail_channel(len=RM_DOCK_L+1);
      // four M3 mounting holes
      for(x=[-10.5,10.5], y=[-12,12]) translate([x,y,0]) cylinder(h=RM_DOCK_H+2,d=RM_M3,center=true);
      // latch relief window
      translate([-RM_LATCH_W/2-0.5, RM_DOCK_L/2-11, -RM_DOCK_H/2-0.1]) cube([RM_LATCH_W+1,11,RM_DOCK_H+1]);
    }
}

module latch_finger() {
    // flexible cantilever integrated at back of dock
    translate([-RM_LATCH_W/2, RM_DOCK_L/2-10, -RM_DOCK_H/2+0.7]) {
      cube([RM_LATCH_W,RM_LATCH_L,RM_LATCH_T]);
      translate([0,RM_LATCH_L-1.4,RM_LATCH_T]) cube([RM_LATCH_W,1.4,RM_LATCH_HOOK]);
      // thumb tab
      translate([-1.2,RM_LATCH_L-0.8,-0.2]) cube([RM_LATCH_W+2.4,3,RM_LATCH_T+0.4]);
    }
}

module universal_dock() {
    union(){ dock_body_base(); latch_finger(); }
}

module sensor_carrier(pcb=[20,20], wall=1.7, floor=1.8, clearance=0.5) {
    // carrier top tray centered; universal male interface below
    W=pcb[0]+2*(wall+clearance);
    L=pcb[1]+2*(wall+clearance);
    union(){
      translate([-W/2,-L/2,0]) difference(){
        rounded_box([W,L,floor+3.1],2);
        translate([wall,wall,floor]) rounded_box([pcb[0]+2*clearance,pcb[1]+2*clearance,5],1.0);
        // cable exit on front edge
        translate([W/2-6,-0.2,floor+0.5]) cube([12,wall+1,3.5]);
      }
      // small retention lips; gentle, printable snap
      for(x=[-W/2+2.2,W/2-2.2], y=[-L/2+2.2,L/2-2.2])
         translate([x,y,floor+2.5]) cylinder(h=1.3,d=2.2);
      translate([0,0,-RM_RAIL_H]) male_interface();
    }
}

module tag_insert(tag=[60,60], border=3.0, t=1.0) {
    W=tag[0]+2*border; H=tag[1]+2*border;
    union(){
      translate([-W/2,-H/2,0]) rounded_box([W,H,t],1.2);
      translate([-8,-H/2-4,0]) rounded_box([16,5,t],1.2);
    }
}

module tag_insert_rails(tag=[60,60], border=4, rail=1.5, depth=2.2) {
    W=tag[0]+2*border; H=tag[1]+2*border;
    // rails intended to capture tag insert edges
    for(sx=[-1,1]) translate([sx*(W/2-rail/2),0,0]) cube([rail,H,depth],center=true);
    translate([0,H/2-rail/2,0]) cube([W,rail,depth],center=true); // hard stop
}

module angle_wedge(angle=15) {
    // solid wedge with top angled; child dock can be placed on top by caller
    W=RM_DOCK_W+4; L=RM_DOCK_L+4; min_h=3; dh=tan(angle)*L;
    polyhedron(points=[
      [-W/2,-L/2,0],[W/2,-L/2,0],[W/2,L/2,0],[-W/2,L/2,0],
      [-W/2,-L/2,min_h],[W/2,-L/2,min_h],[W/2,L/2,min_h+dh],[-W/2,L/2,min_h+dh]
    ], faces=[[0,1,2,3],[4,7,6,5],[0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0]]);
}
