//  Highlight
if position_meeting(mouse_x,mouse_y,self) || Selected { DrawColor = HighColor }
else { DrawColor = DefColor }
// Select
if mouse_check_button_pressed(mb_left) {
	if position_meeting(mouse_x,mouse_y,self) {
		Selected = true
		keyboard_string = ""
		DrawColor = HighColor
	} else {
		Selected = false
		DrawColor = DefColor
	}
}
if Selected {
	PlayerText = keyboard_string
	if keyboard_check_pressed(vk_enter) {
		Selected = false
		keyboard_string = ""
	}
}
if keyboard_check_pressed(vk_tab) && Selected {
		Selected = false	
		keyboard_string = ""
	
}