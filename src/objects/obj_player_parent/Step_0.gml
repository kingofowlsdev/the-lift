var hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var ver = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var len = sqr(hor * hor + ver * ver);
/*
if (len != 0){
    hor /= len;
    ver /= len;
}
*/
x += hor * sp;
y += ver * sp;

// slide
if (keyboard_check_pressed(vk_space)){
    slide(); 
}
// slide too
if (alarm[1] != -1){
    x += lengthdir_x(dash_dist, point_direction(x, y, mouse_x, mouse_y)) / inv_frames;
    y += lengthdir_y(dash_dist, point_direction(x, y, mouse_x, mouse_y)) / inv_frames;
}

// pickup guns
if (keyboard_check_pressed(ord("E"))){
    var near_gun = instance_nearest(x, y, obj_gun_parent);
    if (distance_to_object(near_gun) <= dist_to_pickup){
        var gun = new scr_gun_pickup(near_gun.damage, near_gun.reload_time, near_gun.sprite_index, near_gun.magazine, near_gun.bull_magazine, near_gun.ammo, near_gun.bullet, near_gun.object_index);
        ds_list_add(guns, gun);
        instance_destroy(near_gun);
    }
}
// select other gun
if (!ds_list_empty(guns)){
    if (mouse_wheel_up()){
        gun_selected++;   
    }
    if (mouse_wheel_down()){
        gun_selected--;
    }
}

gun_selected = clamp(gun_selected, 0, ds_list_size(guns) - 1);

// shoot
if (mouse_check_button_pressed(mb_left)){
    shoot();
}