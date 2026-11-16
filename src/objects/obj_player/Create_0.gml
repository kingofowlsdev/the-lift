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

//enum inventory

enum INVENTORY{
    BASIC,
    BODY
}

#region Inventory

global.pickup_distance = 140;
global.x_cell = 92;
global.y_cell = 92;
global.max_cells = 5;
global.select_cell = 0;
global.scale_cell = 1;
global.inv = [];
for (var i = 0; i < global.max_cells; i++){
    global.inv[i] = 0;
}

#endregion

#region Body-inventory

body_inv_isActive = 0;

enum BODY{
    HEAD,
    TORS,
    LEGS,
    FOOTS
}

body_x_cell = 1760;
body_y_cell = 800;

body_max_cells = 4;
body_select_cell = BODY.HEAD;

body_inv = [];
for (var i = 0; i < body_max_cells; i++){
    body_inv[i] = 0;
}

#endregion