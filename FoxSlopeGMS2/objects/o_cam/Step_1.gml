/*
var _kPause = keyboard_check_pressed(vk_enter);

if (_kPause) && (!instance_exists(o_pause)) {
	instance_create_layer(0,0,"Important",o_pause);
	
	instance_deactivate_layer(layer_get_id("Actors"));
	instance_deactivate_layer(layer_get_id("Triggers"));
	instance_deactivate_layer(layer_get_id("Gimmicks"));
}

if (instance_exists(o_pause)) exit;
*/

//Limit solid object count to what's on-screen
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);
var _padding = 16;

instance_deactivate_layer(layer_get_id("Actors"));
instance_activate_object(o_player);
//instance_activate_object(p_player_atk);
instance_activate_region(_cx-_padding,_cy-_padding,_cx+width+(_padding*2),_cy+height+(_padding*2),true);