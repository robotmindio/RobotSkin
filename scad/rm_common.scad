// RobotMind direct-join hex construction system.
// All dimensions are millimetres; tune the two fits after printing coupons.
$fn = 48;

RM_UNIT = 42;
RM_PANEL_T = 10;

// One carrier joint: a progressive hex press fit plus an optional M3 lock.
RM_SOCKET_DEPTH = 3.4;
RM_HEX_R = 10.5;
RM_HEX_TAPER = 0.28;
RM_HEX_ENTRY_CLEARANCE = 0.24;
RM_HEX_GRIP = 0.08;
RM_HEX_X = sqrt(3) * RM_HEX_R;
RM_HEX_Y = 1.5 * RM_HEX_R;

// Panel-to-panel direct join. Male pins fit the female edge at 0° or the
// female face sockets at 90°. Panel screws are optional at 90°.
RM_JOIN_PITCH = 14;
RM_JOIN_LENGTH = 3.0;
RM_JOIN_R = 2.5;
RM_JOIN_TAPER = 0.18;
RM_JOIN_CLEARANCE = 0.25;
RM_JOIN_SEAT_CLEARANCE = 0.10;
RM_M3_CLEARANCE = 3.4;
RM_M3_PILOT = 2.6;
RM_M3_HEAD = 6.2;
RM_M3_MEMBRANE = 0.3;
RM_M3_BLIND_DEPTH =
  (RM_PANEL_T-2*RM_SOCKET_DEPTH-RM_M3_MEMBRANE)/2;

assert(RM_PANEL_T > 2 * RM_SOCKET_DEPTH,
       "Panel needs a solid web between its two carrier sockets");
assert(RM_M3_BLIND_DEPTH > 0,
       "Panel is too thin for double-sided blind M3 pilots");

module rounded_box(size=[20,20,3], r=2, center=false) {
  x=size[0]; y=size[1]; z=size[2];
  translate(center ? [-x/2,-y/2,-z/2] : [0,0,0])
    linear_extrude(height=z)
      offset(r=r) offset(delta=-r) square([x,y]);
}

module print_on_x_edge(span) {
  translate([0,0,span/2]) rotate([0,90,0]) children();
}

module print_on_y_edge(span) {
  translate([0,0,span/2]) rotate([90,0,0]) children();
}

module hex_frustum(r1=RM_HEX_R, r2=RM_HEX_R, h=1) {
  cylinder(r1=r1,r2=r2,h=h,$fn=6);
}

module top_socket_cut() {
  union() {
    translate([0,0,RM_PANEL_T-RM_SOCKET_DEPTH])
      hex_frustum(RM_HEX_R-RM_HEX_TAPER,
                   RM_HEX_R,
                   RM_SOCKET_DEPTH+0.1);
    translate([0,0,RM_PANEL_T-RM_SOCKET_DEPTH-RM_M3_BLIND_DEPTH])
      cylinder(h=RM_M3_BLIND_DEPTH+0.1,d=RM_M3_PILOT,$fn=24);
  }
}

module bottom_socket_cut() {
  union() {
    translate([0,0,-0.1])
      hex_frustum(RM_HEX_R,
                   RM_HEX_R-RM_HEX_TAPER,
                   RM_SOCKET_DEPTH+0.1);
    translate([0,0,RM_SOCKET_DEPTH-0.1])
      cylinder(h=RM_M3_BLIND_DEPTH+0.1,d=RM_M3_PILOT,$fn=24);
  }
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

function join_index(p,edge_len) =
  round((p+edge_len/2-RM_JOIN_PITCH/2)/RM_JOIN_PITCH);
function is_m3_join(p,edge_len) = join_index(p,edge_len)%3 == 1;

// Integral tapered hex pins on an A edge (+Y in local coordinates).
module male_edge(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    translate([p,panel_half-0.05,RM_PANEL_T/2])
      rotate([-90,0,0])
        hex_frustum(RM_JOIN_R+RM_JOIN_CLEARANCE-RM_JOIN_SEAT_CLEARANCE,
                     RM_JOIN_R-RM_JOIN_TAPER,
                     RM_JOIN_LENGTH+0.05);
}

// Blind thread-forming pilots continue through selected pins into the edge.
module male_edge_m3_cuts(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    if(is_m3_join(p,edge_len))
      translate([p,panel_half-4,RM_PANEL_T/2])
        rotate([-90,0,0])
          cylinder(h=RM_JOIN_LENGTH+4.2,d=RM_M3_PILOT,$fn=24);
}

// Female B edge (-Y): lateral sockets accept the same pins coplanar at 0°.
module female_edge_cuts(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2])
    translate([p,-panel_half-0.1,RM_PANEL_T/2])
      rotate([-90,0,0])
        hex_frustum(RM_JOIN_R+RM_JOIN_CLEARANCE,
                     RM_JOIN_R-RM_JOIN_TAPER+RM_JOIN_CLEARANCE,
                     RM_JOIN_LENGTH+0.2);
}

