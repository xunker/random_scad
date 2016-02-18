difference() {
  rotate([90,18w0,0]) import("Spur_Gear_Axle.stl", convexity=3);
  translate([2.5,-25,-25]) cube([20,50,50]);
  translate([-22.5,-25,-25]) cube([20,50,50]);
  cube([10, 5.65, 3.8], center=true);
}

// difference() {
//   cube([1, 10, 10], center=true);
//   cube([10, 5.65, 3.8], center=true);
// }