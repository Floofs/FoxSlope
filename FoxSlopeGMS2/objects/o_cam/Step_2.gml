if (!loaded) {
	loaded = true;
	switch (state) {
		case CAMERA_STATES.tiled: {
			if (target != noone) && (instance_exists(target)) {
				var _xx = clamp(target.x div width,0,(room_width div width)-1)*width;
				var _ty = target.bbox_bottom-target.bbox_top;
				var _yy = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
			
				x = _xx;
				y = _yy;
			}
		} break;
	
		case CAMERA_STATES.tiled_v: {
			if (target != noone) && (instance_exists(target)) {
				var _xx = target.x-round(width/2);
				var _ty = target.bbox_bottom-target.bbox_top;
				var _yy = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
			
				x = clamp(_xx,xMin,xMax-width);
				y = _yy;
			}
		} break;
	
		case CAMERA_STATES.follow: {
			if (target != noone) && (instance_exists(target)) {
				var _ty = target.bbox_bottom-target.bbox_top;
				var _xx = target.x-round(width/2);
				var _yy = target.y-(_ty div 2)-round(height/2);
				
				x = clamp(_xx,xMin,xMax-width);
				y = clamp(_yy,yMin,yMax-height);
			}
		} break;
	
		case CAMERA_STATES.point: {
			x = xTo;
			y = yTo;
		} break;
	
		case CAMERA_STATES.zoom: {
			x = xTo;
			y = yTo;
			zoom = zoomTo;
		} break;
	}
}
if (!active) exit;

switch (state) {
	case CAMERA_STATES.tiled: {
		if (target != noone) && (instance_exists(target)) {
			var _xx = clamp(target.x div width,0,(room_width div width)-1)*width;
			var _ty = target.bbox_bottom-target.bbox_top;
			var _yy = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
			
			var _freeze = false;
			if (x != _xx) {
				x = lerp(x,_xx,0.2);
				if (round(x) == _xx) x = _xx;
				_freeze = true;
			}
			if (y != _yy) {
				y = lerp(y,_yy,0.2);
				if (round(y) == _yy) y = _yy;
				_freeze = true;
			}
			
			/*
			if (_freeze) with (o_actor) active = false;
			else with (o_actor) active = true;
			*/
		}
	} break;
	
	case CAMERA_STATES.tiled_v: {
		if (target != noone) && (instance_exists(target)) {
			var _xx = target.x-round(width/2);
			var _ty = target.bbox_bottom-target.bbox_top;
			var _yy = clamp((target.y-(_ty div 2)) div height,0,(room_height div height)-1)*height;
			
			if (x < xMin) x = lerp(x,xMin,0.5);
			else if (x >= xMax-width) x = lerp(x,xMax-width,0.5);
			else x = _xx;
			//x = approach(x,clamp(_xx,xMin,xMax-width),8);
			
			var _freeze = false;
			if (y != _yy) {
				y = lerp(y,_yy,0.2);
				if (round(y) == _yy) y = _yy;
				_freeze = true;
			}
			
			/*
			if (_freeze) with (o_actor) active = false;
			else with (o_actor) active = true;
			*/
		}
	} break;
	
	case CAMERA_STATES.follow: {
		if (target != noone) && (instance_exists(target)) {
			var _ty = target.bbox_bottom-target.bbox_top;
			var _xx = target.x-round(width/2);
			var _yy = target.y-(_ty div 2)-round(height/2);
		
			var _xdist = abs(_xx-clamp(_xx,xMin,xMax-width));
			if (_xdist > 8) x = lerp(x,clamp(_xx,xMin,xMax-width),0.1);
			else x = approach(x,clamp(_xx,xMin,xMax-width),8);
			
			var _ydist = abs(_yy-clamp(_yy,yMin,yMax-height));
			if (_ydist > 8) y = lerp(y,clamp(_yy,yMin,yMax-height),0.1);
			else y = approach(y,clamp(_yy,yMin,yMax-height),8);
		}
	} break;
	
	case CAMERA_STATES.point: {
		x = lerp(x,xTo,0.5);
		y = lerp(y,yTo,0.5);
		
		if (round(x) == xTo) x = xTo;
		if (round(y) == yTo) y = yTo;
	} break;
	
	case CAMERA_STATES.zoom: {
		x = lerp(x,xTo,0.5);
		y = lerp(y,yTo,0.5);
		zoom = lerp(zoom,zoomTo,0.1);
		
		if (round(x) == xTo) x = xTo;
		if (round(y) == yTo) y = yTo;
	} break;
}

x = clamp(x,0,room_width-(width/zoom));
y = clamp(y,0,room_height-(height/zoom));

camera_set_view_size(camera,width/zoom,height/zoom);
camera_set_view_pos(camera,round(x),round(y)+(shaky*irandom_range(-2,2)));

//Move the Background Layers
if (layer_exists(layer_bg1)) {
	layer_y(layer_bg1,camera_get_view_y(view_camera[0])+G_HEIGHT-64);
}
if (layer_exists(layer_bg2)) {
	layer_y(layer_bg2,camera_get_view_y(view_camera[0])+G_HEIGHT-128);
}
if (layer_exists(layer_bg3)) {
	layer_y(layer_bg3,camera_get_view_y(view_camera[0])+G_HEIGHT-192);
}