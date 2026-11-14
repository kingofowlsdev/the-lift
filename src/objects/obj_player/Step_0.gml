var axis_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var axis_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var len = sqrt(axis_x * axis_x + axis_y * axis_y);
if (len > 0) {
    axis_x /= len; 
    axis_y /= len; 
}

hsp = axis_x * spd; 
vsp = axis_y * spd; 

x += hsp; 
y += vsp; 