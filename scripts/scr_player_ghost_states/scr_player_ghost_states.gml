function scr_player_ghost_state_free() {
	debug_state = "Free";
	
	vel = 2;
	
	if(velh == 0 && velv == 0) {
		sprite_index = spr_player_ghost_idle;
	}
	if(velh !=0 || velv != 0) {
		
		if(image_index >= sprite_get_number(sprite_index)-1) {
			image_index = sprite_get_number(sprite_index)-1;
		}
		
		sprite_index = spr_player_ghost_moving;
		
		var dir = point_direction(0, 0, right-left, down-up);
		var ad = angle_difference(dir, image_dir);
		
		if(abs(ad) <= image_rotate_tol) {
		    image_dir = dir;
		} else {
		    image_dir += ad*image_rotate_frac;
		}
		
	}
	
	right = keyboard_check(inputs.right);
	left = keyboard_check(inputs.left);
	down = keyboard_check(inputs.down);
	up = keyboard_check(inputs.up);
	space = keyboard_check_pressed(inputs.space);
	
	var move_dir, keys;
	
	move_dir = point_direction(0, 0, right-left, down-up);
	keys = right-left != 0 || down - up != 0;
	
	velh = lengthdir_x(vel * keys, move_dir);
	velv = lengthdir_y(vel * keys, move_dir);
	
	if(point_distance(x + velh, y + velv, body.x, body.y) >= max_dist) {
		velh = 0;
		velv = 0;
	}
	
	move_and_collide(velh, velv, obj_border_limit);
	
	if(space) {
		image_index = 0;
		state = scr_player_ghost_state_return;
		velh = 0;
		velv = 0;
	}
}

function scr_player_ghost_state_return() {
	debug_state = "Return";
	
	vel = 10;
	
	var dir = point_direction(x, y, body.x, body.y);
		
	velh = lerp(velh, lengthdir_x(vel, dir), .05);
	velv = lerp(velv, lengthdir_y(vel, dir), .05);
	
	if(velh !=0 || velv != 0) {
		if(image_index >= sprite_get_number(sprite_index)-1) {
			image_index = sprite_get_number(sprite_index)-1;
		}
		
		sprite_index = spr_player_ghost_moving;
		
		dir = point_direction(x, y, body.x, body.y);
		
		image_dir = dir;
		
		if(velh > 0) {
			image_xscale = 1;
		} else {
			image_xscale = -1;
		}
	}
	
	if(rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, body.bbox_left, body.bbox_top, body.bbox_right, body.bbox_bottom)) {
		velh = 0;
		velv = 0;
	}
	
	move_and_collide(velh, velv, obj_border_limit);
	
	if(rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, body.bbox_left, body.bbox_top, body.bbox_right, body.bbox_bottom)) {
		image_alpha -= .1;
		if(image_alpha <= 0)
		{
			body.my_weapon.weapon_velh = 0;
			body.my_weapon.weapon_velv = 0;
			body.state = scr_player_state_dead_return;
			body.image_index = 0;
			instance_destroy();
		}
	}
}