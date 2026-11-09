draw_self();
draw_text(x,y,gun_selected);
if (!ds_list_empty(guns)){
    draw_sprite_ext(guns[| gun_selected].spr, 0, x + lengthdir_x(30, point_direction(x, y, mouse_x, mouse_y)), y + lengthdir_y(30, point_direction(x, y, mouse_x, mouse_y)), 1, 1, point_direction(x, y, mouse_x, mouse_y), noone, 1)
}
//draw_text(x,y + 64,angle_difference(image_angle, mouse_x));