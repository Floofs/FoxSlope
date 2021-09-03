image_xscale = approach(image_xscale,1,0.25);
image_yscale = approach(image_yscale,1,0.25);

if (instance_exists(o_player)) {
	if (place_meeting(x,y,o_player)) {
		if (o_player.state == PLAYER.FREE) {
			show_debug_message("hit spring");
			with (o_player) {
				x_sub = 0;
				y_sub = 0;
			
				var _hsp = other.pow * cos(degtorad(other.image_angle));
				hsp = _hsp;
			
				var _vsp = other.pow * -sin(degtorad(other.image_angle));
				vsp = _vsp;
			
				if (abs(_hsp) > 0) {
					controlLock = 20;
					dir = sign(hsp);
				}
				jumping = false;
				if (!grounded) || (abs(vsp) > 0) rolling = false;
			}
			image_xscale = 0.5;
			image_yscale = 2;
		}
	}
}