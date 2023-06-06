/// @description Game Handling
//
// This object takes inputs first and depending on certain criteria, will
// distribute the information to where it needs to go.

// Get this step's input status
// What to do with player character commands?
if MyPlayer != -1 {
	with MyPlayer { PlayerInputIndexMK5() }
}
	PlayerInputIndexMK5()

// Send pings to server
// 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
if ConnectionMode > 0 { 
	PingTimer -= 1
	if PingTimer = 0 { SendKeepAlive(); PingTimer = 120 }
}


// Menu
if keyboard_check_pressed(vk_up) {
	ds_list_add(GameBrowserList_Name,"Mackerel "+string(ds_list_size(GameBrowserList_Name)))
	}

if CaptureTextInput = true { PlayerTextInput = keyboard_string }

if keyboard_check_pressed(vk_space) { instance_create_layer(200,200,"GameObjects",obj_Enemy)}
if keyboard_check_pressed(vk_escape) { game_end() }

if keyboard_check_pressed(vk_enter) {
	/*if CaptureTextInput = false {  } 
	else {
		PlayerTextInput = ""
		switch MenuLevel {
			case "New Player":
				switch MenuSelection {
				case 0:
					MenuPlayerNameInput = PlayerTextInput
					MenuSelection ++
					break;
				case 1:
					MenuPlayerEmailInput = string_lower(PlayerTextInput)
					MenuSelection ++
					break;
				case 2:
					MenuPlayerPassInput = PlayerTextInput
					break;
				}
				break;
			case "Log In":
				switch MenuSelection {
				case 0:
					MenuPlayerEmailInput = string_lower(PlayerTextInput)
					MenuSelection ++
					break;
				case 1:
					MenuPlayerPassInput = PlayerTextInput
					break;
			}
		}

		CaptureTextInput = false
		PlayerTextInput = ""
		keyboard_string = ""
	}*/
}
