nexus5x = [147.0, 72.6, 7.9];
nexus6p = [159.4, 77.8, 7.3];

phone = nexus5x;

height = phone[0];
width = phone[1];
depth = phone[2];

$fn = 30;

// curve_radius = depth/2;

// minkowski() {
//   cube([height-curve_radius, width-curve_radius, depth-curve_radius]);
//   translate([0,0,curve_radius/2]) sphere(r=curve_radius/2);
// }

  cube([height, width, depth]);