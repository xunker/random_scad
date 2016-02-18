module screw_hole(radius=1.5, offset=17) {
  translate([offset,offset,0]) {
    cylinder(h=2, r=radius, center=true, $fn=20);
  }
}

module tube(height=10, d1=40, d2=50, thickness=1) {
  difference() {
    cylinder(h=height, d1=d1, d2=d2, center=true);
    cylinder(h=height, d1=d1-thickness, d2=d2-thickness, center=true);
  }
}
union() {
  union() {
    difference() {
      difference() {
        cube([40, 40, 1], center=true);
        mirror([0,0,0]) screw_hole();
        mirror([0,1,0]) screw_hole();
        mirror([1,0,0]) screw_hole();
        mirror([1,1,0]) screw_hole();
      }
      cylinder(d=39, h=1, center=true);
    }
    translate([0,0,5.5]) tube();
  }
  translate([0,0,10]) {
    difference() {
      difference() {
        cube([50, 50, 1], center=true);
        mirror([0,0,0]) screw_hole(offset=22);
        mirror([0,1,0]) screw_hole(offset=22);
        mirror([1,0,0]) screw_hole(offset=22);
        mirror([1,1,0]) screw_hole(offset=22);
      }
      cylinder(d=49, h=1, center=true);
    }
  }
}