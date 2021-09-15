var _kLeft = keyboard_check(vk_left);
var _kRight = keyboard_check(vk_right);
var _kUp = keyboard_check(vk_up);
var _kDown = keyboard_check(vk_down);

var _kJump = keyboard_check_pressed(ord("A"));
var _kFall = keyboard_check_released(ord("A"));

var _kFast = keyboard_check_pressed(ord("D"));

switch (state) {
	case PLAYER.FREE: {
		var _mod = 0;
		if (grounded) {
			if (angle != 0) {
				_mod = 0.125;
				if (rolling) {
					if (sign(hsp) == sign(angle)) _mod = 0.08;
					else _mod = 0.3;
				}
			}
			
			if (_kFast && abs(hsp) <= run) {
				rolling = true;
				hsp = dir*(lmt/2);
			}
		}
		
		if (_kDown && grounded && abs(hsp) > 1.5) rolling = true;
		
		skidding = false;
		if (_kLeft) {
			if (controlLock <= 0) {
				if (!rolling) {
					if (hsp >= 0) {
						hsp -= acc*1.5;
						if (hsp > 0) skidding = true;
					}
					else if (hsp > -run) hsp -= acc;
				}
				else {
					if (hsp > 0) rolling = false;	
				}
				dir = -1;
			}
		}
		else if (_kRight) {
			if (controlLock <= 0) {
				if (!rolling) {
					if (hsp <= 0) {
						hsp += acc*1.5;
						if (hsp < 0) skidding = true;
					}
					else if (hsp < run) hsp += acc;
				}
				else {
					if (hsp < 0) rolling = false;	
				}
				dir = 1;
			}
		}
		else {
			if (controlLock <= 0) {
				if (!grounded) { } //do nothing
				else if (rolling) hsp = approach(hsp,0,dec/4);
				else hsp = approach(hsp,0,dec);
			}
		}
		
		//Slip on slopes
		slipping = false;
		if (grounded) {
			var _disp = _mod*sin(degtorad(-angle));
			
			if (!rolling && abs(angle) < 22) _disp = 0;
			
			hsp += _disp;
			if (abs(_disp) > 0) slipping = true;
		}
		
		if (grounded) hsp = clamp(hsp,-lmt,lmt);
		else hsp = clamp(hsp,-8,8);
		
		if (!grounded) vsp += grv;
		else jumps = jumpsMax;
		vsp = clamp(vsp,-TILE_SIZE,TILE_SIZE);
		
		//var _lastGrounded = grounded;
		tile_collision();
		
		if (_kJump) {
			if (grounded) {
				hsp += jmp * -sin(degtorad(angle));
				vsp = -jmp * cos(degtorad(angle));
				grounded = false;
				rolling = false;
				jumping = true;
				angle = 0;
				controlLock = 0;
			}
			else if (jumping) && (jumps > 0) {
				jumps--;
				vsp = -jmp*0.75;
				jumping = false;
				rolling = false;
				grounded = false;
			}
		}
		
		if (vsp < -3 && !grounded && jumping &&  _kFall) {
			vsp *= 0.5;
		}
	} break;
		
	case PLAYER.PATH: {
		if (path_ended) {
			state = PLAYER.FREE;
			hsp = spd * cos(degtorad(direction));
			vsp = spd * -sin(degtorad(direction));
			controlLock = controlLockMax;
			rolling = true;
			path_ended = false;
		}
	} break;
}