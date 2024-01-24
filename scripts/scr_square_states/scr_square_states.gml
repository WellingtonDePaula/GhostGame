function scr_square_choose_state() {
	debug_state = "Choose State";
	
	prox_state = choose(scr_square_state_idle, scr_square_state_moving);
	
	if(prox_state == scr_square_state_idle) {
		state = prox_state;
	}
	if(prox_state == scr_square_state_moving) {
		dest_x = irandom_range(0, room_width);
		dest_y = irandom_range(0, room_height);
		state = prox_state;
	}
}

function scr_square_state_idle() {
	debug_state = "Idle";
	
	velh = 0;
	velv = 0;
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist <= chase_dist) {
		state = scr_square_state_chasing;
	}
}

function scr_square_state_moving() {
	debug_state = "Moving";
	
	vel = .5;
	
	var dir = point_direction(x, y, dest_x, dest_y);
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist <= chase_dist) {
		state = scr_square_state_chasing;
	}
}

function scr_square_state_chasing() {
	debug_state = "Chasing";
	
	vel = .9;
	
	var dir = point_direction(x, y, obj_player.x, obj_player.y);
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist >= release_dist) {
		state = scr_square_choose_state;
	}
}