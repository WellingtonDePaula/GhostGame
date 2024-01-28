depth = -y;
var col = instance_place(x, y, obj_enemy);

if(col && col.dead) {
	speed = 0;
	col.hit = true;
	col.alarm[1] = col.hit_delay;
	col.alpha = 1;
	col.velh = lengthdir_x(len, direction);
	col.velv = lengthdir_y(len, direction);
	col.alarm[2] = kb_dis;
	instance_destroy();
}
if(!global.pause) {
	if(instance_place(x, y, [obj_wall, obj_border_limit])) {
		speed = 0;
		instance_destroy();
	}
	else
	{
		sprite_index = proj_sprite;
		image_angle -= rotate_force;
		speed = set_speed;
	}
} else {
	speed = 0;
	global.can_shoot = true;
}