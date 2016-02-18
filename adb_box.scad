inner_width = 32;
inner_length = 34.5;
inner_height = 10;
wall_width = 2;
floor_height = 1;


difference() {
  union() {
    difference() {
      cube([inner_width+wall_width, inner_length+wall_width, inner_height], center=true);
      translate([0,0,floor_height]) {
        cube([inner_width, inner_length, inner_height], center=true); 
      }
    }

    // anchors
    translate([(inner_width/2)-4,-(inner_length/2)+4,-2]) cube([8, 8, 5], center=true);
    translate([-(inner_width/2)+4,(inner_length/2)-6,-2]) cube([4, 4, 5], center=true);
    translate([-(inner_width/2)+4,-(inner_length/2)+8,-2]) cube([8, 4, 3], center=true);
    translate([(inner_width/2)-6,(inner_length/2)-8,-2]) cube([4, 8, 3], center=true);

    // sidecar

    difference() {
      translate([0,-27.25,0]) {
        difference() {
          translate([0,0,inner_height]) cube([inner_width+wall_width,20,inner_height*3], center=true);
          translate([-2,2,(inner_height)*1.55]) cube([inner_width+wall_width-1,18,(inner_height*2)+1], center=true);
          rotate([-50,0,0]) {
            translate([2,-10,(inner_height)*2.15]) cube([inner_width*2,inner_height*4,inner_height*2], center=true);
          }
        }
      }

      translate([0,-36,15]) {
        rotate([90,0,0]) {
          cylinder(h=4, d=12.5, center=true, $fn=50);
          translate([10,0,0]) cylinder(h=4, d=3, center=true, $fn=50);
          translate([-10,0,0]) cylinder(h=4, d=3, center=true, $fn=50);
        }
      }
    }
  }
  // isp notch
  translate([-13,-(inner_length/2),inner_height/2]) {
    cube([2,2,2], center=true);
  }
}
