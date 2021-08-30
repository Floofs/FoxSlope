function get_tile_floor_slope(_x,_y,_layer) {
	var _tm = layer_tilemap_get_id(_layer);
	var _tile = tilemap_get_at_pixel(_tm,_x,bbox_bottom+(_y-y));
	var _tileIndex = tile_get_index(_tile);
	
	var _angle = 0;
	switch (_tileIndex) {
		case 2: _angle = 45; break;
		case 3: _angle = -45; break;
		case 4: _angle = 22.5; break;
		case 5: _angle = 22.5; break;
		case 6: _angle = -22.5; break;
		case 7: _angle = -22.5; break;
		case 8: _angle = 67.5; break;
		case 9: _angle = 67.5; break;
		case 10: _angle = -67.5; break;
		case 11: _angle = -67.5; break;
	}
	
	return _angle;
}