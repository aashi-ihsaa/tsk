function SimpleMenuInit() {
	MenuShow = true
	MenuSelection = 0
	CaptureTextInput = false
	PlayerTextInput = ""
	
	// Account Stuff
	MenuLoginType = 0 // 0 Nothing | 1 Login | 2 New Account
	MenuPlayerNameInput = ""
	MenuPlayerEmailInput = ""
	MenuPlayerPassInput = ""
	
	Menu_Headline = ""
	Menu_OnlineStatus = ""
	Menu_Option1 = ""
	Menu_Option2 = ""
	Menu_Option3 = ""
	Menu_Option4 = ""
	Menu_Option5 = ""
	Menu_Option6 = ""
	Menu_PlayButton = ""
	Menu_Browser = ""
	Menu_TextInput = ""
	Menu_PlayerList = ""
	
	MenuButtonBoard = instance_create_layer(19, 326, "MenuInstances", obj_Menu_ButtonBoard)
	MenuButton_1 = instance_create_layer(86, 104, "MenuButtons", obj_Menu_Button)
	MenuButton_2 = instance_create_layer(86, 138, "MenuButtons", obj_Menu_Button)
	MenuButton_3 = instance_create_layer(86, 172, "MenuButtons", obj_Menu_Button)
	MenuButton_4 = instance_create_layer(86, 218, "MenuButtons", obj_Menu_Button)
	MenuButton_5 = instance_create_layer(86, 264, "MenuButtons", obj_Menu_Button)
	MenuButton_6 = instance_create_layer(86, 298, "MenuButtons", obj_Menu_Button)
	MenuButton_Play = instance_create_layer(320, 285, "MenuButtons", obj_Menu_Button)
	MenuTextField_1 = -1 //instance_create_layer(212, 180, "MenuButtons", obj_Menu_Text_Input)
	MenuTextField_2 = -1 //instance_create_layer(212, 180, "MenuButtons", obj_Menu_Text_Input)
	MenuTextField_3 = -1 //instance_create_layer(212, 180, "MenuButtons", obj_Menu_Text_Input)
	
	MenuButtonList = ds_list_create()
	ds_list_add(MenuButtonList,MenuButton_1)
	ds_list_add(MenuButtonList,MenuButton_2)
	ds_list_add(MenuButtonList,MenuButton_3)
	ds_list_add(MenuButtonList,MenuButton_4)
	ds_list_add(MenuButtonList,MenuButton_5)
	ds_list_add(MenuButtonList,MenuButton_6)
	ds_list_add(MenuButtonList,MenuButton_Play)
	
	SimpleMenuInitCont()
	
	
	MenuState("Title")
}

