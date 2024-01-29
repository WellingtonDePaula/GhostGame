if(!global.pause) {
	if(instance_exists(weapon_id)) {
		
		//depth = -y;
		
		if(weapon_dir > 0 && weapon_dir < 180) {
			depth += 2;
		}
		//if(weapon_dir > 180 && weapon_dir < 360) {
		//	depth -= 5;
		//}
	
		x = weapon_id.x;
		y = weapon_id.y + 2;
	
		var ad = angle_difference(weapon_dir, image_angle);
		if(global.can_shoot) {
			if(abs(ad) <= weapon_rotate_tol) {
				image_angle = weapon_dir;
			} else {
				image_angle += ad*weapon_rotate_frac;
			}
		} else {
			if(abs(ad) <= weapon_recoil_rotate_tol) {
				image_angle = weapon_dir;
			} else {
				image_angle += ad*weapon_recoil_rotate_frac;
			}
		}
	
		if(weapon_id.state != scr_player_state_dead_return) {
			weapon_x = x + lengthdir_x(6, weapon_dir);
			weapon_y = y + lengthdir_y(0, weapon_dir);
		}
	
		if(weapon_id.state == scr_player_state_dead) {
			var xx, yy, dir;
			xx = x + 5*sign(image_yscale);
			yy = y + 3;
			dir = point_direction(x, y, xx, yy);
			depth = min_depth;
			weapon_velh = lerp(weapon_velh, lengthdir_x(5, dir), .1);
			weapon_velv = lerp(weapon_velv, lengthdir_y(3, dir), .1);
			weapon_x+=weapon_velh;
			weapon_y+=weapon_velv;
		}
	
		if(weapon_id.state == scr_player_state_dead_return && weapon_id.image_index >= sprite_get_number(weapon_id.sprite_index)-2) {
			var xx, yy, dir;
			xx = x + lengthdir_x(6, weapon_dir);
			yy = y + lengthdir_y(0, weapon_dir);
			dir = point_direction(weapon_x, weapon_y, xx, yy);
			depth = min_depth;
			weapon_velh = lerp(weapon_velh, lengthdir_x(.7, dir), .1);
			weapon_velv = lerp(weapon_velv, lengthdir_y(.7, dir), .1);
			weapon_x+=weapon_velh;
			weapon_y+=weapon_velv;
		}
	
		if(weapon_id.state != scr_player_state_dead_return && weapon_id.state != scr_player_state_dead) {
			weapon_velh = 0;
			weapon_velv = 0;
		}

		image_yscale = weapon_id.image_xscale;
	
		function fire() {
			if(ammo > 0) {
				if(global.can_shoot) {
					image_angle += recoil_force*image_yscale;
			
					var bullet_x = (weapon_x + weapon_offset_x*dcos(weapon_dir) + weapon_offset_y*dsin(weapon_dir));
					var bullet_y = (weapon_y + weapon_offset_y*dcos(weapon_dir) - weapon_offset_x*dsin(weapon_dir));
		
					var burst = instance_create_layer((bullet_x + 5*dcos(weapon_dir) + weapon_offset_y*dsin(weapon_dir)) + 5* sign(weapon_id.velh), (bullet_y + weapon_offset_y*dcos(weapon_dir) - 5*dsin(weapon_dir)) + 5* sign(weapon_id.velv), "Projectiles", obj_pistol_burst);
					burst.image_angle = weapon_dir;
					burst.image_index = 0;
		
					var proj = instance_create_layer(bullet_x, bullet_y, "Projectiles", obj_pistol_proj);
					proj.gun_id = self;
					proj.set_speed = 4.5;
					proj.image_angle = weapon_dir;
					proj.direction = weapon_dir;
		
					alarm[0] = fire_cooldown;
		
					global.can_shoot = false;
			
					ammo--;
				}
			} else {
				if(global.can_shoot) {
					sprite_index = spr_pistol_no_ammo;
					alarm[1] = 5;
					alarm[0] = fire_cooldown;
					global.can_shoot = false;
				}
			}
		}
	} else {
		instance_destroy();
	}
}