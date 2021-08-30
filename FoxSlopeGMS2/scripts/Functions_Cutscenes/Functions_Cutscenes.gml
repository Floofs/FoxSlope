#region General Use
function cutscene_wait(_seconds) {
	if (timer < 0) {
		timer = _seconds*room_speed;
	}
	else {
		timer--;
		if (timer < 0) current_scene++;
	}
}
#endregion

#region Instance-related
function cutscene_instance_create(_x,_y,_layer,_inst) {
	instance_create_layer(_x,_y,_layer,_inst);
	current_scene++;
}

function cutscene_instance_destroy(_inst) {
	with (_inst) instance_destroy();
	current_scene++;
}

function cutscene_instance_buttonPress(_inst) {
	with (_inst) doSomething();
	current_scene++;
}

function cutscene_wait_instance_exists(_inst) {
	if (!instance_exists(_inst)) current_scene++;
}

function cutscene_solid_move_start(_inst) {
	with (_inst) {
		active = true;
		timer = timerMax;
	}
	current_scene++;
}
#endregion

#region Camera-related
function cutscene_camera_change_state(_state) {
	with (o_cam) state = _state;
	current_scene++;
}

function cutscene_camera_change_target(_target) {
	with (o_cam) target = _target;
	current_scene++;
}

function cutscene_camera_change_toPos(_xTo,_yTo) {
	with (o_cam) {
		xTo = _xTo;
		yTo = _yTo;
	}
	current_scene++;
}
	
function cutscene_camera_change_limits(_xMin,_yMin,_xMax,_yMax) {
	with (o_cam) {
		if (_xMin >= 0) xMin = _xMin;
		if (_yMin >= 0) yMin = _yMin;
		if (_xMax <= room_width) xMax = _xMax;
		if (_yMax <= room_height) yMax = _yMax;
	}
	current_scene++;
}
#endregion

#region Player-related
function cutscene_player_stop() {
	with (o_player) {
		noControl = true;
		starting = false;
		goTo = false;
	}
	current_scene++;
}

function cutscene_player_resume() {
	with (o_player) {
		noControl = false;
		spriteChanged = false;
		goTo = false;
	}
	current_scene++;
}

function cutscene_player_change_sprite(_sprite) {
	with (o_player) {
		spriteChanged = true;
		sprite_index = _sprite;
	}
	current_scene++;
}

function cutscene_player_reset_sprite() {
	with (o_player) {
		spriteChanged = false;
	}
	current_scene++;
}

function cutscene_player_goto(_xTo,_yTo,_relative) {
	if (!scene_started) {
		with (o_player) {
			xTo = _xTo+(_relative*x);
			yTo = _yTo+(_relative*y);
			goTo = true;
		}
		scene_started = true;
	}
	var _dist = o_player.xTo-o_player.x;
	if (abs(_dist) <= 8) {
		scene_started = false;
		current_scene++;
		with (o_player) goTo = false;
	}
}
	
function cutscene_player_change_position(_x,_y) {
	with (o_player) {
		x = _x;
		y = _y;
		hsp = 0;
		vsp = 0;
	}
	current_scene++;
}
	
function cutscene_player_change_velocity(_hsp,_vsp) {
	with (o_player) {
		hsp = _hsp;
		vsp = _vsp;
	}
	current_scene++;
}
#endregion