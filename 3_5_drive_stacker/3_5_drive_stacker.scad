drive_total_l = 147; // Unused here, just for reference
drive_total_w = 102; // Unused here, just for reference
drive_total_h = 25;

// screw hole offsets, reference from https://toshiba.semicon-storage.com/us/storage/support/faq/storage-holes.html
// measurements are fron the rear (connector) end
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

module drive_dummy() {
  cube([drive_total_w, drive_total_l, drive_total_h]);
}

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
  // cube([shelf_w, shelf_l, shelf_t]);
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


module old_complete_column_w_attachment() {
  module angle_screw_hole() {
    translate([shelf_w/2, 0, 0]) rotate([0, 45, 0]) translate([0, column_w/2, -column_t*2]) {
        $fn=16;
        cylinder(d=attachment_screw_hole_d, h=column_t*4);
        cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h*2);
        translate([0, 0, (column_t*4)-(attachment_screw_countersink_h*3.5)]) cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h*3.5);
      }
  }
  difference() {
    complete_column();
    angle_screw_hole();
    translate([0, 0, drive_total_h + shelf_t + drive_addt_h]) {
      angle_screw_hole();
    }
  }
}

// module complete_column_w_attachment() {
//   difference() {
//     complete_column();

//   }
// }

// difference() {
//   union() {
//     complete_column();
//     translate([0, 0, drive_total_h + shelf_t + drive_addt_h]) {
//       color("blue") complete_column();
//     }
//   }
//   translate([0, 0, drive_total_h + shelf_t + drive_addt_h]) {
//     translate([shelf_w/2, 0, 0]) rotate([0, 45, 0]) translate([0, column_w/2, -column_t*2]) {
//       $fn=16;
//       cylinder(d=attachment_screw_hole_d, h=column_t*4);
//       cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h*2);
//       translate([0, 0, (column_t*4)-(attachment_screw_countersink_h*3.5)]) cylinder(d=attachment_screw_countersink_d, h=attachment_screw_countersink_h*3.5);
//     }
//   }
// }

// translate([column_t, 0, shelf_t]) %drive_dummy();

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

stack_of_two();
// stack_of_three();

