global.resolution_width = 1280;
global.resolution_height = 720;
global.resolution_scale = 6;
global.view_width = global.resolution_width/global.resolution_scale;
global.view_height = global.resolution_height/global.resolution_scale;
view_target = global.controlled_object;
cam_x = 0;
cam_y = 0;
window_set_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
surface_resize(application_surface, global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);
display_set_gui_size(global.view_width*global.resolution_scale, global.view_height*global.resolution_scale);