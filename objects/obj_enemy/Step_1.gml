if(!global.pause) {
	event_inherited();
	alpha = lerp(alpha, 0, .1);
	with(collision_mask) {
		var col = instance_place(x, y, obj_proj);
		if(col) {
			if(!other.hit) {
				if(!other.dead) {
					audio_play_sound(s_hit, 1, false);
					other.hp -= col.damage;
					other.hit = true;
					other.alpha = 1;
					other.alarm[1] = other.hit_delay;
				}
			}
			instance_destroy(col);
		}
	}
}