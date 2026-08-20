// RobotMind modular hex construction system — common geometry.
// All dimensions are millimetres; tune the two clearances for the printer.
$fn = 48;

RM_UNIT = 42;
RM_PANEL_T = 7;
RM_SOCKET_DEPTH = 2.4;
RM_HEX_R = 10.5;
RM_HEX_CLEARANCE = 0.28;
RM_SNAP = 0.30;
RM_HEX_X = sqrt(3) * RM_HEX_R;
RM_HEX_Y = 1.5 * RM_HEX_R;

RM_HINGE_PITCH = 14;
RM_HINGE_LEN = 10;
RM_HINGE_R = 2.0;
RM_HINGE_CLEARANCE = 0.25;
RM_CHANNEL_R = 3.1;
RM_HINGE_Z = RM_CHANNEL_R*cos(22.5);

assert(RM_PANEL_T > 2 * RM_SOCKET_DEPTH,
       "Panel needs a solid web between its two socket faces");

module rounded_box(size=[20,20,3], r=2, center=false) {
  x=size[0]; y=size[1]; z=size[2];
  translate(center ? [-x/2,-y/2,-z/2] : [0,0,0])
    linear_extrude(height=z)
      offset(r=r) offset(delta=-r) square([x,y]);
}

module hex_prism(r=RM_HEX_R, h=1) {
  cylinder(r=r, h=h, $fn=6);
}

// A shallow expanded pocket below the entry lip creates the snap catch.
module top_socket_cut() {
  translate([0,0,RM_PANEL_T-RM_SOCKET_DEPTH])
    hex_prism(RM_HEX_R + RM_SNAP, RM_SOCKET_DEPTH-0.65);
  translate([0,0,RM_PANEL_T-RM_SOCKET_DEPTH+0.65])
    hex_prism(RM_HEX_R, RM_SOCKET_DEPTH+0.1);
}

module bottom_socket_cut() {
  translate([0,0,-0.1]) hex_prism(RM_HEX_R, RM_SOCKET_DEPTH-0.55);
  translate([0,0,0.65])
    hex_prism(RM_HEX_R + RM_SNAP, RM_SOCKET_DEPTH-0.55);
}

module socket_pair() {
  top_socket_cut();
  bottom_socket_cut();
}

// Dense pointy-top honeycomb, clipped to leave material around every edge.
module dense_socket_grid(size=[2*RM_UNIT,2*RM_UNIT]) {
  rows=ceil(size[1]/RM_HEX_Y)+2;
  cols=ceil(size[0]/RM_HEX_X)+2;
  margin=2;
  for(row=[-rows:rows], col=[-cols:cols]) {
    y=(row+0.5)*RM_HEX_Y;
    x=(col + ((abs(row)%2)==1 ? 0.5 : 0))*RM_HEX_X;
    if(abs(x)+RM_HEX_X/2 <= size[0]/2-margin &&
       abs(y)+RM_HEX_R <= size[1]/2-margin)
      translate([x,y,0]) socket_pair();
  }
}

module hinge_bead_segment() {
  rotate([0,90,0]) rotate([0,0,22.5])
    cylinder(h=RM_HINGE_LEN,r=RM_HINGE_R,$fn=8,center=true);
}

module hinge_channel_segment() {
  // Short channels flex over the faceted bead. Its flats detent at 0°/90°.
  rotate([0,90,0]) difference() {
    rotate([0,0,22.5])
      cylinder(h=RM_HINGE_LEN,r=RM_CHANNEL_R,$fn=8,center=true);
    rotate([0,0,22.5])
      cylinder(h=RM_HINGE_LEN+0.2,
               r=RM_HINGE_R+RM_HINGE_CLEARANCE,$fn=8,center=true);
    translate([-1.7,-RM_CHANNEL_R-0.1,-RM_HINGE_LEN/2-0.2])
      cube([3.4,RM_CHANNEL_R+0.2,RM_HINGE_LEN+0.4]);
  }
}

module edge_a(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_HINGE_PITCH/2:
         RM_HINGE_PITCH:
         edge_len/2-RM_HINGE_PITCH/2]) {
    translate([p,panel_half+RM_HINGE_R-0.3,RM_HINGE_Z])
      hinge_bead_segment();
  }
}

