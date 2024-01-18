event_inherited();

state = scr_player_state_free;

depth = -10;

ghost = obj_player_ghost;

vel = 1.5;

right = 0;
left = 0;
down = 0;
up = 0;
space = 0;
left_mouse = 0;
shift = 0;

inputs = {
	right: ord("D"),
	left: ord("A"),
	down: ord("S"),
	up: ord("W"),
	space: vk_space,
	left_mouse: mb_left,
	shift: vk_shift,
}

//variáveis da arma do player

my_weapon = instance_create_layer(x, y, "Guns", obj_pistol);
my_weapon.weapon_id = self;
global.can_shoot = true;

//variáveis do dash do player
can_dash = true;
dash_delay = 60;
dash_dir = 0;
dash_force = 4;
dash_time = 0;
dash_distance = 8;