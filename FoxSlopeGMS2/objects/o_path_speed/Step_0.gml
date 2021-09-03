if (instance_exists(o_player)) {
	if (place_meeting(x,y,o_player) && o_player.state != PLAYER.PATH
	&& o_player.grounded && abs(o_player.hsp) >= o_player.run) {
		with (o_player) {
			var _hsp = hsp;
			spd = _hsp*2;
			state = PLAYER.PATH;
			hsp = 0;
			vsp = 0;
			x = other.x;
			y = other.y+8;
			path_start(other.path,_hsp,path_action_stop,false);
		}
	}
}