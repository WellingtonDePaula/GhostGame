if(keyboard_check_pressed(vk_escape) && can_pause) {
	global.pause = !global.pause;
	layer_enable_fx("Pause_Background", !layer_fx_is_enabled("Pause_Background"));
	can_pause = false;
	alarm[0] = 25;
}

if(!global.pause) {
	with(obj_entity) {
		//sprite_set_speed(sprite_index, sprite_speed, sprite_get_speed_type(sprite_index));
	}
	if(keyboard_check_pressed(ord("R"))) {
		room_restart();
	}
} else {
	with(obj_entity) {
		sprite_set_speed(sprite_index, 0, sprite_get_speed_type(sprite_index));
	}
}