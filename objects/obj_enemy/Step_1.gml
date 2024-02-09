if(!global.pause) {
	event_inherited();
	alpha = lerp(alpha, 0, .1);
	with(collision_mask) {
		var col = instance_place(x, y, obj_proj);
		if(col) {
			if(!other.hit) {
				if(!other.dead) {
					audio_play_sound(s_hit, 1, false, 1, 0, random_range(0.8, 1.2));
					other.hp -= col.damage;
					other.hit = true;
					other.alpha = 1;
					other.alarm[1] = other.hit_delay;
				}
			}
			instance_destroy(col);
		}
		
		with(obj_player.my_weapon) {
			col = instance_place(weapon_x, weapon_y, other);
			
			if(weapon_id.attacking) {
				if(col) {
					with(obj_enemy) {
						if(!hit) {
							if(!dead) {
								audio_play_sound(s_hit, 1, false, 1, 0, random_range(0.8, 1.2));
								hp -= 1;
								hit = true;
								alpha = 1;
								alarm[1] = hit_delay;
							}
						}
					}
				}
			}
		}
	}
}