#region Input movement axis. 

var axis_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var axis_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// normalises direction vector 
var len = sqrt(axis_x * axis_x + axis_y * axis_y);
if (len > 0) {
    axis_x /= len; 
    axis_y /= len; 
}

#endregion 

#region Calculates the movement speeds. 

var is_moving = (axis_x != 0) || (axis_y != 0);
var move_spd_amt = is_moving ? move_accel_amt : move_decell_amt; 

move_hsp = lerp(move_hsp, axis_x * move_spd_max, move_spd_amt); 
move_vsp = lerp(move_vsp, axis_y * move_spd_max, move_spd_amt); 

#endregion 

#region Dash. 

dash_cd_timer --; 

var is_dash_ready = dash_cd_timer <= 0; 
var dash_key = mouse_check_button_pressed(mb_right); 
if (is_dash_ready && dash_key) {
    dash_cd_timer = dash_cd_time; 
    
    dash_dir = point_direction(x, y, mouse_x, mouse_y);
    dash_spd = dash_spd_max; 
}

dash_spd = max(0, dash_spd - dash_decell); 
dash_hsp = lengthdir_x(dash_spd, dash_dir);
dash_vsp = lengthdir_y(dash_spd, dash_dir);

if (dash_spd > 0) {
    move_hsp = 0;
    move_vsp = 0; 
}

#endregion 

#region Resultant vector. 

hsp = move_hsp + dash_hsp; 
vsp = move_vsp + dash_vsp; 

#endregion 

#region Collision and position transforming. 

var solid_stuffs = [COLMAP_TILEMAP]; 
if (place_meeting(x + hsp, y, solid_stuffs)) {
    while(!place_meeting(x + sign(hsp), y, solid_stuffs)) {
        x += sign(hsp); 
    }
    
    hsp = 0; 
    
    move_hsp = 0;
    
    dash_spd = 0; 
    dash_hsp = 0; 
}

x += hsp; 

if (place_meeting(x, y + vsp, solid_stuffs)) {
    while(!place_meeting(x, y + sign(vsp), solid_stuffs)) {
        y += sign(vsp); 
    }
    
    vsp = 0; 
    
    move_vsp = 0;
    
    dash_spd = 0; 
    dash_vsp = 0; 
}

y += vsp; 

#endregion 