module edge_b(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_HINGE_PITCH/2:
         RM_HINGE_PITCH:
         edge_len/2-RM_HINGE_PITCH/2]) {
    translate([p,-panel_half-RM_CHANNEL_R+0.3,RM_HINGE_Z])
      hinge_channel_segment();
  }
}

// Every panel is the same type: bead rails on +X/+Y, snap channels on -X/-Y.
// Rotate panels to select the mating edge; no pins, keys, screws or brackets.
module dock_panel(size=[2*RM_UNIT,2*RM_UNIT]) {
  assert(size[0] % RM_UNIT == 0 && size[1] % RM_UNIT == 0,
         "Panel dimensions must be whole 42 mm units");
  difference() {
    union() {
      translate([-size[0]/2,-size[1]/2,0])
        rounded_box([size[0],size[1],RM_PANEL_T],1.5);
      edge_a(size[0],size[1]/2);
      rotate([0,0,-90]) edge_a(size[1],size[0]/2);
      edge_b(size[0],size[1]/2);
      rotate([0,0,-90]) edge_b(size[1],size[0]/2);
    }
    dense_socket_grid(size);
  }
}

// Printed as part of the carrier. Three slots let the shallow snap ridge flex.
module integral_hex_plug(at=[0,0]) {
  translate([at[0],at[1],0]) difference() {
    union() {
      translate([0,0,-RM_SOCKET_DEPTH+0.25])
        hex_prism(RM_HEX_R-RM_HEX_CLEARANCE,RM_SOCKET_DEPTH+0.05);
      translate([0,0,-RM_SOCKET_DEPTH+0.25])
        hex_prism(RM_HEX_R+RM_SNAP/2,0.55);
    }
    for(a=[0,120,240]) rotate([0,0,a])
      translate([-0.35,0,-RM_SOCKET_DEPTH-0.1])
        cube([0.7,RM_HEX_R+1,RM_SOCKET_DEPTH-0.35]);
  }
}

module two_integral_plugs() {
  for(x=[-RM_HEX_X,RM_HEX_X]) integral_hex_plug([x,0]);
}

module sensor_carrier(pcb=[20,20], wall=1.7, floor=1.8, clearance=0.5) {
  W=pcb[0]+2*(wall+clearance);
  L=pcb[1]+2*(wall+clearance);
  assert(W >= 2*(RM_HEX_R-RM_HEX_CLEARANCE),
         "Carrier is narrower than its integral hex plug");
  union() {
    translate([-W/2,-L/2,0]) difference() {
      rounded_box([W,L,floor+3.1],2);
      translate([wall,wall,floor])
        rounded_box([pcb[0]+2*clearance,pcb[1]+2*clearance,5],1);
      translate([W/2-6,-0.2,floor+0.5]) cube([12,wall+1,3.5]);
    }
    for(x=[-W/2+2.2,W/2-2.2], y=[-L/2+2.2,L/2-2.2])
      translate([x,y,floor+2.5]) cylinder(h=1.3,d=2.2);
    integral_hex_plug();
  }
}

module tag_insert(tag=[60,60], border=3, t=1) {
  W=tag[0]+2*border; H=tag[1]+2*border;
  union() {
    translate([-W/2,-H/2,0]) rounded_box([W,H,t],1.2);
    translate([-8,-H/2-4,0]) rounded_box([16,5,t],1.2);
  }
}

module tag_insert_rails(tag=[60,60], border=4, rail=1.5,
                        depth=2.2, clearance=0.25, lip=0.8, lip_t=0.6) {
  W=tag[0]+2*border; H=tag[1]+2*border;
  for(sx=[-1,1]) {
    x=sx>0 ? W/2+clearance : -W/2-clearance-rail;
    translate([x,-H/2-clearance,0])
      cube([rail,H+2*clearance+rail,depth]);
    translate([sx>0 ? W/2-lip : -W/2-clearance-rail,
               -H/2-clearance,depth-lip_t])
      cube([rail+clearance+lip,H+2*clearance+rail,lip_t]);
  }
  translate([-W/2-clearance-rail,H/2+clearance,0])
    cube([W+2*(clearance+rail),rail,depth]);
}
