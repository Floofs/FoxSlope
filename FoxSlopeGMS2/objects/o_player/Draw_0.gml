if (sprite_index == anim_roll) {
	var _xx = x+(cos(degtorad(-angle_tail))*10);
	var _yy = y+(sin(degtorad(-angle_tail))*10)-10;
	
	draw_sprite_ext(s_fox_tail_air,-1,_xx,_yy,-1,dir,angle_tail,image_blend,image_alpha);
	
	draw_sprite_ext(sprite_index,current_frame,x,y,dir,1,0,image_blend,image_alpha);
}
else {
	var _xx = x+(cos(degtorad(-angle_tail))*4);
	var _yy = y+(sin(degtorad(-angle_tail))*4)-9;

	if (grounded) && (abs(hsp) < 1) && (!slipping) {
		_xx = x-(dir*4);
		_yy = y-9;
		draw_sprite_ext(s_fox_tail_main,-1,_xx,_yy,dir,1,0,image_blend,image_alpha);
	}
	else {
		draw_sprite_ext(s_fox_tail_air,-1,_xx,_yy,-1,dir,angle_tail,image_blend,image_alpha);
	}
	
	draw_sprite_ext(sprite_index,current_frame,x,y,dir,1,round(angle/45)*45,image_blend,image_alpha);
}