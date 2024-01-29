global.font1 = font_add_sprite_ext(spr_font1, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890?!.,:;~()'/%-+=<>@_", true, 2);
global.pause = false;
can_pause = true;

layer_enable_fx("Pause_Background", false);
layer_depth(layer_get_id("Pause_Background"), -room_height-10);