hp = 100;
sp = 5;
inv_time = 60;
spr = spr_player;
inv = 0;
slide_reload = 60;
inv_frames = 5;
dist_to_pickup = 100;
guns = ds_list_create();
gun_selected = 0;
dash_dist = 140;

take_damage = function(_damage, _id_bull){
    if (alarm[0] == -1) and (inv == 0) and (_id_bull.en == 1){
        hp -= _damage;
        alarm[0] = inv_time;
        instance_destroy(_id_bull);
    }
}

slide = function(){
    if (alarm[2] == -1){
        alarm[1] = inv_frames;
        alarm[2] = slide_reload;
        inv = 1;
    }
}

shoot = function (){
    if (alarm[3] == -1) and (!ds_list_empty(guns)){
        alarm[3] = guns[| gun_selected].reload_time;
        var bullet = instance_create_depth(x, y, -10, guns[| gun_selected].bullet);
        bullet.dir_x = point_direction(x, y, mouse_x, mouse_y);
        bullet.dir_y = point_direction(x, y, mouse_x, mouse_y);
    }
}