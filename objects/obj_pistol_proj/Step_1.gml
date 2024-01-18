if(instance_place(x, y, [obj_wall, obj_border_limit])) {
	instance_destroy();
}
else
{
	sprite_index = spr_pistol_proj;
	image_angle -= rotate_force;
}