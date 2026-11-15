global.__shd_flash_uniform_intensity = shader_get_uniform(shd_flash, "intensity"); 

/// @arg {real} intensity 
function draw_self_flash(_intensity) {
    shader_set(shd_flash); 
    
    shader_set_uniform_f(global.__shd_flash_uniform_intensity, _intensity); 
    
    draw_self(); 
    
    shader_reset(); 
}