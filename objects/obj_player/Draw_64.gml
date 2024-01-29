y_bala = display_get_gui_height() - 20;
y_contagem_balas =  display_get_gui_height() - 25;
if(global.pause) {
	x_bala = lerp(x_bala, -200, .1);
	x_contagem_balas = lerp(x_bala, -105, .1);
} else {
	x_bala = lerp(x_bala, 40, .1);
	x_contagem_balas = lerp(x_bala, 105, .1);
}
draw_set_color(c_white);
draw_set_font(global.font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite_ext(spr_ammo, 0, x_bala, y_bala, 7, 7, 0, c_white, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text_ext_transformed(x_contagem_balas+35, y_contagem_balas, my_weapon.ammo, 0, 100, 7, 7, 0);
draw_set_halign(-1);
draw_set_valign(-1);
draw_set_font(-1);
draw_set_color(-1);