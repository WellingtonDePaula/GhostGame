function scr_player_ghost_state_free() {
	debug_state = "Free";
	
	vel = 2;
	
	right = keyboard_check(inputs.right);
	left = keyboard_check(inputs.left);
	down = keyboard_check(inputs.down);
	up = keyboard_check(inputs.up);
	space = keyboard_check_pressed(inputs.space);
	
	var dir, keys;
	
	dir = point_direction(0, 0, right-left, down-up);
	keys = right-left != 0 || down - up != 0;
	
	velh = lerp(velh, lengthdir_x(vel * keys, dir), .14);
	velv = lerp(velv, lengthdir_y(vel * keys, dir), .14);
	
	if(velh == 0 && velv == 0 || !keys) {
		sprite_index = spr_player_ghost_idle;
	}
	
	if(keys) {
		var ad = angle_difference(dir, image_dir);
		
		if(abs(ad) <= image_rotate_tol) {
		    image_dir = dir;
		} else {
		    image_dir += ad*image_rotate_frac;
		}
	}
	
	if(velh != 0 || velv != 0 && keys) {
		sprite_index = spr_player_ghost_moving;
		
		if(image_index >= sprite_get_number(sprite_index)-1) {
			image_index = sprite_get_number(sprite_index)-1;
		}
		
	}
	
	if(point_distance(x + velh, y + velv, body.x, body.y) >= max_dist) {
		velh = 0;
		velv = 0;
	}
	
	//Fazendo com que o player não fique dentro das paredes
	if(place_meeting(x, y, [obj_wall, obj_border_limit])) {
		for(var i = 0; i < 1000; i++) {
			//direita
			if(!place_meeting(x + i, y, obj_border_limit)) {
				x+=i;
				break;
			}
			//esquerda
			if(!place_meeting(x - i, y, obj_border_limit)) {
				x-=i;
				break;
			}
			//cima
			if(!place_meeting(x, y - i, obj_border_limit)) {
				y-=i;
				break;
			}
			//baixo
			if(!place_meeting(x, y + i, obj_border_limit)) {
				y+=i;
				break;
			}
			
			////////////////////////////////////
			
			//cima direita
			if(!place_meeting(x + i, y - i, obj_border_limit)) {
				x+=i;
				y-=i;
				break;
			}
			//cima esquerda
			if(!place_meeting(x - i, y - i, obj_border_limit)) {
				x-=i;
				y-=i;
				break;
			}
			//baixo direita
			if(!place_meeting(x + i, y + i, obj_border_limit)) {
				x+=i;
				y+=i;
				break;
			}
			//baixo esquerda
			if(!place_meeting(x - i, y + i, obj_border_limit)) {
				x-=i;
				y+=i;
				break;
			}
		}
	}
	move_and_collide(velh, velv, obj_border_limit);
	
	if(space) {
		image_index = 0;
		state = scr_player_ghost_state_return;
		dir = point_direction(x, y, body.x, body.y);
		velh = 0;
		velv = 0;
		image_dir = dir;
	}
}

function scr_player_ghost_state_return() {
	debug_state = "Return";
	
	global.controlled_object = obj_player;
	
	vel = 10;
	
	var dir = point_direction(x, y, body.x, body.y);
	if(!rectangle_in_rectangle(body.bbox_left, body.bbox_top, body.bbox_right, body.bbox_bottom, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		image_dir = dir;
	}
		
	velh = lerp(velh, lengthdir_x(vel, dir), .05);
	velv = lerp(velv, lengthdir_y(vel, dir), .05);
	
	if(velh !=0 || velv != 0) {
		if(image_index >= sprite_get_number(sprite_index)-1) {
			image_index = sprite_get_number(sprite_index)-1;
		}
		sprite_index = spr_player_ghost_moving;
		
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
			//if(body.my_weapon != -1) {
			//	body.my_weapon.weapon_velh = 0;
			//	body.my_weapon.weapon_velv = 0;
			//}
			body.my_weapon.weapon_velh = 0;
			body.my_weapon.weapon_velv = 0;
			body.state = scr_player_state_dead_return;
			body.image_index = 0;
			instance_destroy();
		}
	}
}