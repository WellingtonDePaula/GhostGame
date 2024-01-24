if(instance_place(x, y, [obj_wall, obj_border_limit])) {
	instance_destroy();
}
else
{
	sprite_index = proj_sprite;
	image_angle -= rotate_force;
}