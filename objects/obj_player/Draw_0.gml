draw_self();
draw_text(20, 20, debug_state);
with(obj_player_ghost) {
	draw_circle(other.x, other.y, max_dist, true);
}