// 52.11
// 34.2
// 15 h

w=53.3;
l=35.2;
h=1;
hh=5;

difference() {
  cube([w+1, l+1, h], center=true);
  cube([w-1, l-1, h], center=true);
}
translate([0,0,-3]) {
  difference() {
    cube([w+1, l+1, hh], center=true);
    cube([w-2, l-2, hh], center=true);
  }
}
translate([0,0,-5.0]) {
  cube([w, l, 1], center=true);
}

///

// translate([0,l*1.5,-(hh-1.5)]) {
  // difference() {
  //   cube([w+3.5, l+3.5, h+2], center=true);
  //   cube([w+1.5, l+1.5, h+2], center=true);
  // }
  // translate([0,0,-1.5]) {
  //   difference() {
  //     cube([w+1.5, l+1.5, 1], center=true);
  //     cube([w-1, l-1, 1], center=true);
  //   }
  // }
// }