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