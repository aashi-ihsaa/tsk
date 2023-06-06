/// @description  Draw stuff in the room if playing with people
depth = -y



switch MultiplayerMode { // 0 Singleplayer | 1 Host | 2 Client
	case 1:
		if object_exists(obj_Player) {
			with obj_Player {
				if Targeted = true {
					outline_draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha,ol_config(1,c_yellow,0.4,1))
				} else {
					draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
				}
			}
		}
		break;
	case 2:
		// Now loop through all active sprites and draw them
		var DrawIndex = 0;
		for(var i = 0; i < DrawObjCount; ++i;) {
			var sprind = ds_list_find_value(AllSprites, DrawIndex++);
			var imind = ds_list_find_value(AllSprites, DrawIndex++);
			var xx = ds_list_find_value(AllSprites, DrawIndex++);
			var yy = ds_list_find_value(AllSprites, DrawIndex++);
			var imxsc = ds_list_find_value(AllSprites, DrawIndex++);
			var imysc = ds_list_find_value(AllSprites, DrawIndex++);
			var ang = ds_list_find_value(AllSprites, DrawIndex++);
			var col = ds_list_find_value(AllSprites, DrawIndex++);
			var alph = ds_list_find_value(AllSprites, DrawIndex++);
			// Now draw dem bitches!
			draw_sprite_ext(sprind, imind, xx, yy, imxsc, imysc, ang, col, alph);
		}
		break;
}


// Debug Draws
if keyboard_check(vk_shift) { mp_grid_draw(global.UltraGrid)}
if keyboard_check(vk_control) {
	with obj_Character_Parent {
		draw_set_color(c_red);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	}
}