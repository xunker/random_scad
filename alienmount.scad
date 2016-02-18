/*
Amplifier Dimensions
http://www.dell.com/content/products/productdetails.aspx/alienware-graphics-amplifier
  Height: 6.831" - (173.5mm)
  Depth: 16.124" - (409.55mm)
  Width: 7.303" - (185.5mm)

  measured
  width: 160mm

  angle of side is about 95 degrees

Laptop Dimensions
  About 327 wide at middle
  About 235 deep at middle
  About 225 deep at side
  About 25 thick

*/
screw_hole_diameter = 4;
depth = screw_hole_diameter*2;
amplifier_width=160;
bracket_width=amplifier_width+depth;
screw_hole_offset = bracket_width/2.5;

module amplifier_support() {
  
  leg_width = depth/2;
  leg_height = 65;
  height=depth;
  
  difference() {
    union() {
      translate([-(depth/2), -(bracket_width/2), 0]) {
        cube([depth, bracket_width, height]);
      }

      translate([-(depth/2.2),(bracket_width/2)-leg_width,0]) {
        rotate([0,0,5]) {
          cube([leg_height, leg_width, height]);
        }
      }
      
      translate([-(depth/2),-(bracket_width/2)-0.01,0]) {
        rotate([0,0,-5]) {
          cube([leg_height, leg_width, height]);
        }
      }
    }

    translate([0,screw_hole_offset,0]) { cylinder(h=depth, d=screw_hole_diameter, $fn=20); }
    translate([0,-screw_hole_offset,0]) { cylinder(h=depth, d=screw_hole_diameter, $fn=20); }
  }

}

module brace() {

  brace_height = depth;
  // brace_height = 1;
  module corner_connection() {
    
    translate([-screw_hole_offset, -screw_hole_offset, 0]) {
      difference() {
        union() {
          translate([depth*0.5,0,0]) {
            cube([depth*1.6,depth,brace_height], center=true);
          }
          translate([screw_hole_offset/2,screw_hole_offset/2,0]) {
            rotate([0,0,45]) {
              cube([screw_hole_offset*1.4,depth,brace_height], center=true);
            }
          }
        }
        color("red") {
          rotate([0,90,0]) {
            translate([0,0,depth/2]) {
              cylinder(d=screw_hole_diameter, h=depth*2, center=true, $fn=20);
            }
          }
        }
      }
    }
  }

  difference() {
    center_hole_diameter = depth*10;
    union() {
      // center node
      cylinder(d=center_hole_diameter,h=brace_height, center=true, $fn=100);

      union() {
        mirror([0,0,0]) { corner_connection(); }
        mirror([0,1,0]) { corner_connection(); }
      }

      mirror([1,0,0]) {
        union() {
          mirror([0,0,0]) { corner_connection(); }
          mirror([0,1,0]) { corner_connection(); }
        }
      }
    }
    cylinder(h=depth, d=center_hole_diameter*0.80, center=true, $fn=50);
  }
}

module tray() {
  center_hole_diameter = depth*10;

  module draw_wedge() {
    translate([1,1,0]) {
      scale(0.96) {
        intersection() {
          cylinder(h=depth*2, d=center_hole_diameter*2, center=true, $fn=100);
          translate([0,0,-(depth/2)]) {
            cube([center_hole_diameter,center_hole_diameter,depth*2]);
          }
        }
      }
    }
  }

  module place_wedge() {
    translate([0,0,-1]) {
      draw_wedge();
    }
  }
  translate([0,0,depth*1.5]) {
    difference() {
      cylinder(h=depth+1, d=center_hole_diameter*0.75, center=true, $fn=100);
      cylinder(h=depth+1, d=center_hole_diameter*0.72, center=true, $fn=100);
    }  
  }
  translate([0,0,depth*2]) {
    difference() {
      cylinder(h=1, d=center_hole_diameter*2, center=true, $fn=100);
      union() {
        mirror([0,0,0]) { place_wedge(); }
        mirror([0,1,0]) { place_wedge(); }
        mirror([1,1,0]) { place_wedge(); }
        mirror([1,0,0]) { place_wedge(); }
      }
    }
  }

}

// amplifier_support();

// brace();

tray();