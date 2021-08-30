if (instance_exists(o_player)) {
	if (place_meeting(x,y,o_player)) {
		global.p_x = x;
		global.p_y = y;
		global.p_d = dir;
	}
}