camera = view_camera[0];

target = o_player;
xTo = 0;
yTo = 0;
xMin = 0;
yMin = 0;
xMax = room_width-round(TILE_SIZE*3.25);
yMax = room_height;

zoomTo = 1;
zoom = 1;

width = G_WIDTH;
height = G_HEIGHT;

state = CAMERA_STATES.follow;
active = true;

loaded = false;
shaky = false;

alarm[0] = 1;

layer_bg1 = layer_get_id("BG1");
layer_bg2 = layer_get_id("BG2");
layer_bg3 = layer_get_id("BG3");

enum CAMERA_STATES {
	tiled, //acts like follow, but tiles like MegaMan
	tiled_v, //tiled, but follows horizontally
	follow,
	point,
	zoom //acts like point, but should be used after
}