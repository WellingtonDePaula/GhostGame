function scr_player_state_free() {
	debug_state = "Free";
	
	vel = 1;
	
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
			if(rectangle_in_circle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, x-1, y+5, d_range)) {
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
	if(my_weapon != noone) {
		with(my_weapon) {
			weapon_dir = point_direction(x, y, mouse_x, mouse_y);
			dir_x_y = point_direction(x, y, mouse_x, mouse_y);
			if(other.left_mouse) {
				fire();
			}
		}
	}
	
	//CORONHADAAAAA AA A AAA
	if(keyboard_check_pressed(inputs.f) && can_attack) {
		go_dir = my_weapon.weapon_dir+(stroke_intensity * image_xscale);
		can_attack = false;
		state = scr_player_state_attacking;
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
	
	vel = .5;
	
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

function scr_player_state_attacking() {
	debug_state = "Attacking";
	
	vel = 1;
	
	right = keyboard_check(inputs.right);
	left = keyboard_check(inputs.left);
	down = keyboard_check(inputs.down);
	up = keyboard_check(inputs.up);
	
	move_dir = point_direction(0, 0, right-left, down-up);
	var keys = right-left != 0 || down - up != 0;
	
	velh = lengthdir_x(vel * keys, move_dir);
	velv = lengthdir_y(vel * keys, move_dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	
	//toma-lhe coronhada
	with(my_weapon) {
		var col = instance_place(weapon_x, weapon_y, obj_enemy);
		
		if(col && col.dead) {
			if(!col.hit) {
				if(other.attacking) {
					audio_play_sound(s_hit, 1, false, 1, 0, random_range(0.8, 1.2));
					col.hit = true;
					col.alarm[1] = col.hit_delay;
					col.alpha = 1;
					col.velh = lengthdir_x(1, dir_x_y);
					col.velv = lengthdir_y(1, dir_x_y);
					col.alarm[2] = 5;
				}
			}
		}
		if(!other.attacking) {
			weapon_dir = lerp(weapon_dir, other.go_dir, .9);
			len_x = 8;
			len_y = 4;
			if(weapon_dir == other.go_dir) {
				other.attacking = true;
			}
		} else {
			len_x = 6;
			len_y = 0;
			other.attacking = false;
			other.alarm[1] = 25;
			other.state = scr_player_state_free;
		}
	}
}