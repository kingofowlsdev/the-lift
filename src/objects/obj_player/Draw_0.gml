draw_self(); 

#region On-hit flash. 

flash_intensity -= flash_fade_spd; 

var intensity_clamped = clamp(flash_intensity, 0, 1); 
draw_self_flash(intensity_clamped); 

#endregion 