if (instance_exists(o_player)) {
	if (place_meeting(x,y,o_player) && o_player.state != PLAYER.PATH) {
		with (o_player) {
			state = PLAYER.PATH;
			spd = lmt;
			hsp = 0;
			vsp = 0;
			x = other.x;
			y = other.y+8;
			path_start(other.path,lmt,path_action_stop,false);
		}
	}
}