function MenuState(m_level) {
	SimpleMenu_CheckOnlineStatus()
	switch m_level {
		case "Title":
			Menu_Headline = "Thieves Knight"
			if ConnectionMode = 3 { Menu_Option1 = "Play" } else { Menu_Option1 = "Play (LAN)" } // Menu Option 1
			if ConnectionMode = 3 { Menu_Option2 = "Host" } else { Menu_Option2 = "Host (LAN)" } // Menu Option 2
			Menu_Option3 = "Wardrobe"
			if ConnectionMode = 3 { Menu_Option4 = "Go Offline" } else { Menu_Option4 = "Go Online" } // Menu Option 4
			Menu_Option5 = "Options"
			Menu_Option6 = "Quit"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Show"
			Menu_PlayerList = "Hide"
			
			PL_PlayerSector = "Main Menu"
			break;
		case "Online Access":
			Menu_Headline = "Thieves Knight"
			Menu_Option1 = "Log In"
			Menu_Option2 = "New Account"
			Menu_Option3 = ""
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Back"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			break;
		case "Game Browser":
			Menu_Headline = "Adventure Browser"
			Menu_Option1 = "Password"
			Menu_Option2 = ""
			Menu_Option3 = ""
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Main Menu"
			Menu_PlayButton = "Join the Raid!"
			Menu_Browser = "Show"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			
			PL_PlayerSector = "Game Browser"
			break;
		case "Host Lobby":
			Menu_Headline = "Host of Theives"
			Menu_Option1 = "Password"
			Menu_Option2 = "Map"
			Menu_Option3 = ""
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Main Menu"
			Menu_PlayButton = "Begin!"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Show"
			
			PL_PlayerSector = "Host Lobby"
			break;
		case "Client Lobby":
			Menu_Headline = "Adventure Tavern"
			Menu_Option1 = ""
			Menu_Option2 = ""
			Menu_Option3 = ""
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Leave"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			
			PL_PlayerSector = "Client Lobby"
			break;
		case "Wardrobe":
			Menu_Headline = "Wardrobe"
			Menu_Option1 = "Outfit"
			Menu_Option2 = "Dye"
			Menu_Option3 = "Skin Color"
			Menu_Option4 = "Gender"
			Menu_Option5 = ""
			Menu_Option6 = "Save"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			break;
		case "Options":
			Menu_Headline = "Options"
			Menu_Option1 = "Fullscreen"
			Menu_Option2 = "Volume"
			Menu_Option3 = "Auto-Login"
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Save"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			break;
		case "Gameplay":
			Menu_Headline = ""
			Menu_Option1 = ""
			Menu_Option2 = ""
			Menu_Option3 = ""
			Menu_Option4 = ""
			Menu_Option5 = ""
			Menu_Option6 = "Flee"
			Menu_PlayButton = "Hide"
			Menu_Browser = "Hide"
			Menu_TextInput = "Hide"
			Menu_PlayerList = "Hide"
			
			PL_PlayerSector = "TestZone"
			break;
	}
	
	// Assign Button Texts
	MenuButton_1.Text = Menu_Option1
	MenuButton_2.Text = Menu_Option2
	MenuButton_3.Text = Menu_Option3
	MenuButton_4.Text = Menu_Option4
	MenuButton_5.Text = Menu_Option5
	MenuButton_6.Text = Menu_Option6
	MenuButton_Play.Text = Menu_PlayButton
	if object_exists(obj_Menu_Text_Input) {
		MenuTextField_1 = -1
		MenuTextField_2 = -1
		MenuTextField_3 = -1
		with obj_Menu_Text_Input { instance_destroy() }
	}
	if object_exists(obj_Menu_GameBrowser) { with obj_Menu_GameBrowser { instance_destroy() } }
	TKS_MatchmakingRequest(-1)
}

function SimpleMenu_CheckOnlineStatus() {
	switch ConnectionMode {  // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
		case 0:
			Menu_OnlineStatus = "Offline"
			break;
		case 1:
			Menu_OnlineStatus = "Connected"
			break;
		case 2:
			Menu_OnlineStatus = "Attempting/nLogin"
			break;
		case 3:
			Menu_OnlineStatus = "Online"
			break;
	}
}

