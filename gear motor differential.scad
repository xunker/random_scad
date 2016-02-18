module spur_gear() {
  difference() {
    rotate([90,18w0,0]) import("Spur_Gear_Axle.stl", convexity=3);
    translate([2.5,-25,-25]) cube([20,50,50]);
    translate([-22.5,-25,-25]) cube([20,50,50]);
    cube([10, 5.65, 3.8], center=true);
  }
}

// difference() {
//   cube([1, 10, 10], center=true);
//   cube([10, 5.65, 3.8], center=true);
// }

bearing_id=7.85;

module connector() {
  rotate([0, 90, 0]) {

    translate([-5,0,0]) cube([25, 4.8, 3.4], center=true);
    translate([7,0,0]) rotate([0,90,0]) {
      // translate([0,0,-5]) cylinder(d1=3.5, d2=5.9, h=5, $fn=30, center=true);
      translate([0,0,5]) cylinder(d=5.8, h=5, $fn=30, center=true);
      translate([0,0,6]) cube([bearing_id+2, 1.5, 3], center=true);

      translate([0,0,-6])cylinder(d=bearing_id, h=10, $fn=30, center=true);
      translate([0,0,1])cylinder(d2=5.8, d1=bearing_id+2, h=5, $fn=30, center=true);
    }

  }
}

bearing_width=7 + 0.5;
bearing_od=22 + 0.5;

module base_bearing_carrier() {  
  union() {
    difference() {
      translate([(bearing_od+2)/4,0,0]) cube([(bearing_od+2)/2,bearing_od+2,bearing_width+3], center=true);
      union() {
        cylinder(h=bearing_width+0, d=bearing_od, center=true, $fn=30);
        cylinder(h=bearing_width+3, d=bearing_id+2, center=true, $fn=30);
      }
    }

    mirror([0,0,0]) translate([(bearing_od+2)/4,(bearing_od+2)/1.6,0]) { 
      difference() {
        cube([(bearing_od+2)/2,bearing_od/3,bearing_width+3], center=true);
        // screw hole
        rotate([0,90,0]) translate([0,-1,-10]) cylinder(h=bearing_od+2, d=3, $fn=15);
      }
    }
    mirror([0,1,0]) translate([(bearing_od+2)/4,(bearing_od+2)/1.6,0]) {
      difference() {
        cube([(bearing_od+2)/2,bearing_od/3,bearing_width+3], center=true);
        // screw hole
        rotate([0,90,0]) translate([0,-1,-10]) cylinder(h=bearing_od+2, d=3, $fn=15);
      }
    }
  }

}

module top_bearing_carrier() {
  rotate([0,90,0]) {
    difference() {
      base_bearing_carrier();
      // cut the bottom off
      translate([bearing_od/3,-bearing_od*1.5,-bearing_width]) cube([bearing_od/2,bearing_od*3,bearing_width*2]);
    }
  }
}


// base_bearing_carrier();
module lower_carrier_frame() {
  difference() {
    union() {
      translate([0,4.7,bearing_od/4]) cube([80.4,2,(bearing_od+2)/2], center=true);
      translate([0,(bearing_od*1.991),bearing_od/4]) cube([80.4,2,(bearing_od+2)/2], center=true);
      translate([35,(bearing_od*1.10),(bearing_od/2)+0.5]) rotate([0,90,0]) base_bearing_carrier();
      translate([-35,(bearing_od*1.10),(bearing_od/2)+0.5]) rotate([0,90,0]) base_bearing_carrier();
    }
    // chop the bottom
    translate([0,25,1]) cube([81,50,9], center=true);
  }
}

// connector();
lower_carrier_frame();
// top_bearing_carrier();