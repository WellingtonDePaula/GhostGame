if(!global.pause) {
	if(instance_exists(body_id)) {
		x = body_id.x;
		y = body_id.y;
		if(body_id.dead) {
			instance_destroy();
		}
	} else {
		instance_destroy();
	}
}