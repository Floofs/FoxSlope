if (place_meeting(x,y,o_player)) {
	with (o_cam) {
		xMin = other.xMin;
		yMin = other.yMin;
		xMax = other.xMax;
		yMax = other.yMax;
		if (other.state != noone) state = other.state;
	}
}