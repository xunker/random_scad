/*

3.5in Drive Stacker - v1.0 - (C) 2022 Matthew Nielsen
https://github.com/xunker/random_scad/3_5_drive_stacker

Commercial use/reproduction of code or resulting rendered output is strictly forbidden without
written consent of author. All other use/reproduction/modification shall be under these same terms
and must include this notice and must include original author information.

*/


// Rotation is to put flat side down for printing
rotate([0, -90, 0]) {
  // single();
  stack_of_two();
  // stack_of_three();
}


/* SETTINGS AND CODE BELOW */
drive_total_h = 25;

// Screw hole offsets measurements are fron the rear (connector) end
screw_x_offsets = [
  28.5, // +- 0.25
  130.1 // +- 0.5
];

screw_z_offset = 6.35-0.2; // +- 0.25

column_t = 5;
column_w = 25;

shelf_w = 10;
shelf_l = column_w;
shelf_t = 5;

drive_addt_h = 0;

drive_screw_hole_d = 4.5;
drive_screw_countersink_d = 10;
drive_screw_countersink_h = column_t - 1.5;

attachment_screw_hole_d = 3.6;
attachment_screw_countersink_d = 8.5;
attachment_screw_countersink_h = 3.5;

//---


ff = 0.01;

module raw_column() {
  cube([column_t, column_w, drive_total_h + (shelf_t * 2) + drive_addt_h]);
}

module drive_shelf(attachment_screw_holes=true) {
  difference() {
    cube([shelf_w, shelf_l, shelf_t]);
    union() {
      if (attachment_screw_holes) translate([shelf_w/2, shelf_l/2, -ff]) {
        $fn=16;
        cylinder(d=attachment_screw_hole_d, h=shelf_t+(ff*2));
        translate([0, 0, shelf_t-attachment_screw_countersink_h+ff]) cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h+(ff));
      }
    }
  }
}

module attachment_shelf(attachment_screw_holes=true) {
  difference() {
    hull() {
      cube([ff, shelf_l, shelf_t]);
      translate([shelf_w - ff, 0, shelf_t-(shelf_t/3)]) cube([ff, shelf_l, shelf_t/3]);
    }

    union() {
      if (attachment_screw_holes) translate([shelf_w/2, shelf_l/2, -ff]) {
        $fn=16;
        cylinder(d=attachment_screw_hole_d, h=shelf_t+(ff*2));
        translate([0, 0, 0]) cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h+(ff));
      }
    }
  }
}

module complete_column(upper_attachment_screw_holes=true, lower_attachment_screw_holes=true) {
  difference() {
    union() {
      raw_column();
      translate([column_t, 0, 0]) drive_shelf(attachment_screw_holes=lower_attachment_screw_holes);
      translate([column_t, 0, shelf_t + drive_total_h + drive_addt_h]) attachment_shelf(attachment_screw_holes=upper_attachment_screw_holes);
    }

    translate([-ff, column_w/2, shelf_t + (screw_z_offset)]) rotate([0, 90, 0]) {
      $fn=16;
      cylinder(d=drive_screw_hole_d, h=column_t+(ff*2));
      translate([0, 0, -ff]) cylinder(d=drive_screw_countersink_d, h=(drive_screw_countersink_h*0.65)+ff);
      translate([0, 0, (drive_screw_countersink_h*0.65)-ff]) cylinder(d2=drive_screw_hole_d, d1=drive_screw_countersink_d, h=(drive_screw_countersink_h*0.35)+ff);
    }
  }
}

module single() {
  complete_column();
}

//stack of two
module stack_of_two() {
  translate([0, 0, (shelf_t*2)+drive_total_h+drive_addt_h]) complete_column(upper_attachment_screw_holes=true, lower_attachment_screw_holes=false);
  complete_column(upper_attachment_screw_holes=false, lower_attachment_screw_holes=true);
}

//stack of three
module stack_of_three() {
  translate([0, 0, ((shelf_t*2)+drive_total_h+drive_addt_h)*2]) complete_column(upper_attachment_screw_holes=true, lower_attachment_screw_holes=false);
  translate([0, 0, (shelf_t*2)+drive_total_h+drive_addt_h]) complete_column(upper_attachment_screw_holes=false, lower_attachment_screw_holes=false);
  complete_column(upper_attachment_screw_holes=false, lower_attachment_screw_holes=true);
}
