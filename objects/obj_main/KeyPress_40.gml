if(global.pause) {
	if(options_state == "pause") {
		pause_index++;
		if(pause_index > pause_op_max-1) {
			pause_index = 0;
		}
	}
	if(options_state == "options") {
		op_index++;
		if(op_index > op_max-1) {
			op_index = 1;
		}
	}
}