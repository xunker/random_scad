module original() {
  import("Complete_Box_V4__repaired_.stl");
}

module horn() {
  difference() {
    original(); 
    translate([0,0,-2]) {
      translate([-25, -30, 0]) cube([160,80,35]);
      translate([-25, 0, 0]) cube([25,80,35]);
      translate([10, 0, 0]) cube([125,58,35]);
    }
  }
}

module box() {
  difference() {
    original(); 
    translate([-25, -30, -2]) cube([95,110,35]);
  }
}

module switch() {
  intersection() {
    original();
    translate([-25, -30, -2]) cube([35,60,35]);
  }
}

module cover() {
  intersection() {
    original();
    translate([10, -30, -2]) cube([60,60,35]);
  }
}

module hinge() {
  intersection() {
    original();
    translate([-60, 30, -2]) cube([60,50,35]);
  }
}

module battery() {
  intersection() {
    original();
    translate([10, 30, -2]) cube([60,28,35]);
  }
}

// horn();
// box();
// switch();
// cover();
// battery();
// hinge();

// original();

intersection() {
  box();
  translate([70,-5,0]) cube([8,40,30]);
  translate([70,-5,0]) cube([8,40,10]);
}