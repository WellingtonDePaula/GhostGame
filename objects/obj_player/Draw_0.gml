draw_self();
draw_set_color(c_white);
draw_set_font(global.font1);
draw_text(20, 20, debug_state);
with(obj_player_ghost) {
	draw_circle(other.x, other.y, max_dist, true);
}
draw_set_font(-1);
draw_set_color(-1);