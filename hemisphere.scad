module dome(d) {
  difference() {
    sphere(d=d, center=true, $fn=128);
    translate([0,0,-(d/2)]) cube([d,d,d], center=true);
  }
}

difference() {
  dome(20);
  dome(18);
}