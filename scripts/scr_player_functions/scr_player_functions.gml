function scr_player_dash_dir() {
	var x_input = right - left;
	var y_input = down - up;
	if(x_input == 0 && y_input == 0)
	{
		dash_dir = point_direction(x, y, mouse_x, mouse_y);
	}
	if(x_input != 0 ||  y_input != 0) {
		dash_dir = point_direction(0, 0, right-left, down-up);
	}
	
}

function scr_player_fix_sprites() {
	
	var dir = point_direction(x, y, mouse_x, mouse_y);
	
	if(velh == 0 && velv == 0 )
	{
		if(dir >= 0 && dir < 180) {
			sprite_index = spr_player_idle_back;
		}
		if(dir <= 360 && dir > 180) {
			sprite_index = spr_player_idle_front;
		}
		
	}
	if(velh != 0 || velv != 0) {
		if(dir > 0 && dir < 180) {
			sprite_index = spr_player_moving_back;
		}
		if(dir < 360 && dir > 180) {
			sprite_index = spr_player_moving_front;
		}
	}
	
	if(dir > 90 && dir < 270) {
		image_xscale = -1;
	} else {
		image_xscale = 1;
	}
}