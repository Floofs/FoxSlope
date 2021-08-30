if (window_get_fullscreen()) draw_surface_stretched(application_surface,0,0,display_get_width(),display_get_height());
else draw_surface_ext(application_surface,0,0,scale,scale,0,c_white,1);