// The same B edge has perpendicular sockets for a direct 90° connection.
// Counterbores on both faces let the panel be flipped and still accept M3.
module female_90_cuts(edge_len, panel_half) {
  for(p=[-edge_len/2+RM_JOIN_PITCH/2:
         RM_JOIN_PITCH:
         edge_len/2-RM_JOIN_PITCH/2]) {
    translate([p,-panel_half+RM_PANEL_T/2,-0.1])
      hex_frustum(RM_JOIN_R+RM_JOIN_CLEARANCE,
                   RM_JOIN_R+RM_JOIN_CLEARANCE,
                   RM_PANEL_T+0.2);
    if(is_m3_join(p,edge_len)) {
      translate([p,-panel_half+RM_PANEL_T/2,-0.1])
        cylinder(h=2.1,d=RM_M3_HEAD,$fn=32);
      translate([p,-panel_half+RM_PANEL_T/2,RM_PANEL_T-2])
        cylinder(h=2.1,d=RM_M3_HEAD,$fn=32);
    }
  }
}

// Identical panels: male joins on +X/+Y, dual female joins on -X/-Y.
module dock_panel(size=[2*RM_UNIT,2*RM_UNIT]) {
  assert(size[0] % RM_UNIT == 0 && size[1] % RM_UNIT == 0,
         "Panel dimensions must be whole 42 mm units");
  difference() {
    union() {
      translate([-size[0]/2,-size[1]/2,0])
        rounded_box([size[0],size[1],RM_PANEL_T],1.5);
      male_edge(size[0],size[1]/2);
      rotate([0,0,-90]) male_edge(size[1],size[0]/2);
    }
    dense_socket_grid(size);
    female_edge_cuts(size[0],size[1]/2);
    female_90_cuts(size[0],size[1]/2);
    rotate([0,0,-90]) {
      female_edge_cuts(size[1],size[0]/2);
      female_90_cuts(size[1],size[0]/2);
    }
    male_edge_m3_cuts(size[0],size[1]/2);
    rotate([0,0,-90]) male_edge_m3_cuts(size[1],size[0]/2);
  }
}

// The tip enters freely; the last fraction of travel supplies the grip.
module integral_hex_plug(at=[0,0]) {
  translate([at[0],at[1],-RM_SOCKET_DEPTH+0.2])
    hex_frustum(RM_HEX_R-RM_HEX_TAPER-RM_HEX_ENTRY_CLEARANCE,
                 RM_HEX_R+RM_HEX_GRIP,
                 RM_SOCKET_DEPTH+0.1);
}

// Adds one or more identical plugs. M3 is optional: the press fit works alone.
module carrier_mount(points=[[0,0]]) {
  difference() {
    union() {
      children();
      for(at=points) integral_hex_plug(at);
    }
    for(at=points) {
      translate([at[0],at[1],-RM_SOCKET_DEPTH])
        cylinder(h=RM_SOCKET_DEPTH+100,d=RM_M3_CLEARANCE,$fn=24);
      translate([at[0],at[1],-0.01])
        cylinder(h=2.21,d=RM_M3_HEAD,$fn=32);
    }
  }
}

module sensor_carrier(pcb=[20,20], wall=1.7, floor=1.8, clearance=0.5) {
  W=pcb[0]+2*(wall+clearance);
  L=pcb[1]+2*(wall+clearance);
  assert(W >= 2*(RM_HEX_R+RM_HEX_GRIP),
         "Carrier is narrower than its integral hex plug");
  carrier_mount() union() {
    translate([-W/2,-L/2,0]) difference() {
      rounded_box([W,L,floor+3.1],2);
      translate([wall,wall,floor])
        rounded_box([pcb[0]+2*clearance,pcb[1]+2*clearance,5],1);
      translate([W/2-6,-0.2,floor+0.5]) cube([12,wall+1,3.5]);
    }
    for(x=[-W/2+2.2,W/2-2.2], y=[-L/2+2.2,L/2-2.2])
      translate([x,y,floor+2.5]) cylinder(h=1.3,d=2.2);
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
