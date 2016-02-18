inner_diameter=27.3; // 26.64;
outer_diameter=inner_diameter+5;
handle_length = 100;

// intersection() {
  
  difference() {
    cylinder(h=outer_diameter, d=outer_diameter, center=true, $fn=100);
    cylinder(h=outer_diameter, d=inner_diameter, center=true, $fn=100);
  }

  difference() {
    translate([0,handle_length/2,0]) {
      rotate([90,0,0]) {
        difference() {
          cylinder(h=handle_length, d=inner_diameter+5, center=true, $fn=100);
          cylinder(h=handle_length, d=inner_diameter, center=true, $fn=100);
        }
      }
    }
    cylinder(h=outer_diameter, d=outer_diameter, center=true, $fn=100);
  }
// }