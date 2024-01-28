global.font1 = font_add_sprite_ext(spr_font1, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890?!.,:;~()'/%-+=<>@_", true, 2);
global.pause = false;
can_pause = true;

//menu de pause
options_state = "";
pause_options = ["Return", "Options", "Quit"];
pause_op_max = array_length(pause_options);
pause_index = 0;

//menu de opções
op_options = ["Resolution:", "1280x720", "1920x1080", "2560x1440"];
op_max = array_length(op_options);
op_index = 1;