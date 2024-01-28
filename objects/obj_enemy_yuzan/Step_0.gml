if(!global.pause) {
	script_execute(state);
	if(hp <= 0 && hit && !dead) {
		image_index = 0;
		velh = 0;
		velv = 0;
		state = scr_yuzan_state_dead;
	}
}