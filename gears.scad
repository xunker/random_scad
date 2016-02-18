include <parametric_involute_gear_v5.0.scad>

// gear (circular_pitch=700,
//  gear_thickness = 5.65,
//  rim_thickness = 5.65,
//  rim_width=0, // 2
//  hub_thickness = 5.65, // 7.0
//  hub_diameter = 7.9,
//  bore_diameter = 7.9,
//  number_of_teeth = 26,
//  clearance=0.5,
//  circular_pitch=200,
//  circles=5); // 9


// gear (
//  // circular_pitch=700,
//  gear_thickness = 5.65,
//  rim_thickness = 5.65,
//  // rim_width=2, // 2
//  hub_thickness = 5.65, // 7.0
//  hub_diameter = 7.9,
//  bore_diameter = 7.9,
//  number_of_teeth = 15,
//  clearance=0.5,
//  circular_pitch=200,
//  circles=5); // 9

gear (
 // circular_pitch=700,
 gear_thickness = 5.65,
 rim_thickness = 5.65,
 // rim_width=2, // 2
 hub_thickness = 8, // 7.0
 hub_diameter = 9,
 bore_diameter = 7.9,
 number_of_teeth = 10,
 // clearance=0.5,
 circular_pitch=200,
 circles=5); // 9
translate([2.5,-3,0]) cube([1.5,6,8]);

// gear (
//  // circular_pitch=700,
//  gear_thickness = 5.65,
//  rim_thickness = 5.65,
//  rim_width=2,
//  hub_thickness = 5.65,
//  hub_diameter = 12,
//  bore_diameter = 6.4,
//  number_of_teeth = 20, // 19
//  clearance=0.5,
//  circular_pitch=200,
//  circles=0); // 9
