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

#region Inventory

global.select_cell = clamp(global.select_cell, 0, global.max_cells - 1);

var cell_switch = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);

global.select_cell += cell_switch;

body_select_cell = clamp(body_select_cell, 0, body_max_cells - 1);

if (keyboard_check_pressed(ord("P"))) {
    body_inv_isActive = !body_inv_isActive;
}

var cell_switch_body = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

body_select_cell += cell_switch_body;

var item = instance_nearest(x, y, obj_item_parent);

if (distance_to_object(item) <= global.pickup_distance) and (keyboard_check_pressed(ord("E"))) {
    if (item.inv == INVENTORY.BASIC) {
        for (var i = 0; i < global.max_cells; i++) {
            if (global.inv[i] == 0) {
                global.inv[i] = new Item(item.name, item.sprite_index, item.count, item.max_count, item.passive_bonus, item.object_index);
                instance_destroy(item);
                exit;
            }
            else{ 
                if (is_struct(global.inv[i])) && (global.inv[i].name == item.name) && (global.inv[i].count + item.count <= global.inv[i].max_count){
                    global.inv[i].count += item.count;
                    instance_destroy(item);
                    exit;
                }
            }
        }
    }
    
    if (item.inv == INVENTORY.BODY) && (body_inv[item.inv_cell] == 0) {
        body_inv[item.inv_cell] = new Item(item.name, item.sprite_index, item.count, item.max_count, item.passive_bonus, item.object_index);
        instance_destroy(item);
    }
}

if (keyboard_check_pressed(ord("Q"))) {
    if (body_inv_isActive == 0) {
        if (is_struct(global.inv[global.select_cell])) {
            instance_create_depth(x, y, 0, global.inv[global.select_cell].obj);
            global.inv[global.select_cell].count--;
            if (global.inv[global.select_cell].count <= 0) {
                global.inv[global.select_cell] = 0;
            }
        }
    }
    else {
        if (is_struct(body_inv[body_select_cell])) {
            instance_create_depth(x, y, 0, body_inv[body_select_cell].obj);
            body_inv[body_select_cell] = 0;
        }
    }
}

#endregion