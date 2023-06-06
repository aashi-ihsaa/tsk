/// PlayerInputIndexMK4(Controller Number)
function PlayerInputIndexMK5() {
	var im = "";
	if gamepad_is_connected(0) {
		gp_deadzone = 0.1
	    var gpb = [gp_stickl, gp_stickr, gp_face1, gp_face2, gp_face3, gp_face4, gp_padu, gp_padd, gp_padl, gp_padr, gp_shoulderl, gp_shoulderlb, gp_shoulderr, gp_shoulderrb, gp_select, gp_start];
	    for (var i = 0; i < array_length(gpb); i++) {
	        if gamepad_button_check(0, gpb[i]) {
	            im = "Gamepad";
	            break;
			}
        }
		if abs(gamepad_axis_value(0,gp_axislh) > gp_deadzone) || abs(gamepad_axis_value(0,gp_axislv) > gp_deadzone) || abs(gamepad_axis_value(0,gp_axisrh) > gp_deadzone) || abs(gamepad_axis_value(0,gp_axisrv) > gp_deadzone) {
			im = "Gamepad";
		}
    }
	if keyboard_check(vk_anykey) { im = "Keyboard" }
	if mouse_check_button(mb_any) { im = "Mouse" }
	if os_type = os_android || os_type = os_ios { im = "Tocuhscreen" }
	switch im {
		case "Keyboard":
			INPUT_MOVE_UP    = keyboard_check (ord("W"))
			INPUT_MOVE_DOWN  = keyboard_check (ord("S"))
			INPUT_MOVE_LEFT  = keyboard_check (ord("A"))
			INPUT_MOVE_RIGHT = keyboard_check (ord("D"))
			VirDir = INPUT_MOVE_DOWN - INPUT_MOVE_UP
			HorDir = INPUT_MOVE_RIGHT - INPUT_MOVE_LEFT
			MagDir = clamp(point_distance(0,0,HorDir,VirDir),0,1)
			Move_Direction = point_direction(0,0,HorDir,VirDir)
			break;
		case "Gamepad":
			INPUT_MOVE_UP    = gamepad_axis_value(0,gp_axislv)
			INPUT_MOVE_DOWN  = gamepad_axis_value(0,gp_axislv)
			INPUT_MOVE_LEFT  = gamepad_axis_value(0,gp_axislh)
			INPUT_MOVE_RIGHT = gamepad_axis_value(0,gp_axislh)
			VirDir = INPUT_MOVE_DOWN - INPUT_MOVE_UP
			HorDir = INPUT_MOVE_RIGHT - INPUT_MOVE_LEFT
			MagDir = clamp(point_distance(0,0,HorDir,VirDir),0,1)
			Move_Direction = point_direction(0,0,HorDir,VirDir)
			break;
		case "Tocuhscreen":
		case "Mouse":
			if distance_to_point(mouse_x,mouse_y) > 10 {
				INPUT_POINTER_X = mouse_x
				INPUT_POINTER_Y = mouse_y
				INPUT_POINTER_PRESSED  = mouse_check_button_pressed(mb_left)
				INPUT_POINTER_HELD     = mouse_check_button(mb_left)
				INPUT_POINTER_RELEASED = mouse_check_button_released(mb_left)
				if x > mouse_x { HorDir = -1 }
				if x < mouse_x { HorDir = 1 }
				if y > mouse_y { VirDir = -1 }
				if y < mouse_y { VirDir = 1 }
				if INPUT_POINTER_HELD { MagDir = distance_to_point(mouse_x,mouse_y)/96; clamp(MagDir,0,1) }
				Move_Direction = point_direction(x,y,INPUT_POINTER_X,INPUT_POINTER_Y)
			} else {
				VirDir = 0
				HorDir = 0
				MagDir = 0
			}
			break;
		default:
			VirDir = 0
			HorDir = 0
		break;
	}
}

function InitPlayerInputIndexMK5() {
	gp_deadzone = 0.1
	INPUT_MOVE_UP    = 0
	INPUT_MOVE_DOWN  = 0
	INPUT_MOVE_LEFT  = 0
	INPUT_MOVE_RIGHT = 0
	VirDir = 0
	HorDir = 0
	MagDir = 0
	Move_Direction = 0
	INPUT_POINTER_X = 0
	INPUT_POINTER_Y = 0
	INPUT_POINTER_PRESSED  = 0
	INPUT_POINTER_HELD     = 0
	INPUT_POINTER_RELEASED = 0
}