
if Text = "" || Text = "Hide" { visible = false } else { visible = true }

if visible {
	if position_meeting(mouse_x,mouse_y,self) {
		DrawColor = HighColor
	} else {
		DrawColor = DefColor
	}
	
	if mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,self) {
		image_index = 1
		DrawHeight = DrawHeight_Pressed
		DrawColor = PresColor
	}
	
	if image_index = 1 {
		if mouse_check_button_released(mb_left) || !position_meeting(mouse_x,mouse_y,self) {
				image_index = 0 
				DrawHeight = DrawHeight_Unpressed
				DrawColor = DefColor
		} 
		if mouse_check_button_released(mb_left) && position_meeting(mouse_x,mouse_y,self) {
			switch Text {
				// Option 1
				case "Play (LAN)":
				case "Play":
				case "Log In":
				case "Password":
				case "Outfit":
				case "Fullscreen":
					with Player_Controller { MenuAction_Option1() }
					break;
				// Option 2
				case "Host (LAN)":
				case "Host":
				case "New Account":
				case "Map":
				case "Dye":
				case "Volume":
					with Player_Controller { MenuAction_Option2() }
					break;
				// Option 3
				case "Wardrobe":
				case "Skin Color":
				case "Auto-Login":
					with Player_Controller { MenuAction_Option3() }
					break;
				// Option 4
				case "Go Offline":
				case "Go Online":
				case "Gender":
					with Player_Controller { MenuAction_Option4() }
					break;
				// Option 5
				case "Options":
					with Player_Controller { MenuAction_Option5() }
					break;
				// Option 6
				case "Quit":
				case "Back":
				case "Main Menu":
				case "Leave":
				case "Save":
				case "Flee":
					with Player_Controller { MenuAction_Option6() }
					break;
				// Play Button
				case "Begin!":
				case "Join the Raid!":
				case "Submit":
					with Player_Controller { MenuAction_PlayButton() }
					break;
			}
		}
	}
}