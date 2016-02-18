outer_width = 125;
outer_height = 89.5;
depth = 5;
mount_hole_diameter = 3.5;

inner_width = 122;
inner_height = 76.5;

inset_width = 107;
inset_height = 5;

module mount_hole() {
  translate([(outer_width/2)-4,41,0])
    cylinder(d=mount_hole_diameter, h=depth, center=true, $fn=20);
}

difference() {
  difference() {
    difference() {
      cube([outer_width, outer_height, depth], center=true);
      cube([inner_width, inner_height, depth], center=true);
    }
    translate([0,43,0]) cube([inset_width, inset_height, depth], center=true);
    mirror([0,1,0]) {
      translate([0,43,0]) cube([inset_width, inset_height, depth], center=true);
    }
  }
  mirror([0,0,0]) mount_hole();
  mirror([1,0,0]) mount_hole();
  mirror([0,1,0]) {
    mirror([0,0,0]) mount_hole();
    mirror([1,0,0]) mount_hole();
  }
  
}