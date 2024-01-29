function scr_player_state_free() {
	debug_state = "Free";
	
	vel = 1.5;
	
	scr_player_fix_sprites();
	
	right = keyboard_check(inputs.right);
	left = keyboard_check(inputs.left);
	down = keyboard_check(inputs.down);
	up = keyboard_check(inputs.up);
	space = keyboard_check_pressed(inputs.space);
	left_mouse = mouse_check_button_pressed(inputs.left_mouse);
	shift = keyboard_check_pressed(inputs.shift);
	
	move_dir = point_direction(0, 0, right-left, down-up);
	var keys = right-left != 0 || down - up != 0;
	
	velh = lengthdir_x(vel * keys, move_dir);
	velv = lengthdir_y(vel * keys, move_dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	
	
	//carrega corpo
	var inst = instance_nearest(x, y, obj_enemy);
	if(inst != noone) {
		if(inst.dead) {
			if(rectangle_in_circle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, x, y, d_range)) {
				if(keyboard_check_pressed(inputs.e)) {
					state = scr_player_state_carrying;
				}
			}
		}
	}
	
	if(shift && can_dash) {
		can_dash = false;
		alarm[0] = dash_delay;
		velh = 0;
		velv = 0;
		scr_player_dash_dir();
		state = scr_player_state_dash;
	}
	
	if(space) {
		velh = 0;
		velv = 0;
		image_index = 0;
		state = scr_player_state_dead;
		inst = instance_create_layer(x + 3 * image_xscale, y - 7, "Player_Ghost", obj_player_ghost); 
	}
	if(my_weapon != -1) {
		with(my_weapon) {
			weapon_dir = point_direction(x, y, mouse_x, mouse_y);
			if(other.left_mouse) {
				fire();
			}
		}
	}
}

function scr_player_state_dead() {
	debug_state = "Dead";
	
	sprite_index = spr_player_dead;
	
	if(image_index >= sprite_get_number(sprite_index)-1) {
		image_index = sprite_get_number(sprite_index)-1;
	}
	
	vel = 0;
}

function scr_player_state_dead_return() {
	debug_state = "Dead Return";
	
	sprite_index = spr_player_dead_return;
	
	if(image_index >= sprite_get_number(sprite_index)-1) {
		state = scr_player_state_free;
	}
}

function scr_player_state_dash() {
	debug_state = "Dash";
	
	with(my_weapon) {
		weapon_dir = point_direction(x, y, mouse_x, mouse_y);
	}
	
	dash_time++;
	if(dash_time >= dash_distance)
	{
		dash_time = 0;
		velh = 0;
		velv = 0;
		state = scr_player_state_free;
	}
	
	velh = lengthdir_x(dash_force, dash_dir);
	velv = lengthdir_y(dash_force, dash_dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
}

function scr_player_state_carrying() {
	debug_state = "Carrying";
	
	vel = 1;
	
	var inst = instance_nearest(x, y, obj_enemy);
	
	var mouse_dir = point_direction(x, y, mouse_x, mouse_y);

	inst.x = lerp(inst.x, x + lengthdir_x(8, mouse_dir), .3);
	inst.y = lerp(inst.y, y + lengthdir_y(8, mouse_dir), .3);
	
	inst.image_xscale = image_xscale;
	
	scr_player_fix_sprites();
	
	right = keyboard_check(inputs.right);
	left = keyboard_check(inputs.left);
	down = keyboard_check(inputs.down);
	up = keyboard_check(inputs.up);
	space = keyboard_check_pressed(inputs.space);
	left_mouse = mouse_check_button_pressed(inputs.left_mouse);
	shift = keyboard_check_pressed(inputs.shift);
	
	move_dir = point_direction(0, 0, right-left, down-up);
	var keys = right-left != 0 || down - up != 0;

	//if(inst != noone) {
	//	if(inst.dead) {
	//		if(!rectangle_in_circle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, x, y, d_range)) {
	//			show_debug_message(is_carrying);
	//			is_carrying = false;
	//			state = scr_player_state_free;
	//			inst.velh = 0;
	//			inst.velv = 0;
	//		}
	//	}
	//}
	var col = instance_place(inst.x, inst.y, obj_collider);
	if(!col) {
		if(keyboard_check_pressed(inputs.e)) {
			state = scr_player_state_free;
			inst.velh = 0;
			inst.velv = 0;
		}
	}
	
	velh = lengthdir_x(vel * keys, move_dir);
	velv = lengthdir_y(vel * keys, move_dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
}