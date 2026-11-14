if (!instance_exists(target)) {
    exit; 
}

x = target.x + offset_x; 
y = target.y + offset_y; 

var aim_x = mouse_x; 
var aim_y = mouse_y; 
var target_dir = point_direction(x, y, aim_x, aim_y); 

image_angle = target_dir; 
image_yscale = aim_x > x ? 1 : -1; 