hole_spacing = 20;
hole_diameter = 4;

height = 8;

lower_diameter = 23.5;
upper_diameter = 37;

module lower() {
  difference() {
    cylinder(d=lower_diameter+4, h=height, $fn=32);
    cylinder(d=lower_diameter, h=height, $fn=32);
    translate([-1,10,0]) cube([2,5,height]);
  }


  difference() {
    union() {
      translate([-3,12,0]) cube([2,9,height]);
      translate([1,12,0]) cube([2,9,height]);
    }
    rotate([0,90,0]) translate([-4,17,-5]) cylinder(d=4, h=10);
  }
}

module upper() {
  difference() {
    cylinder(d=upper_diameter+4, h=height, $fn=32);
    cylinder(d=upper_diameter, h=height, $fn=32);
    translate([-1,17,0]) cube([2,5,height]);
  }


  difference() {
    union() {
      translate([-3,20,0]) cube([2,9,height]);
      translate([1,20,0]) cube([2,9,height]);
    }
    rotate([0,90,0]) translate([-4,25,-5]) cylinder(d=4, h=10);
  }
}

// lower();
// upper();

module mount(stem) {
  height = 3;
  length = 27;
  width = 8;

  hole_offset = (length-hole_spacing)/2;
  difference() {
    cube([width,length,height]);
    translate([width/2,hole_offset,-(height/2)]) cylinder(d=hole_diameter, h=height*2, $fn=16);
    translate([width/2,length-hole_offset,-(height/2)]) cylinder(d=hole_diameter, h=height*2, $fn=16);
  }

  translate([0, length/3, 0]) cube([width, hole_spacing/2, stem]);
}

module lower_mount() {
  mount(15);
  rotate([90,0,90]) translate([(lower_diameter+4)/2,((upper_diameter+4)/2)+7,0]) lower();
}

module upper_mount() {
  mount(8);
  rotate([90,0,90]) translate([(lower_diameter+4)/2,((upper_diameter+4)/2)+7,0]) upper();
}

lower_mount();
// translate([0,40,0]) upper_mount();