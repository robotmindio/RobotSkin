include <rm_common.scad>
// Adjustable tray for an Arduino-UNO-format ESP32-S3 board + Grove shield stack.
BOARD=[69,54]; BASE_T=2.5;
difference(){
  translate([-BOARD[0]/2-4,-BOARD[1]/2-4,0]) rounded_box([BOARD[0]+8,BOARD[1]+8,BASE_T],3);
  // elongated mounting slots rather than assuming exact clone hole positions
  for(x=[-27,27], y=[-20,20]) translate([x,y,0]) linear_extrude(height=BASE_T+2,center=true) hull(){
    translate([-3.35,0]) circle(d=3.3);
    translate([3.35,0]) circle(d=3.3);
  }
}
// low corner retainers
for(x=[-BOARD[0]/2,BOARD[0]/2],y=[-BOARD[1]/2,BOARD[1]/2]) translate([x,y,BASE_T]) cylinder(h=3,d=4);
translate([0,0,-RM_RAIL_H]) male_interface();
