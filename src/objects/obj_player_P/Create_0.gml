hp = 100;
sp = 5;
inv_time = 60;
spr = spr_player;
take_damage = function(_damage){
    if (alarm[0] == -1){
        hp -= _damage;
        alarm[0] = inv_time;
    }
}