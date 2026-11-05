randomize(); 

for(var i = 1; i < COLMAP_WIDTH - 1; i ++) {
    for(var j = 1; j < COLMAP_HEIGHT - 1; j ++) {
        tilemap_set(COLMAP_TILEMAP, 1, i, j); 
    }
}

new BSP_Node(1, 1, COLMAP_WIDTH - 1, COLMAP_HEIGHT - 1); 