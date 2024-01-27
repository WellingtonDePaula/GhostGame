event_inherited();

with(collision_mask) {
	var col = instance_place(x, y, obj_proj);
	if(col) {
		if(!other.hit) {
			other.color = c_red;
			other.hit = true;
			other.alarm[1] = other.hit_delay;
			other.hp -= col.damage;
		}
		instance_destroy(col);
	}
}