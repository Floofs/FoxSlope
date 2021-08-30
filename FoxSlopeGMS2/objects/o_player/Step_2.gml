var _lastSprite = sprite_index;

switch (state) {
	case PLAYER.FREE: {
		if (rolling) || (jumping) sprite_index = anim_roll;
		else if (grounded) {
			if (skidding) sprite_index = anim_skid;
			else if (abs(hsp) <= 0) && (!slipping) sprite_index = anim_idle;
			else if (abs(hsp) <= run) sprite_index = anim_jog;
			else sprite_index = anim_run;
		}
		else {
			if (vsp <= 0) sprite_index = anim_rise;
			else sprite_index = anim_fall;
		}
	} break;
	
	case PLAYER.PATH: {
		sprite_index = anim_roll;
		if (x < xprevious) dir = -1;
		else if (x > xprevious) dir = 1;
	} break;
}

if (sprite_index != anim_roll) {
	angle_tail = 0;
}
else {
	if (x != xprevious) || (y != yprevious) {
		var _na = point_direction(x,y,xprevious,yprevious);
		angle_tail = _na;
	}
}

if (sprite_index == anim_jog) || (sprite_index == anim_roll) {
	current_frame += (sprite_get_speed(sprite_index) / room_speed) * ((abs(hsp)+1) / 3);
}
else {
	current_frame += sprite_get_speed(sprite_index) / room_speed;
}
if (current_frame >= sprite_get_number(sprite_index)) current_frame -= sprite_get_number(sprite_index);

if (_lastSprite != sprite_index) current_frame = 0;