include <rm_common.scad>

// Dual-sided cube: AprilTag cards outside, PCB carrier cards inside, one bottom seal.
PART="shell"; // shell, lid, gasket or pcb_carrier
TAG=42;
TAG_CLEARANCE=0.25;
PCB=[28,45]; // provisional board footprint; measure the real board before printing.
CUBE=56;
WALL=2.4;
CARD=[42,48,1.6];
SLIDE_CLEARANCE=0.30;
LID_T=3;
GASKET_T=1.5;
GASKET_W=1.7;
GASKET_GROOVE=1.1;
SCREW_D=3.3;
PILOT_D=2.8;
BOSS_D=6.5;
SCREW_POS=24;

assert(PART=="shell" || PART=="lid" || PART=="gasket" || PART=="pcb_carrier",
       "PART must be shell, lid, gasket or pcb_carrier");
assert(CARD[0] < CUBE-2*WALL && CARD[1] < CUBE-WALL,
       "PCB carrier must fit inside the cube");
assert(PCB[0]+6 < CARD[0] && PCB[1] <= CARD[1]-2,
       "PCB envelope is too large for the carrier");
assert(GASKET_GROOVE > 0 && GASKET_GROOVE < GASKET_T,
       "Gasket groove must leave the gasket proud for compression");

module ring(outer, inner, h, r=2) {
  difference(){
    rounded_box([outer,outer,h],r,center=true);
    rounded_box([inner,inner,h+0.2],max(0.5,r-(outer-inner)/2),center=true);
  }
}

module face_tag_rails() {
  tag_insert_rails([TAG,TAG],border=3,rail=1.3,depth=1.8,clearance=TAG_CLEARANCE);
}

module inner_card_rails() {
  rail_w=2.4;
  back=0.9;
  slot=CARD[2]+2*SLIDE_CLEARANCE;
  depth=back+slot+0.9;
  z0=3;
  h=CARD[1]+SLIDE_CLEARANCE;
  edge=CARD[0]/2+SLIDE_CLEARANCE;
  for(sx=[-1,1]) {
    x=sx*edge-rail_w/2;
    translate([x,0,z0]) cube([rail_w,back,h]);
    translate([x,back+slot,z0]) cube([rail_w,0.9,h]);
    translate([sx>0 ? edge : -edge-rail_w/2,0,z0]) cube([rail_w/2,depth,h]);
  }
  translate([-edge-rail_w/2,0,z0+h]) cube([2*edge+rail_w,depth,1]);
}

module cube_shell() {
  difference(){
    union(){
      difference(){
        translate([0,0,CUBE/2]) rounded_box([CUBE,CUBE,CUBE],3,center=true);
        translate([0,0,(CUBE-WALL)/2-0.1])
          rounded_box([CUBE-2*WALL,CUBE-2*WALL,CUBE-WALL+0.2],2,center=true);
      }
      // Four exterior tag slots; rotate the stop downward so cards insert from above.
      for(a=[0,90,180,270]) rotate([0,0,a])
        translate([0,-CUBE/2+0.1,CUBE/2]) rotate([90,0,0]) rotate([0,0,180]) face_tag_rails();
      // Fifth tag slot on the closed top.
      translate([0,0,CUBE-0.1]) face_tag_rails();
      // Four independent internal PCB-card slots, all loaded through the open bottom.
      for(a=[0,90,180,270]) rotate([0,0,a])
        translate([0,-CUBE/2+WALL-0.1,0]) inner_card_rails();
      // Blind bosses keep lid fasteners out of the sealed electronics cavity.
      for(x=[-SCREW_POS,SCREW_POS],y=[-SCREW_POS,SCREW_POS])
        translate([x,y,0]) cylinder(h=10,d=BOSS_D);
    }
    for(x=[-SCREW_POS,SCREW_POS],y=[-SCREW_POS,SCREW_POS])
      translate([x,y,-0.1]) cylinder(h=8.1,d=PILOT_D);
  }
}

module cube_lid() {
  difference(){
    union(){
      translate([0,0,LID_T/2]) rounded_box([CUBE,CUBE,LID_T],3,center=true);
      // Four mid-side tabs locate the lid without colliding with corner fasteners.
      for(a=[0,90,180,270]) rotate([0,0,a])
        translate([-6,CUBE/2-WALL-1.5,LID_T]) cube([12,1.2,1.2]);
      male_interface();
    }
    for(x=[-SCREW_POS,SCREW_POS],y=[-SCREW_POS,SCREW_POS])
      translate([x,y,-RM_RAIL_H-0.1]) cylinder(h=LID_T+RM_RAIL_H+2,d=SCREW_D);
    // A 1.5 mm gasket sits 0.4 mm proud of this groove before clamping.
    translate([0,0,LID_T-GASKET_GROOVE/2+0.01])
      ring(CUBE-1,CUBE-1-2*GASKET_W,GASKET_GROOVE+0.02,2.5);
  }
}

module cube_gasket() {
  translate([0,0,GASKET_T/2]) ring(CUBE-1,CUBE-1-2*GASKET_W,GASKET_T,2.5);
}

module pcb_carrier() {
  difference(){
    translate([0,0,CARD[2]/2]) rounded_box(CARD,1.5,center=true);
    // Four generic zip-tie / M2 slots avoid assuming clone-specific hole positions.
    for(x=[-PCB[0]/2-2.5,PCB[0]/2+2.5],y=[-12,12])
      translate([x,y,-0.1]) linear_extrude(height=CARD[2]+0.2) hull(){
        translate([0,-2.5]) circle(d=2.8);
        translate([0, 2.5]) circle(d=2.8);
      }
    // Cable notch faces the open bottom of the shell.
    translate([-5,-CARD[1]/2-0.1,-0.1]) cube([10,5,CARD[2]+0.2]);
  }
}

if(PART=="shell") cube_shell();
if(PART=="lid") cube_lid();
if(PART=="gasket") cube_gasket();
if(PART=="pcb_carrier") pcb_carrier();
