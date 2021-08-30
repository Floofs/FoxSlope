draw_set_font(fnt_main);
application_surface_draw_enable(false);

randomize();

scale = 3;

global.p_x = -1;
global.p_y = -1;

global.max_hp = 20;

resize_window(scale);
room_goto_next();