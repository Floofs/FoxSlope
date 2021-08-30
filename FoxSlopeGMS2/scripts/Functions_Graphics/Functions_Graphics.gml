/// @function resize_window(scale)
function resize_window(_scale) {
	if (_scale*G_WIDTH < display_get_width())
	&& (_scale*G_HEIGHT < display_get_height()) {
		window_set_size(G_WIDTH*_scale,G_HEIGHT*_scale);
		window_set_fullscreen(false);
		with (o_game) alarm[0] = 1;
	}
	else {
		window_set_fullscreen(true);
	}
}

function Vec2(_x,_y) constructor {
	x = _x;
	y = _y;
}