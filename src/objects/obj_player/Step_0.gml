var axis_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var axis_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var len = sqrt(axis_x * axis_x + axis_y * axis_y);
if (len > 0) {
    axis_x /= len; 
    axis_y /= len; 
}

var is_moving = (axis_x != 0) || (axis_y != 0);
var spd_amt = is_moving ? accel_amt : decell_amt; 

hsp = lerp(hsp, axis_x * spd, spd_amt); 
vsp = lerp(vsp, axis_y * spd, spd_amt); 

var solid_stuffs = [COLMAP_TILEMAP]; 
if (place_meeting(x + hsp, y, solid_stuffs)) {
    while(!place_meeting(x + sign(hsp), y, solid_stuffs)) {
        x += sign(hsp); 
    }
    
    hsp = 0; 
}

x += hsp; 

if (place_meeting(x, y + vsp, solid_stuffs)) {
    while(!place_meeting(x, y + sign(vsp), solid_stuffs)) {
        y += sign(vsp); 
    }
    
    vsp = 0; 
}

y += vsp; 