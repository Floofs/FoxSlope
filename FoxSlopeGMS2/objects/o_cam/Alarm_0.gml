//Add code here to make the camera position snap to the correct spot
//so it doesn't have to catch up when the room loads

switch (state) {
	case CAMERA_STATES.tiled: {
		if (target != noone) && (instance_exists(target)) {
			x = clamp(target.x div width,0,(room_width div width)-1)*width;
			y = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
		}
	} break;
	
	case CAMERA_STATES.tiled_v: {
		if (target != noone) && (instance_exists(target)) {
			var _xx = clamp(target.x div width,0,(room_width div width)-1)*width;
			var _ty = target.bbox_bottom-target.bbox_top;
			var _yy = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
			
			x = _xx;
			y = _yy;
		}
	} break;
}