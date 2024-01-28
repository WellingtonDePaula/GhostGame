draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_set_color(c_white);
draw_set_font(global.font1);
draw_text(20, 60, debug_state);
draw_set_font(-1);
draw_set_color(-1);

//efeito de hit flash
if(hit) {
	if(alpha > 0) {
		gpu_set_fog(true, color_flash, 0, 0);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, alpha);
		gpu_set_fog(false, color_flash, 0, 0);
	}
}