meter_cutout_diameter = 50;
meter_facia_width = 66;
meter_facia_length = 52;
meter_facia_height = 60;
facia_screw_offset = 7;

module bare_housing() {
  difference() {
    cube([meter_facia_length, meter_facia_width, meter_facia_height]);
    translate([1,0.75,0.75])
      cube([meter_facia_length, meter_facia_width-1.5, meter_facia_height-0]);
    // translate([1,0,0])
    //   cube([meter_facia_length, meter_facia_width-0, meter_facia_height-0]);
  }
}

module full_housing() {
  difference() {
    bare_housing();
    meter_cutout_compensate_z = -1.5;
    meter_cutout_offset_x = (meter_cutout_diameter/2) + ((meter_facia_width - meter_cutout_diameter)/2);
    meter_cutout_offset_z = (meter_cutout_diameter/2) + ((meter_facia_height - meter_cutout_diameter)/2);
    translate([-1,meter_cutout_offset_x,meter_cutout_offset_z+meter_cutout_compensate_z]) rotate([0,90,0]) cylinder(d=meter_cutout_diameter, h=3, $fn=64);
    translate([-1,meter_facia_width-facia_screw_offset,17+meter_cutout_compensate_z]) rotate([0,90,0]) cylinder(d=3.5, h=3, $fn=32);
    translate([-1,facia_screw_offset,17+meter_cutout_compensate_z]) rotate([0,90,0]) cylinder(d=3.5, h=3, $fn=32);
  }
}

difference() {
  full_housing();
  translate([1,0,meter_facia_height]) rotate([0,49,0]) cube([meter_facia_length*2, meter_facia_width, meter_facia_height]);
}


