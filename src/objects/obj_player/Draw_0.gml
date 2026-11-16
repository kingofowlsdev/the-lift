draw_self();
#region Inventory

if (body_inv_isActive == 0) {
    for (var i = 0; i < global.max_cells; i++) { 
        var sub = global.select_cell == i ? 1 : 0;
        draw_sprite_ext(spr_inv_cell, sub, global.x_cell + 64 * i, global.y_cell, global.scale_cell, global.scale_cell, 0, noone, 1);
        if (is_struct(global.inv[i])){
            draw_sprite_ext(global.inv[i].spr, 0, global.x_cell, global.y_cell + 64 * i, global.scale_cell, global.scale_cell, 0, noone, 1);
            draw_text(global.x_cell + 16, global.y_cell + 14, global.inv[i].count);
        }
    }
}
else {
    for (var i = 0; i < body_max_cells; i++) { 
        var sub_body = body_select_cell == i ? 1 : 0;
        draw_sprite_ext(spr_inv_cell, sub_body, body_x_cell, body_y_cell + 64 * i, global.scale_cell, global.scale_cell, 0, noone, 1);
        if (is_struct(body_inv[i])){
            draw_sprite_ext(body_inv[i].spr, 0, body_x_cell, body_y_cell + 64 * i, global.scale_cell, global.scale_cell, 0, noone, 1);
        }
    }
}

#endregion