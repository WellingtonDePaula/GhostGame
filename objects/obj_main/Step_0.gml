if(keyboard_check_pressed(vk_escape) && can_pause) {
	global.pause = !global.pause;
	can_pause = false;
	options_state = "pause";
	alarm[0] = 25;
}

if(!global.pause) {
	with(obj_entity) {
		sprite_set_speed(sprite_index, sprite_speed, sprite_get_speed_type(sprite_index));
	}
	if(keyboard_check_pressed(ord("R"))) {
		room_restart();
	}
} else {
	with(obj_entity) {
		sprite_set_speed(sprite_index, 0, sprite_get_speed_type(sprite_index));
	}
	
	//verifica o menu
	if(keyboard_check_pressed(vk_enter)) {
		if(options_state == "pause") {
			if(pause_index == 0) {
				global.pause = false;
			}
			if(pause_index == 1) {
				options_state = "options";
			}
			if(pause_index == 2) {
				game_end();
			}
		}
		if(options_state == "options") {
			if(op_index == 1) {
				global.resolution_width = 1280;
				global.resolution_height = 720;
				global.resolution_scale = 6;
				global.view_width = global.resolution_width/global.resolution_scale;
				global.view_height = global.resolution_height/global.resolution_scale;
				window_set_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				surface_resize(application_surface, global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				display_set_gui_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
			}
			if(op_index == 2) {
				global.resolution_width = 1920;
				global.resolution_height = 1080;
				global.resolution_scale = 6;
				global.view_width = global.resolution_width/global.resolution_scale;
				global.view_height = global.resolution_height/global.resolution_scale;
				window_set_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				surface_resize(application_surface, global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				display_set_gui_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
			}
			if(op_index == 3) {
				global.resolution_width = 2560;
				global.resolution_height = 1440;
				global.resolution_scale = 6;
				global.view_width = global.resolution_width/global.resolution_scale;
				global.view_height = global.resolution_height/global.resolution_scale;
				window_set_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				surface_resize(application_surface, global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
				display_set_gui_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
			}
		}
	}
}