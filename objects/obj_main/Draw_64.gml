if(global.pause) {
	if(options_state == "pause") {
		draw_set_font(global.font1);
		var dist = 80;
		var gui_width = display_get_gui_width();
		var gui_height = display_get_gui_height();
		var x1 = gui_width/2;
		var y1 = gui_height/2-40;
		for(var i = 0; i < pause_op_max; i++) {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			if(pause_index == i) {
				draw_set_color(c_yellow);
			} else {
				draw_set_color(c_white);
			}
			draw_text_transformed(x1, y1 + (dist*i), pause_options[i], 8, 8, 0)
		}
		draw_set_halign(-1);
		draw_set_valign(-1);
		draw_set_font(-1);
	}
	if(options_state == "options") {
		draw_set_font(global.font1);
		var dist = 80;
		var gui_width = display_get_gui_width();
		var gui_height = display_get_gui_height();
		var x1 = gui_width/2;
		var y1 = gui_height/2-40;
		for(var i = 0; i < op_max; i++) {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			if(op_index == i) {
				draw_set_color(c_yellow);
			} else {
				draw_set_color(c_white);
			}
			draw_text_transformed(x1, y1 + (dist*i), op_options[i], 8, 8, 0)
		}
		draw_set_halign(-1);
		draw_set_valign(-1);
		draw_set_font(-1);
	}
}