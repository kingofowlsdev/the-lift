#macro COLMAP_LAYER_ID layer_get_id("TileCollisionMap")
#macro COLMAP_TILEMAP layer_tilemap_get_id(COLMAP_LAYER_ID)
#macro COLMAP_TILE_SIZE 4 
#macro COLMAP_WIDTH (room_width div COLMAP_TILE_SIZE)
#macro COLMAP_HEIGHT (room_height div COLMAP_TILE_SIZE)