if(global.pause) {
	gpu_set_fog(true, c_black, 0, 0);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	gpu_set_fog(false, c_black, 0, 0);
	draw_set_font(global.font1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_ext_transformed(display_get_gui_width()/2, display_get_gui_height()/2, "Game Paused", 0, 100, 8, 8, 0);
	draw_set_halign(-1);
	draw_set_valign(-1);
	draw_set_font(-1);
}