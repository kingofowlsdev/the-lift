global.__bsp_min_w = 3; 
global.__bsp_min_h = 3; 
global.__bsp_spread_v = 2; 
global.__bsp_spread_h = 2; 
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
    
    switch(split_type) {
        case(BSP_SPLIT.HORIZONTAL):
            split_h();
            break;
        
        case(BSP_SPLIT.VERTICAL):
            split_v();
            break;
    }
    
    static split_h = function() {
        var middle = y1 + ((y2 - y1) div 2) + irandom_range(-global.__bsp_spread_v, global.__bsp_spread_v); 
        
        // if the size of the new room is smaller than the minimal one, we break the recurstion 
        if (((middle - y1) < global.__bsp_min_h) || ((y2 - middle - 1) < global.__bsp_min_h)) {
            exit; 
        }
        
        array_push(global.__bsp_array, new BSP_Node(x1, y1, x2, middle, BSP_SPLIT.VERTICAL));
        array_push(global.__bsp_array, new BSP_Node(x1, middle, x2, y2, BSP_SPLIT.VERTICAL));
    }
    
    static split_v = function() {
        var center = x1 + ((x2 - x1) div 2) + irandom_range(-global.__bsp_spread_h, global.__bsp_spread_h); 
        
        if (((center - x1) < global.__bsp_min_w) || ((x2 - center - 1) < global.__bsp_min_w)) {
            exit; 
        }
        
        array_push(global.__bsp_array, new BSP_Node(x1, y1, center, y2, BSP_SPLIT.HORIZONTAL));
        array_push(global.__bsp_array, new BSP_Node(center, y1, x2, y2, BSP_SPLIT.HORIZONTAL));
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