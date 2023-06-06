ListSize = ds_list_size(Player_Controller.GameBrowserList_Name);
DisplayCount = min(6, ListSize)
SelectedEntry = -1
SelectedPlayer = -1

if position_meeting(mouse_x,mouse_y,self) {
    var yy = ((mouse_y - (y-72)) div 25);
    if (yy >= 0 && yy < DisplayCount) {
        SelectedEntry = yy;
        SelectedPlayer = ds_list_find_value(Player_Controller.GameBrowserList_Name, yy + ScrollPos)
    }
	if mouse_check_button_pressed(mb_left) {
		with Player_Controller { MenuAction_BrowserPlayerSelected(other.SelectedPlayer) }
	}
}

if mouse_wheel_up() {
    ScrollPos = max(0, ScrollPos - 1);
}

if mouse_wheel_down() {
    ScrollPos = min(ListSize - DisplayCount, ScrollPos + 1);
}