event_inherited();

state = scr_yuzan_choose_state;
prox_state = -1;

vel = 1;
dest_x = 0;
dest_y = 0;

chase_dist = 80;
release_dist = 100;

alarm[0] = 1;

collision_mask = instance_create_layer(x, y, "Enemies", obj_enemy_yuzan_collision_mask);
collision_mask.body_id = self;

hit_delay = 7;

len = 0;