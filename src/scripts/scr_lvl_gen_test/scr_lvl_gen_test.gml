global.__bsp_min_w = 24; 
global.__bsp_min_h = 15; 
global.__bsp_spread_v = 10; 
global.__bsp_spread_h = 7; 
global.__bsp_array = []; 

enum BSP_SPLIT {
    VERTICAL,
    HORIZONTAL
}

function BSP_Node(_x1, _y1, _x2, _y2, _split_type = BSP_SPLIT.HORIZONTAL) constructor {
    x1 = _x1; 
    y1 = _y1; 
    x2 = _x2; 
    y2 = _y2; 
    
    split_type = _split_type; 
    
    // geometrically, nodes can be "top" and "bottom", not "left" and "right" only 
    left_node = undefined; 
    right_node = undefined; 
    
    center = x1 + ((x2 - x1) div 2) + irandom_range(-global.__bsp_spread_h, global.__bsp_spread_h); 
    middle = y1 + ((y2 - y1) div 2) + irandom_range(-global.__bsp_spread_v, global.__bsp_spread_v); 
    
    switch(split_type) {
        case(BSP_SPLIT.HORIZONTAL):
            split_h();
            break;
        
        case(BSP_SPLIT.VERTICAL):
            split_v();
            break;
    }
    
    static split_h = function() {
        // if the size of the new room is smaller than the minimal one, we clear the region and break the recurstion 
        if (((middle - y1) < global.__bsp_min_h) || ((y2 - middle) < global.__bsp_min_h)) {
            drunkard_walk_clear_region(x1, y1, x2, y2); 
            
            exit; 
        }
        
        left_node = new BSP_Node(x1, y1, x2, middle, BSP_SPLIT.VERTICAL); 
        right_node = new BSP_Node(x1, middle, x2, y2, BSP_SPLIT.VERTICAL); 
        
        colmap_clear_line_v(center, left_node.middle, right_node.middle);
        
        array_push(global.__bsp_array, left_node);
        array_push(global.__bsp_array, right_node);
    }
    
    static split_v = function() {
        if (((center - x1) < global.__bsp_min_w) || ((x2 - center) < global.__bsp_min_w)) {
            drunkard_walk_clear_region(x1, y1, x2, y2); 
            
            exit; 
        }
        
        left_node = new BSP_Node(x1, y1, center, y2, BSP_SPLIT.HORIZONTAL); 
        right_node = new BSP_Node(center, y1, x2, y2, BSP_SPLIT.HORIZONTAL); 
        
        colmap_clear_line_h(left_node.center, right_node.center, middle);

        array_push(global.__bsp_array, left_node);
        array_push(global.__bsp_array, right_node);
    }
    
    static draw = function() {
        var s = COLMAP_TILE_SIZE; 
        draw_rectangle(x1 * s, y1 * s, x2 * s, y2 * s, true); 
    }
}

function BSP_Draw() {
    for(var i = 0; i < array_length(global.__bsp_array); i ++) {
        global.__bsp_array[i].draw(); 
    }
}

global.__frunkard_walk_step = 3; 
function drunkard_walk_clear_region(_x1, _y1, _x2, _y2, _iters = 10, _steps = 20) {
    repeat(_iters) {
        var cell_x = (_x1 + (_x2 - _x1) div 2);
        var cell_y = (_y1 + (_y2 - _y1) div 2); 
        
        repeat(_steps) {
            colmap_clear_circle(cell_x, cell_y); 
            
            var dir = choose(0, 90, 180, 270);
            
            var cell_x_new, cell_y_new; 
            /*do*/ {
                cell_x_new = cell_x + lengthdir_x(global.__frunkard_walk_step, dir);
                cell_y_new = cell_y + lengthdir_y(global.__frunkard_walk_step, dir);
            } //until(cell_x_new == clamp(cell_x_new, _x1, _x2) && cell_y_new == clamp(cell_y_new, _y1, _y2)); 
            
            cell_x = cell_x_new;
            cell_y = cell_y_new; 
        }
    }
}

function colmap_clear_line_h(_x1, _x2, _y) {
    for(var i = min(_x1, _x2); i < max(_x1, _x2); i ++) {
        tilemap_set(COLMAP_TILEMAP, 0, i, _y); 
    }
}

function colmap_clear_line_v(_x, _y1, _y2) {
    for(var j = min(_y1, _y2); j < max(_y1, _y2); j ++) {
        tilemap_set(COLMAP_TILEMAP, 0, _x, j); 
    }
}

// Bresenham's algorithm
function colmap_clear_circle(_cx, _cy, _radius = 4) {
    var _x = 0; 
    var _y = _radius; 
    var d = 3 - 2 * _radius; 

    while(_x <= _y) {
        colmap_clear_line_h(_cx - _x, _cx + _x, _cy + _y);
        colmap_clear_line_h(_cx - _x, _cx + _x, _cy - _y);
        colmap_clear_line_h(_cx - _y, _cx + _y, _cy + _x);
        colmap_clear_line_h(_cx - _y, _cx + _y, _cy - _x);
        
        if (d > 0) { 
            d = d + 4 * (_x - _y) + 10; 
            _y --; 
        } else {
            d = d + 4 * _x + 6; 
        }
        
        _x ++; 
    }
}

function level_generate() {
    for(var i = 1; i < COLMAP_WIDTH - 1; i ++) {
       for(var j = 1; j < COLMAP_HEIGHT - 1; j ++) {
           tilemap_set(COLMAP_TILEMAP, 1, i, j); 
       }
   }

    var root = new BSP_Node(1, 1, COLMAP_WIDTH - 1, COLMAP_HEIGHT - 1);
}