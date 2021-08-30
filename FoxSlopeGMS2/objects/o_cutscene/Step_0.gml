if (!started) exit;
if (current_scene >= array_length(scene_info)) { instance_destroy(); exit; }

var _scene = scene_info[current_scene];
script_execute_ext(_scene[0],_scene,1);