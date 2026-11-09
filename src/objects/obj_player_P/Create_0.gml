hp = 100;
sp = 5;
inv_time = 60;
spr = spr_player;
inv = 0;
slide_reload = 60;
inv_frames = 5;

take_damage = function(_damage, _id_bull){
    if (alarm[0] == -1) and (inv == 0){
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