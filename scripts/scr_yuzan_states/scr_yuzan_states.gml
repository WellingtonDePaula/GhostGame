function scr_yuzan_choose_state() {
	debug_state = "Choose State";
	
	prox_state = choose(scr_yuzan_state_idle, scr_yuzan_state_moving);
	
	if(prox_state == scr_yuzan_state_idle) {
		state = prox_state;
	}
	if(prox_state == scr_yuzan_state_moving) {
		dest_x = irandom_range(0, room_width);
		dest_y = irandom_range(0, room_height);
		state = prox_state;
	}
}

function scr_yuzan_state_idle() {
	debug_state = "Idle";
	
	scr_enemy_fix_sprites(spr_yuzan_idle_front, spr_yuzan_idle_back, spr_yuzan_moving_front, spr_yuzan_moving_back);
	
	velh = 0;
	velv = 0;
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist <= chase_dist) {
		state = scr_yuzan_state_chasing;
	}
}

function scr_yuzan_state_moving() {
	debug_state = "Moving";
	
	scr_enemy_fix_sprites(spr_yuzan_idle_front, spr_yuzan_idle_back, spr_yuzan_moving_front, spr_yuzan_moving_back);
	
	vel = .5;
	
	var dir = point_direction(x, y, dest_x, dest_y);
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if(!hit) {
		move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	}
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist <= chase_dist) {
		state = scr_yuzan_state_chasing;
	}
}

function scr_yuzan_state_chasing() {
	debug_state = "Chasing";
	
	scr_enemy_fix_sprites(spr_yuzan_idle_front, spr_yuzan_idle_back, spr_yuzan_moving_front, spr_yuzan_moving_back);
	
	vel = .8;
	
	var dir = point_direction(x, y, obj_player.x, obj_player.y);
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if(!hit) {
		move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
	}
	
	var dist = point_distance(x, y, obj_player.x, obj_player.y);
	
	if(dist >= release_dist) {
		state = scr_yuzan_choose_state;
	}
}

function scr_yuzan_state_dead() {
	debug_state = "Dead";
	
	mask_index = spr_yuzan_dead;
	
	dead = true;
	
	sprite_index = spr_yuzan_dead;
	
	if(image_index >= sprite_get_number(sprite_index)-1) {
		image_index = sprite_get_number(sprite_index)-1;
	}
	
	//var col = instance_place(x, y, obj_player);
	
	//with(col) {
	//	var push_list = ds_list_create();
	//	var is_block_h = instance_place_list(x+velh, y, other, push_list, false);
			
	//	if(is_block_h) {
	//		if(is_block_h) {
	//			if(ds_list_size(push_list) > 0) {
	//				for(var i = 0; i < ds_list_size(push_list); i++) {
	//					var block = push_list[| i];
	//					with(block) {
	//						if(!place_meeting(x+other.velh, y, [obj_wall, obj_border_limit])) {
	//							x+=other.velh;
	//						}
	//					}
	//				}
	//			}
	//		}
	//	}
	//}
	move_and_collide(velh, velv, [obj_wall, obj_border_limit]);
}