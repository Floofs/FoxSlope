function tile_meeting(_x,_y,_layer) {
	var _tm = layer_tilemap_get_id(_layer);
	
	var _x1 = tilemap_get_cell_x_at_pixel(_tm,bbox_left+(_x-x),y);
	var _y1 = tilemap_get_cell_y_at_pixel(_tm,x,bbox_top+(_y-y));
	var _x2 = tilemap_get_cell_x_at_pixel(_tm,bbox_right+(_x-x),y);
	var _y2 = tilemap_get_cell_y_at_pixel(_tm,x,bbox_bottom+(_y-y));
	
	for (var _xx = _x1; _xx <= _x2; _xx++) {
		for (var _yy = _y1; _yy <= _y2; _yy++) {
			var _index = tile_get_index(tilemap_get(_tm,_xx,_yy));
			if (_index >= 1) return _index;
		}
	}
	
	return false;
}

function tile_meeting_precise(_x,_y,_layer) {
	var _tm = layer_tilemap_get_id(_layer);
	var _checker = o_precise_tile_checker;
	if (!instance_exists(_checker)) instance_create_depth(0,0,0,_checker);
	
	var _x1 = tilemap_get_cell_x_at_pixel(_tm,bbox_left+(_x-x),y);
	var _y1 = tilemap_get_cell_y_at_pixel(_tm,x,bbox_top+(_y-y));
	var _x2 = tilemap_get_cell_x_at_pixel(_tm,bbox_right+(_x-x),y);
	var _y2 = tilemap_get_cell_y_at_pixel(_tm,x,bbox_bottom+(_y-y));
	
	for (var _xx = _x1; _xx <= _x2; _xx++) {
		for (var _yy = _y1; _yy <= _y2; _yy++) {
			var _tile = tile_get_index(tilemap_get(_tm,_xx,_yy));
			if (_tile != 0) {
				if (_tile == 1) {
					_checker.x = _xx+1 * TILE_SIZE;
					_checker.y = _yy+1 * TILE_SIZE;
					_checker.image_index = _tile;
				
					if (!place_meeting(_x,_y,_checker)) {
						_checker.x = _xx-1 * TILE_SIZE;
						_checker.y = _yy+1 * TILE_SIZE;
						_checker.image_index = _tile;
						
						if (place_meeting(_x,_y,_checker)) continue;
					}
					else continue;
					return true;
				}
		
				_checker.x = _xx * TILE_SIZE;
				_checker.y = _yy * TILE_SIZE;
				_checker.image_index = _tile;
				
				if (place_meeting(_x,_y,_checker)) return true;
			}
		}
	}
	
	return false;
}