function SimpleMenuDraw() { // Drawing all the Menu Wankery
	// Headline
	draw_set_font(fnt_DutchBrigade_24)
	draw_set_color(c_black)
	draw_set_halign(fa_left)
	var hdcc = (string_length(Menu_Headline)/14)*0.33;
	draw_sprite_ext(spr_menu_board_small, 1, 0, 36, hdcc, 0.25, 0, c_white, 1)
	outline_draw_text(24,17,Menu_Headline,ol_config(2,c_white,0.3,1))
	
	// Online Status
	var draw_x = 640;
	var draw_y = 22;
	draw_set_font(fnt_Caligraf_12)
	draw_set_halign(fa_right)
	draw_set_color(c_black)
	draw_set_halign(fa_right)
	switch ConnectionMode { // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
		case 0:
			draw_sprite_ext(spr_menu_board_small, 1, draw_x, draw_y, -0.12, 0.13, 0, c_white, 1)
			draw_text(display_get_gui_width()-14,draw_y-12,"Offline")
			break;
		case 1: 
			draw_sprite_ext(spr_menu_board_small, 1, draw_x, draw_y, -0.12, 0.13, 0, c_white, 1)
			draw_text(display_get_gui_width()-14,draw_y-12,"Connected")
			break;
		case 2: 
			draw_sprite_ext(spr_menu_board_small, 1, draw_x, draw_y, -0.12, 0.13, 0, c_white, 1)
			draw_text(display_get_gui_width()-14,draw_y-12,"Trying Login")
			break;
		case 3: 
			draw_sprite_ext(spr_menu_board_small, 1, draw_x, draw_y+10, -0.13, 0.21, 0, c_white, 1)
			draw_text(display_get_gui_width()-14,draw_y-12,"Online")
			draw_text(display_get_gui_width()-14,draw_y+8,PL_PlayerID)
			break;
	}
	
	// Button Bar
	if Menu_Option1 != "" { draw_sprite_ext(spr_menu_board_small, 0, 86, 324, 0.34, 0.46, 90, c_white, 1) }
	
		for (var i = 0; i < ds_list_size(MenuButtonList); i++) {
			var bo = MenuButtonList[|i];
			if bo.visible = true {
				draw_sprite_ext(bo.sprite_index, bo.image_index, bo.DrawXoffset, bo.DrawYoffset, bo.image_xscale, bo.image_yscale, bo.image_angle, bo.image_blend, bo.image_alpha)
					draw_set_color(bo.DrawColor)
				if bo.object_index = obj_Menu_Button {
					draw_set_halign(fa_center)
					draw_set_font(fnt_BuddyChampion_12)
					outline_draw_text(bo.DrawXoffset, bo.DrawYoffset+bo.DrawHeight, bo.Text, ol_config(1,c_black,1,1))
				}
				if bo.object_index = obj_Menu_Text_Input {
					draw_sprite_ext(bo.sprite_index, 1, bo.paper_DrawXoffset, bo.DrawYoffset, bo.paper_image_xscale, bo.paper_image_yscale, bo.image_angle, bo.image_blend, bo.image_alpha)
					draw_set_halign(fa_left)
					draw_set_font(fnt_BuddyChampion_12)
					outline_draw_text(bo.TextDrawXoffset, bo.PanelDrawHeight, bo.PanelText, ol_config(1,c_black,1,1))
					draw_set_color(c_black)
					draw_set_font(fnt_DutchBrigade_12)
					draw_text(bo.paper_TextDrawXoffset, bo.TextDrawHeight, bo.PlayerText)
				}
				if bo.object_index = obj_Menu_GameBrowser {
					// Draw the list entries
					var ls = ds_list_size(GameBrowserList_Name);
					var lsos = 25
					draw_text(300,180,ls)
					if ls > 0 {
						for (var ii = 0; ii < bo.DisplayCount; ii++) {
							draw_sprite_ext(bo.sprite_index, 1, bo.paper_DrawXoffset, bo.paper_ListYStart+(ii*lsos), bo.paper_image_xscale, bo.paper_image_yscale, bo.image_angle, bo.image_blend, bo.image_alpha)
						    var entryName = ds_list_find_value(GameBrowserList_Name, ii + bo.ScrollPos); // Name
						    var entryPlayers = ds_list_find_value(GameBrowserList_Players, ii + bo.ScrollPos); // Player Count
						    var entryMaxPlayers = ds_list_find_value(GameBrowserList_MaxPlayers, ii + bo.ScrollPos); // Max Players
						    var entryMap = ds_list_find_value(GameBrowserList_Map, ii + bo.ScrollPos); // Map
							draw_set_halign(fa_left)
							draw_set_font(fnt_BuddyChampion_12)
						    if ii = bo.SelectedEntry { draw_set_color(bo.HighColor) } else { draw_set_color(bo.DefColor) }
						    outline_draw_text(bo.paper_TextDrawXoffset, bo.paper_TextDrawYstart + (ii * lsos), entryName, ol_config(1,c_black,1,1));
						    outline_draw_text(bo.paper_TextDrawXoffset+120, bo.paper_TextDrawYstart + (ii * lsos), string(entryPlayers) + "-" + string(entryMaxPlayers) + " Players      " + entryMap, ol_config(1,c_black,1,1));
						}
					}
					if ls > 6 {
						var smh	= 108+(135*((bo.ScrollPos)/(ls-6)));
						draw_set_color(#45AAF2)
						draw_line(468, 108, 468, 243)
						draw_sprite_ext(spr_Waypoint, 0, 469, smh, 0.5, 0.5, 0, c_white, 1)
					}
				}
			}
		}

		
	// Browser
	if Menu_Browser = "Show" {
	
	}
	
	// Text Input
	
	
	// Player List
	if Menu_PlayerList = "Show" {
		draw_sprite_ext(spr_menu_board_small, 1, 578, 321, 0.26, 0.42, 90, c_white, 1)
		draw_sprite_ext(spr_menu_stoneplate, 0, 578, 148, 0.21, 0.25, 0, c_white, 1)
		draw_set_color(c_black)
		draw_set_halign(fa_center)
		outline_draw_text(578,142,"Guest List",ol_config(1,c_grey,1,0.8))
	}
	
}
	

#region // Menu Functions
function SimpleMenuInitCont() { // Initialize the Menu State Machine
	// Menu Option 1
	MenuAction_Option1 = function() {
		switch Menu_Option1 {
			case "Play (LAN)":
			case "Play":
				MenuState("Game Browser")
				//LAN_Broadcast_Listener(1)
				instance_create_layer(150, 175, "MenuButtons", obj_Menu_GameBrowser)
				break;
			case "Log In":
				if object_exists(obj_Menu_Text_Input) { with obj_Menu_Text_Input { instance_destroy() } }
				MenuTextField_1 = -1
				MenuTextField_2 = -1
				MenuTextField_3 = -1
				SimpleMenu_CreateTextInput(-0.5, "Shady Email:")
				SimpleMenu_CreateTextInput(0.5, "Passphrase:")
				Menu_PlayButton = "Submit"
				MenuButton_Play.Text = "Submit"
				break;
			case "Password":
				
				break;
			case "Outfit":
				
				break;
			case "Fullscreen":
				
				break;
		}
	}
	// Menu Option 2
	MenuAction_Option2 = function() {
		switch Menu_Option2 {
			case "Host (LAN)":
			Submit();
			case "Host":
				room_goto(rm_PregameLobby)
				PL_PlayerSector = "Host Lobby"
				MenuState("Host Lobby") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
				MyPlayer = instance_create_layer(100,100,"GameObjects",obj_Player)
				StartHostServer()
				break;
			case "New Account":
				if object_exists(obj_Menu_Text_Input) { with obj_Menu_Text_Input { instance_destroy() } }
				MenuTextField_1 = -1
				MenuTextField_2 = -1
				MenuTextField_3 = -1
				SimpleMenu_CreateTextInput(-1, "Thief Name:")
				SimpleMenu_CreateTextInput(0, "Shady Email:")
				SimpleMenu_CreateTextInput(1, "Passphrase:")
				Menu_PlayButton = "Submit"
				MenuButton_Play.Text = "Submit"
				break;
			case "Map":
				
				break;
			case "Dye":
				
				break;
			case "Volume":
				
				break;
		}
	}
	// Menu Option 3
	MenuAction_Option3 = function() {
		switch Menu_Option3 {
			case "Wardrobe":
			
				break;
			case "Skin Color":
			
				break;
			case "Host":
				
				break;
			case "Auto-Login":
				
				break;
		}
	}
	// Menu Option 4
	MenuAction_Option4 = function() {
		switch Menu_Option4 {
			case "Go Offline":
				show_message("Disconnected from online services. Now entering Offline Mode.")
				network_destroy(TKSClientSocket)
				TKSClientSocket = -1
				ConnectionMode = 0
				MenuState("Title") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
				break;
			case "Go Online":
				//GoOnline()
				ConnectionMode = 1 // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
				MenuState("Online Access")
				break;
			case "Gender":
				
				break;
		}
	}
	// Menu Option 5
	MenuAction_Option5 = function() {
		switch Menu_Option5 {
			case "Options":
				
				break;
		}
	}
	// Menu Option 6
	MenuAction_Option6 = function() {
		switch Menu_Option6 {
			case "Quit":
				game_end()
				break;
			case "Back":
				show_message("Disconnected from online services. Now entering Offline Mode.")
				network_destroy(TKSClientSocket)
				TKSClientSocket = -1
				ConnectionMode = 0
				MenuState("Title") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
				break;
			case "Main Menu":
				//LAN_Broadcaster(0)
				//LAN_Broadcast_Listener(0)
				MenuState("Title")
				break;
			case "Leave":
				
				break;
			case "Save":
				MenuState("Title")
				break;
			case "Flee":
				
				break;
		}
	}
	// Menu Option Play Button
	MenuAction_PlayButton = function() {
		switch Menu_PlayButton {
			case "Begin!":
				room_goto(rm_TestZone)
				P2P_Room_Goto(rm_TestZone)
				PL_PlayerSector = "TestZone"
				CoinSpawn_Timer = CoinSpawn_Frequency
				MenuShow = false
				MenuState("Gameplay")
				break;
			case "Join the Raid!":
				
				break;
			case "Submit":
					with obj_Menu_Text_Input { Selected = false }
					keyboard_string = ""
					if MenuTextField_3 != -1 {
						if CheckUserTextInput("Name",MenuTextField_1.PlayerText) && CheckUserTextInput("Email",MenuTextField_2.PlayerText) && CheckUserTextInput("Password",MenuTextField_3.PlayerText) {
							//MenuPlayerNameInput = MenuTextField_1.PlayerText
							//MenuPlayerEmailInput = MenuTextField_2.PlayerText
							//MenuPlayerPassInput = MenuTextField_3.PlayerText
							//TKS_Login(1)
							TKF_Login(MenuTextField_1.PlayerText, MenuTextField_2.PlayerText, MenuTextField_3.PlayerText)
						}
					} else {
						if CheckUserTextInput("Email",MenuTextField_1.PlayerText) && CheckUserTextInput("Password",MenuTextField_2.PlayerText) {
							//MenuPlayerEmailInput = MenuTextField_1.PlayerText
							//MenuPlayerPassInput = MenuTextField_2.PlayerText
							//TKS_Login(0)
							TKF_Login(MenuTextField_1.PlayerText, MenuTextField_2.PlayerText)
						}
					}
				break;
		}
	}
	// Menu Game Browser
	MenuAction_BrowserPlayerSelected = function(sp) {
		//LAN_Broadcast_Listener(0)
		var spIP = ds_list_find_value(GameBrowserList_IP,ds_list_find_index(GameBrowserList_Name,sp));
		if  spIP != "Online" {
			P2P_Join(spIP)
		} else {
			TKS_MatchmakingRequest(5,sp)
		}
	}
}
	
function SimpleMenu_CreateTextInput(ly, pltxt) {
	if instance_number(obj_Menu_Text_Input) = 0 {
		MenuTextField_1 = instance_create_layer(190, 180+(ly*45), "MenuButtons", obj_Menu_Text_Input)
		MenuTextField_1.PanelText = pltxt
		return;
	}
	if instance_number(obj_Menu_Text_Input) = 1 {
		MenuTextField_2 = instance_create_layer(190, 180+(ly*45), "MenuButtons", obj_Menu_Text_Input)
		MenuTextField_2.PanelText = pltxt
		return;
	}
	if instance_number(obj_Menu_Text_Input) = 2 {
		MenuTextField_3 = instance_create_layer(190, 180+(ly*45), "MenuButtons", obj_Menu_Text_Input)
		MenuTextField_3.PanelText = pltxt
		return;
	}
}
#endregion

#region // User Text Input Functions
function CheckUserTextInput(what4,texticles) {
	// Length Check
    if string_length(texticles) < 3 {
        show_message("This field must be at least 3 characters long.");
        return false;
    }
    if string_length(texticles) > 100 {
        show_message("This field contains too many characters.");
        return false;
    }
	// Character Check
	switch what4 {
		case "Name":
		    if string_length(texticles) > 24 {
		        show_message("Your Name may not exceed 24 characters long.");
		        return false;
		    }
		    var allowed_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
		    for (var i = 1; i <= string_length(texticles); i++) {
		        if !string_pos(string_char_at(texticles, i), allowed_chars) {
		            show_message("Names: Only alphabetical and numerical characters are accepted.");
		            return false;
				}
			}
			break;
		case "Email":
		    var allowed_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!#$%&.'*+-/=?^_`{|}~";
			var required_char_at = false;
			var required_char_dot = false;
			if string_pos("@", texticles) { required_char_at = true }
			if string_pos(".", texticles) { required_char_dot = true }
		    for (var i = 1; i <= string_length(texticles); i++) {
		        if !string_pos(string_char_at(texticles, i), allowed_chars) || !required_char_at || !required_char_dot {
		            show_message("Email address is invalid.");
		            return false;
				}
			}
			break;
		case "Password":
		    var allowed_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=[]{}|:,.<>/?";
		    for (var i = 1; i <= string_length(texticles); i++) {
		        if !string_pos(string_char_at(texticles, i), allowed_chars) {
		            show_message("Passphrase: Only alphabetical, numerical, and common special characters are accepted.");
		            return false;
				}
			}
			break;
			
			
	}
	return true;
}

#endregion