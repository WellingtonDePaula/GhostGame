resolution_width = window_get_width();
resolution_height = window_get_height();

global.view_width = resolution_width/resolution_scale;
global.view_height = resolution_height/resolution_scale;

camera_set_view_size(view_camera[0], global.view_width, global.view_height);

view_target = global.controlled_object;

if(instance_exists(view_target)) {
	cam_x = lerp(cam_x, view_target.x - global.view_width/2, .1);
	cam_y = lerp(cam_y, view_target.y - global.view_height/2, .1);
	
	cam_x = clamp(cam_x, 0, room_width - global.view_width);
	cam_y = clamp(cam_y, 0, room_height - global.view_height);
	
	camera_set_view_pos(view_camera[0], cam_x, cam_y);
}