board_width = 52.5;
board_length = 34.5;
board_height = 1;

floor_thickness = 0.3*3;
wall_width = 0.4*3;

box_height = 15;
standoff_height = 7;
standoff_wall_thickness = 1.6;

terminal_block_width = 27;
terminal_block_length = wall_width;
terminal_block_height = 7;
terminal_block_x_offset = 0;
terminal_block_y_offset = wall_width;
terminal_block_z_offset = floor_thickness+standoff_height+board_height;

screw_radius = 1.75;
screw_offset = 3.5; // x and y

module basic_box() {
  difference() {
    cube([board_width+(wall_width*2), board_length+(wall_width*2), box_height]);
    translate([wall_width, wall_width, floor_thickness]) cube([board_width, board_length, box_height]);
  }
}

module standoff() {
  difference() {
    // cylinder(h=standoff_height, r=screw_radius+standoff_wall_thickness, $fn=20);
    cylinder(h=standoff_height, r1=screw_radius+standoff_wall_thickness+2.5, r2=screw_radius+standoff_wall_thickness, $fn=20);
    cylinder(h=standoff_height, r=screw_radius, $fn=20);
  }
}

module full_box() {

  basic_box();

  standoff_x_and_y = screw_offset+(wall_width)+standoff_wall_thickness;

  // translate([standoff_x_and_y, standoff_x_and_y, floor_thickness]) standoff();
  // translate([(board_width+(wall_width*2))-standoff_x_and_y, (board_length+(wall_width*2))-standoff_x_and_y, floor_thickness]) standoff();
  translate([standoff_x_and_y, (board_length+(wall_width*2))-standoff_x_and_y, floor_thickness]) standoff();
  translate([(board_width+(wall_width*2))-standoff_x_and_y, standoff_x_and_y, floor_thickness]) standoff();
}


difference() {
  full_box();
  // translate([board_width/4.9, board_length/5, 0])
  //   cube([board_width/1.6, board_length/1.5, floor_thickness*2]);

  translate([terminal_block_x_offset,terminal_block_y_offset,terminal_block_z_offset]) cube([terminal_block_length, terminal_block_width, terminal_block_height]);

  translate([(board_width+(wall_width))-terminal_block_x_offset,board_length+(wall_width)-terminal_block_width,terminal_block_z_offset]) cube([terminal_block_length, terminal_block_width, terminal_block_height]);  
}
