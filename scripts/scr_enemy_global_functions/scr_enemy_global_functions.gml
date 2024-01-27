function scr_enemy_fix_sprites(spr_idle_front, spr_idle_back, spr_moving_front, spr_moving_back) {
	if(velh != 0) {
		image_xscale = sign(velh);
	} else {
		if(sprite_index == spr_moving_front) {
			sprite_index = spr_idle_front;
		}
		if(sprite_index == spr_moving_back) {
			sprite_index = spr_idle_back;
		}
	}
	
	if(velv != 0) {
		if(velv > 0) {
			sprite_index = spr_moving_front;
		}
		if(velv < 0) {
			sprite_index = spr_moving_back
		}
	}
}