draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_dir, c_white, image_alpha);
draw_set_font(global.font1);
draw_set_color(c_white);
draw_line(x, y, body.x, body.y);
draw_text(20, 40, debug_state);
draw_set_font(-1);
draw_set_color(-1);