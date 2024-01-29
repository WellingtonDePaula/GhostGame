if(!global.pause) {
	if(state != scr_yuzan_state_dead && state != scr_yuzan_state_chasing) {
		state = scr_yuzan_choose_state;
	}
	alarm[0] = irandom_range(100, 200);
}