link_length = 10;
link_outer_height = 8;
link_innner_height = 5;
link_outer_width = 8;
link_inner_width = 5;
wall_width = link_outer_width - link_inner_width;

flange_length = 10;

module core_flange() {
  cube([wall_width/2, flange_length, link_outer_height], center=true);
}

module male_flange() {
  core_flange();
  translate([0,0,link_outer_height-2]) {
    difference() {
      cube([wall_width/2, flange_length, link_outer_height], center=true);
      rotate([45,0,0])
        translate([0,0,link_outer_height-2])
          cube([wall_width/2, flange_length, link_outer_height], center=true);
    }
  }
}

module female_flange(inset=-1) {
  core_flange();
  translate([inset,0,-link_outer_height+2]) {
    difference() {
      cube([wall_width/2, flange_length, link_outer_height], center=true);
      rotate([45,0,0])
          translate([0,0,-link_outer_height+2])
            cube([wall_width/2, flange_length, link_outer_height], center=true);
    }
  }
}

module flanges() {
  translate([(wall_width)+0.25,(link_length/2)+flange_length/2,0]) male_flange();
  translate([-(wall_width)-0.25,(link_length/2)+flange_length/2,0]) male_flange();
  translate([(wall_width)+0.25,-(link_length/2)-flange_length/2,0]) female_flange(-1);
  translate([-(wall_width)-0.25,-(link_length/2)-flange_length/2,0]) female_flange(1);
}

difference() {
  cube([link_outer_height,link_length,link_outer_width], center=true);
  cube([link_innner_height,link_length,link_inner_width], center=true);
}
flanges();