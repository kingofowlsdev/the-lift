// resultant vector 
hsp = 0; 
vsp = 0; 

#region Movement. 

move_hsp = 0; 
move_vsp = 0; 

move_spd_max = 5; 

move_accel_amt = 0.7; 
move_decell_amt = 0.23; 

#endregion 

#region Dash. 

dash_hsp = 0;
dash_vsp = 0;
dash_dir = 0; 

dash_spd_max = 25; 
dash_spd = 0; 

dash_decell = 1.5; 

// cd means "cooldown
dash_cd_time = 60; 
dash_cd_timer = 0; 

#endregion 

#region Health. 

hp_max = 10; 
hp = hp_max; 

knockback_hsp = 0;
knockback_vsp = 0; 
knockback_dir = 0; 

knockback_spd_max = 10; 
knockback_spd = 0; 

knockback_decell = 0.7; 

flash_intensity_max = 1.5; 
flash_intensity = 0; 
flash_fade_spd = 0.1; 

iframes_time = 30; 
iframes_timer = 60; 

/// @desc Hits the player and returns true if succefull or false otherwise. 
/// @arg {real} damage 
/// @arg {real} knockback_dir
/// @returns {bool} 
get_damage = function(_damage, _dir = point_direction(other.x, other.y, x, y)) {
    if (iframes_timer > 0) {
        return false; 
    }
    
    iframes_timer = iframes_time; 
    
    hp -= _damage; 
    
    knockback_dir = _dir; 
    knockback_spd = knockback_spd_max; 
    
    flash_intensity = flash_intensity_max; 
    
    return true; 
}

#endregion 