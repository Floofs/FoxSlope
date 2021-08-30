if (controlLock > 0) controlLock--;

if (abs(angle) >= 45) && (abs(hsp) < run) controlLock = controlLockMax;

switch (state) {
	case PLAYER.FREE: {
		if (rolling) {
			if (grounded && abs(hsp) <= 0.5 && angle == 0) rolling = false;
		}
		if (grounded) {
			if (jumping && vsp >= 0) jumping = false;
		}
	} break;
}