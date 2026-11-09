var hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var ver = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var len = sqr(hor * hor + ver * ver);

if (len != 0){
    hor /= len;
    ver /= len;
}
x += hor * sp;
y += ver * sp;

if (keyboard_check_pressed(vk_space)){
    slide(); 
}

if (alarm[1] != -1){
    x += lengthdir_x(140, point_direction(x, y, mouse_x, mouse_y)) / inv_frames;
    y += lengthdir_y(140, point_direction(x, y, mouse_x, mouse_y)) / inv_frames;
}