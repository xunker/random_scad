// Diameter of screw hole for the screw connecting to R1 build plate carriage.
// 3.1 works for me for a 2.7mm diameter machine screw.
screw_diameter = 3.1;

// Diameter of bolt hole for the bolt that connects to bottom of camera.
// 5.25 works for my 4.85mm diameter bolt.
bolt_diameter = 5.25;

// Width to be added in excess to the widest of `screw_diameter` and
// `bolt_diameter`;
extra_width = 1.5;

// Length on sides as a cube, before all the angles are cut.
// 25mm places the face with the bolt hole almost exactly level with the build
// plate. Lengths smaller than 25 will probably not work right.
length = 25;

// Width and length of the stabilizer wing to keep the mount from rotating.
stabilizer_length = 5;
stabilizer_width = 3;
stabilizer_inset = stabilizer_width;

total_stabilizer_length = stabilizer_length + stabilizer_inset;

// Automatically calculate width to be `extra_width` wider than widest hole.
width = bolt_diameter + extra_width;
if (width < screw_diameter) {
  width = screw_diameter + extra_width;
}



union() {
  difference() {

    // Base cube
    cube([length, length, width]);

    // Diagonal cut toward build plate
    rotate([0,0,45])
      translate([-(length*1.7),-length,0])
        cube([length*2, length*2, width]);

    // Diagonal cut opposite build plate
    translate([length,0,0])
      rotate([0,0,45])
        cube([length*2, length*2, width]);

    // Screw Hole
    translate([0,length/1.4,width/2])
      rotate([0,90,0])
        cylinder(d=screw_diameter, h=40, center=true, $fn=30);

    // Bolt hole
    translate([length/1.4,0,width/2])
      rotate([90,90,0])
        cylinder(d=bolt_diameter, h=40, center=true, $fn=30);

    // Notch behind bolt hole
    translate([length/1.4,length/2.5,width/2])
      cube([length/2.5,length/2.5,width], center=true);

    // Notch behind screw hole
    translate([length/2.5,length/1.4,width/2])
      cube([length/2.5,length/2.5,width], center=true);
  }

  // Stabilizer
  screw_to_top_offset = 6.5; // distance between screw and top of y carriage.
  translate([
    -(total_stabilizer_length-stabilizer_inset),
    (length/1.4)-(screw_to_top_offset+stabilizer_width),
    width
  ])
    rotate([0,90,0])
      cube([width,stabilizer_width,total_stabilizer_length]);
}