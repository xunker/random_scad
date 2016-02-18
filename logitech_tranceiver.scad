main_board_width=15.5; // 15.5
main_board_length=51; // 50.04
main_board_height=5;

musb_width=12; // 11.45
musb_length=21.5; // 21.15
musb_height=5; // 4.35

musb_connector_width=5; // 6
musb_connector_length=14; // musb connector opening, 8
musb_connector_height=musb_height+2; // 3.1

wall_thickness=5;
bottom_thickness=1;

module main_board() {
  difference() {
    cube([main_board_width+(wall_thickness*2), main_board_length+(wall_thickness*2), main_board_height+bottom_thickness]);
    translate([wall_thickness,wall_thickness,bottom_thickness]) cube([main_board_width, main_board_length, main_board_height]);
    
  }
}

module musb_board() {
  difference() {
    cube([musb_width+(wall_thickness*2), musb_length+(wall_thickness*2), musb_height+bottom_thickness]);
    translate([wall_thickness,wall_thickness,bottom_thickness]) cube([musb_width, musb_length, musb_height]);
    
  }
}

module musb_connector() {
  cube([musb_connector_width, musb_connector_length, musb_connector_height]);
}

module musb_module() {
  difference() {
    musb_board();
    translate([
      0,
      9, // usb connector opening
      musb_height-musb_connector_height+bottom_thickness
    ]) musb_connector();
  }
}

module screw_hole(d=3) {
  cylinder(h=main_board_height+bottom_thickness, d=d, center=false, $fn=10);
}

module screw_holes(d=3) {
  translate([0,2.5,0]) screw_hole(d=d);
  translate([25.5,2.5,0]) screw_hole(d=d);

  translate([1,-14.5,0]) screw_hole(d=d);
  translate([25,-14.5,0]) screw_hole(d=d);

  translate([2.5,28,0]) screw_hole(d=d);
  translate([23,28,0]) screw_hole(d=d);

  translate([2.5,58,0]) screw_hole(d=d);
  translate([23,58,0]) screw_hole(d=d);
}

module complete_lower() {
  difference() {
    union() {
      main_board();
      translate([
        musb_length+(wall_thickness)+2,
        -musb_width-(wall_thickness),
        0
      ]) rotate([0,0,90]) musb_module();
    }
    // clear wall between both containers
    translate([
      wall_thickness,
      0,
      bottom_thickness+1 // lip to hold board in place
    ]) cube([main_board_width,wall_thickness*2,main_board_height]);

    screw_holes();
  }

  // raise floor to hold musb board better
  translate([
    wall_thickness*1.5,
    -musb_width/2,
    0
  ]) cube([musb_length/2,musb_width/4,musb_connector_height-3]);
}

module main_lid() {
  cube([main_board_width+(wall_thickness*2), main_board_length+(wall_thickness*2), bottom_thickness]);
}

module musb_lid() {
  difference() {
    cube([musb_width+(wall_thickness*2), musb_length+(wall_thickness*2), bottom_thickness]);
    translate([
      0,
      9, // usb connector opening
      musb_height-musb_connector_height+bottom_thickness
    ]) musb_connector();
  }
}

module complete_lid() {
  difference() {
    union() {
      main_lid();
      translate([
        musb_length+(wall_thickness)+2,
        -musb_width-(wall_thickness),
        0
      ]) rotate([0,0,90]) musb_lid();
    }
    screw_holes();
    // led hole
    translate([main_board_width/2+wall_thickness,19.5,0]) screw_hole(d=4);
  }
}

// complete_lower();
translate([0,0,7]) complete_lid();