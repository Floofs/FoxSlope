x_sub = 0;
y_sub = 0;

hsp = 0;
vsp = 0;

path_ended = false;
spd = 0;

acc = 0.15;
dec = 0.2;
run = 4;

jmp = 5.75;
grv = 0.25;
lmt = 10;

state = PLAYER.FREE;
dir = 1;

controlLockMax = 15;
controlLock = 0;

grounded = false;
jumping = false;
rolling = false;
skidding = false;
slipping = false;

jumpsMax = 1;
jumps = jumpsMax;

layer_solid = layer_get_id("Solid");
layer_jumpthru = layer_get_id("Jumpthru");

current_frame = 0;
angle = 0;
angle_tail = 0;

anim_idle = s_fox_idle;
anim_jog = s_fox_jog;
anim_run = s_fox_run;
anim_skid = s_fox_skid;
anim_rise = s_fox_rise;
anim_fall = s_fox_fall;

anim_roll = s_fox_roll;

function set_main_mask() {
	/*
	if (rolling) || (jumping) mask_index = m_player_roll;
	else if (grounded) mask_index = m_player;
	*/
	
	mask_index = m_player;
}

function set_tile_mask() {
	/*
	if (rolling) || (jumping) mask_index = m_player_roll_slope;
	else if (grounded) mask_index = m_player_slope;
	*/
	
	mask_index = m_player_slope;
}

function store_subpixels() {
	x_sub += hsp;
	y_sub += vsp;
	hsp = x_sub div 1;
	vsp = y_sub div 1;
	x_sub -= hsp;
	y_sub -= vsp;
}

function tile_collision() {
	store_subpixels();
	set_tile_mask();
	var _lastGrounded = grounded;
	grounded = tile_meeting_precise(x,bbox_bottom+2,layer_solid)
	|| (tile_meeting_precise(x,bbox_bottom+2,layer_jumpthru) && !tile_meeting_precise(x,bbox_bottom+1,layer_jumpthru) && vsp >= 0);
	
	if (grounded) {
		angle = get_tile_floor_slope(x,bbox_bottom,layer_solid);
		if (angle == 0) {
			angle = get_tile_floor_slope(bbox_right,bbox_bottom-4,layer_solid);
			if (angle == 0) angle = get_tile_floor_slope(bbox_left,bbox_bottom-4,layer_solid);
		}
		
		for (var i = 0; i < abs(hsp)*2; i++) {
			//Up Slopes
			if (tile_meeting_precise(x+hsp,y,layer_solid) && !tile_meeting_precise(x+hsp,y-(i*2),layer_solid)) {
				while (tile_meeting_precise(x+hsp,y,layer_solid)) y--;
			}
			//Down Slopes
			if (!tile_meeting_precise(x+hsp,y+1,layer_solid) && tile_meeting_precise(x+hsp,y+(i*2)+1,layer_solid)) {
				while (!tile_meeting_precise(x+hsp,y+1,layer_solid)) y++;
			}
		}
		
		//This statement should let us fly up walls
		var _checkLeft = tile_meeting(bbox_left+hsp,bbox_top,layer_solid);
		var _checkRight = tile_meeting(bbox_right+hsp,bbox_top,layer_solid);
		
		if (grounded) && (abs(hsp+x_sub) >= 2.5) && (abs(angle) > 45) && (sign(hsp) == sign(angle))
		&& (_checkLeft == 1 || _checkRight == 1) {
			vsp = -abs(hsp);
			y_sub = -abs(x_sub);
			//hsp = 0;
			//x_sub = 0;
			grounded = false;
			jumping = true;
			rolling = false;
			controlLock = 0;
			show_debug_message("trying to fling up the wall "+string(current_time));
		}
	}
	else angle = 0;
	
	//Horizontal Collision
	if (tile_meeting_precise(x+hsp,y,layer_solid)) {
		while (!tile_meeting_precise(x+sign(hsp),y,layer_solid)) {
			x += sign(hsp);
		}
		hsp = 0;
		x_sub = 0;
	}
	x += hsp;
	
	//Vertical Collision
	var _lastvsp = 0;
	if (tile_meeting_precise(x,y+vsp,layer_solid))
	|| (tile_meeting_precise(x,y+vsp,layer_jumpthru) && !tile_meeting_precise(x,y,layer_jumpthru) && vsp >= 0) {
		while (!tile_meeting_precise(x,y+sign(vsp),layer_solid)
		&& !tile_meeting_precise(x,y+sign(vsp),layer_jumpthru)) {
			y += sign(vsp);	
		}
		_lastvsp = abs(vsp)+abs(y_sub);
		vsp = 0;
		y_sub = 0;
	}
	y += vsp;
	
	set_main_mask();
	
	grounded = tile_meeting_precise(x,y+1,layer_solid)
	|| (tile_meeting_precise(x,y+1,layer_jumpthru) && !tile_meeting_precise(x,y,layer_jumpthru) && vsp >= 0);
	//Make the player slip when they land on slopes
	if (grounded) && (!_lastGrounded) {
		angle = get_tile_floor_slope(x,bbox_bottom,layer_solid);
		if (angle == 0) {
			angle = get_tile_floor_slope(bbox_right,bbox_bottom-4,layer_solid);
			if (angle == 0) angle = get_tile_floor_slope(bbox_left,bbox_bottom-4,layer_solid);
		}
		
		if (_lastvsp < 1) _lastvsp = abs(y-yprevious);
		
		if (angle != 0) hsp += _lastvsp * -sin(degtorad(angle));	
	}
}

enum PLAYER {
	FREE,
	PATH
}