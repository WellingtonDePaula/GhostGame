event_inherited();

state = scr_player_ghost_state_free;

depth = -100

vel = 2;

right = 0;
left = 0;
down = 0;
up = 0;
space = 0;

inputs = {
	right: ord("D"),
	left: ord("A"),
	down: ord("S"),
	up: ord("W"),
	space: vk_space,
}

body = obj_player;
max_dist = 400;
image_dir = 0;
image_rotate_tol = 1;
image_rotate_frac = .27

image_alpha = .7;

global.controlled_object = obj_player_ghost;