terminal_width = 1.35;
terminal_length = 3.95;
terminal_height = 1;
terminal_spacing = 1.1;

total_terminal_width = (terminal_width*6) + (terminal_spacing*5);

block_width = 19.75;
block_length = 9.75;
block_height = 2;

module terminal_contact() {
  translate([terminal_width/2, terminal_length/2, 0]) {
    translate([0,-1.25,0]) cylinder(d=1.3, h=block_height, $fn=10);
    translate([0,1.25,0]) cylinder(d=1.3, h=block_height, $fn=10);
  }
}

translate([0,0,terminal_height]) {
  difference() {
    translate([-1.5,-1.5,0]) cube([block_width+3, block_length+3, block_height]);
    cube([block_width, block_length, block_height]);
  }
}

translate([-1.5,-1.5,0]) {
  difference() {
    cube([block_width+3, block_length+3, terminal_height]);

    translate([(block_width-total_terminal_width)/1.3, (block_length-terminal_length)/1.25, 0]) {
      for (terminal_number = [0:5]) {
        if (terminal_number > 0 ) {
          translate([(terminal_number*terminal_width)+(terminal_number*terminal_spacing), 0, 0])
            terminal_contact();
        } else {
          terminal_contact();
        }
      }
    }
  }
}

retainer_length = 10;
retainer_width = 5;
retainer_height = terminal_height*2;

translate([-retainer_length-1.5, (block_width-retainer_width)/6, 0]) {
  difference() {
    cube([retainer_length, retainer_width, retainer_height]);
    translate([1,0,0]) cube([3, retainer_width, retainer_height/3]);
  }
}
translate([block_length+retainer_length+1.5, (block_width-retainer_width)/6, 0]) {
  difference() {
    cube([retainer_length, retainer_width, retainer_height]);
    translate([retainer_length-4,0,0]) cube([3, retainer_width, retainer_height/3]);
  }
}
