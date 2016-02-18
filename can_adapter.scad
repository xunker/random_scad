fn=50;
can_od = 66.0;

short_can_height = 92.3;
regular_can_height = 122.4;

can_lower_flange_height = 6.77;
can_lower_flange_inset = 6.6;
can_lower_flange_id = 42.0;
can_lower_flange_od = 53.0;

can_upper_flange_id = 52.0;
can_upper_flange_od = can_od;
can_upper_flange_height =4;

adapter_height = regular_can_height - short_can_height;
// adapter_height_body = adapter_height-(can_upper_flange_height+can_lower_flange_height);
adapter_height_body = adapter_height;

// difference() {
  cylinder(d=can_od, h=adapter_height_body, center=true, $fn=fn);
  translate([0,0,adapter_height_body/2]) {
    difference() {
      cylinder(d=can_upper_flange_od, h=can_upper_flange_height, center=true, $fn=fn);
      cylinder(d=can_upper_flange_id, h=can_upper_flange_height, center=true, $fn=fn);
    }
  }
  translate([0,0,-(adapter_height_body/2)]) {
    // difference() {
      cylinder(d=can_lower_flange_od, h=can_lower_flange_height, center=true, $fn=fn);
      // cylinder(d=can_lower_flange_id, h=can_lower_flange_height, center=true, $fn=fn);
    // }
  }
// }