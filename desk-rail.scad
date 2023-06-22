module main_body (depth = 200, height = 11.5, width = 8, top_plate_height = 1.5, top_offset = 4,
                    rail_carve_height = 12, rail_separation = 0, back_stopper_width = 2) {
    difference() {
        union() {
            cube([width , depth, height-top_plate_height], center = true);
            top_plate(x_offset = top_offset/2, z_offset = height/2, top_width = width + top_offset,
                        top_plate_height = top_plate_height, depth = depth);
        }
        rail_diagonal = sqrt(pow(rail_carve_height/2,2) + pow(rail_carve_height/2,2));
        rail_carve_separation = -((rail_diagonal/2 - (height-top_plate_height)/2) + rail_separation);
        rail_carve(x_offset = width/2, z_offset = rail_carve_separation,  depth = depth, size = rail_carve_height/2,
                    back_stopper_width = back_stopper_width);
        edgecut();
    }
}

module top_plate (x_offset = 2, z_offset = 1.5, top_width = 12, top_plate_height = 1.5, depth = 200) {
    translate([x_offset, 0, z_offset]) 
        cube([top_width, depth, top_plate_height], center = true);
}

module rail_carve(x_offset = 4, z_offset = 0.75, depth = 200, size = 6, back_stopper_width = 2) {
    translate([x_offset, -back_stopper_width, z_offset])
        rotate([0, 45 , 0])
            cube([size , depth + 1, size], center = true);
}

module right_triangle(side1, side2, corner_radius, triangle_height, center = true){
  translate([corner_radius, corner_radius, 0]){  
    hull(){  
    cylinder(r = corner_radius, h = triangle_height, center = center);
        translate([side1 - corner_radius * 2, 0, 0])
            cylinder(r = corner_radius, h = triangle_height, center = center);
            translate([0, side2 - corner_radius * 2, 0])
                cylinder(r = corner_radius, h = triangle_height, center = center);  
    }
  }
    
}
// TODO: make this function parametric
module edgecut() {
    rotate([90, 0, 0])
        translate([-4.2,-5.2,0]) 
            right_triangle(4.2,12,0.01,202, center = true);
}

main_body(depth = 200, height = 10.1, width = 8, top_plate_height = 1.5, top_offset = 4,
                    rail_carve_height = 12, rail_separation = 0, back_stopper_width = 2);

