difference() {
  union() {
    translate([0,0,2.5]) import("Odyssey Elementary Logo Outline.svg_5mm.stl", convexity=10);
    // translate([30,30.5,0]) cylinder(d=60.5, h=1.5, $fn=50);
    translate([30.3,30.3,3.5]) cylinder(d=63, h=1, $fn=50);
  }
  translate([30,30.5,0]) cylinder(d=65, h=3.5, $fn=50);
}