if(!global.pause) {
	draw_set_color(c_white);
	draw_set_font(global.font1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_sprite_ext(spr_ammo, 0, 40, display_get_gui_height() - 20, 7, 7, 0, c_white, 1);
	draw_set_halign(-1);
	draw_set_valign(-1);
	draw_text_ext_transformed(105, display_get_gui_height() - 25, my_weapon.ammo, 0, 100, 7, 7, 0);
	draw_set_font(-1);
	draw_set_color(-1);
}