//
// The following functions are for commuincating with Thieves Knight online services
//

// TKS Connect to the server
function GoOnline() {
	// Connect to the Matchmaker Server
	if TKSClientSocket = -1 {
		// Connect to the Thieves Knight Server
		//
		// Check to see if player is a dirty PS4/PS5 pleb...
		var PlebCheck = 3264;
		if os_type = os_ps4 { PlebCheck = 3274 }
		// Connect to server
		TKSClientSocket = network_create_socket(network_socket_tcp)
		network_set_config(network_config_connect_timeout, 5000)
		var ErrorConnectServer = network_connect(TKSClientSocket, ServerID, PlebCheck);
		// If connection fails, go to Offline Mode
		if ErrorConnectServer = 0 {
			show_message("Server Connection Successful! Welcome to Thieves Knight Online.")
			ConnectionMode = 1 // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
		} else {
			show_message("Error - Cannot connect to server! Starting in Offline Mode.")
			TKSClientSocket = -1 
			ConnectionMode = 0
		}
	} else {
		// Update the server with this client's player data
	}
	
}

// TKS Login
function TKS_Login(LT) {
	// 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
	if ConnectionMode = 1 {
		buffer_seek(Buffer_Login,buffer_seek_start,0)
		switch LT {
			case 0: // Log In
				buffer_write(Buffer_Login,buffer_s16,PLAYER_LOGIN)
				buffer_write(Buffer_Login,buffer_string,MenuPlayerEmailInput)
				buffer_write(Buffer_Login,buffer_string,MenuPlayerPassInput)
				LoginSaveEmail = MenuPlayerEmailInput
				LoginSavePass = MenuPlayerPassInput
				break;
			case 1: // New Player
				buffer_write(Buffer_Login,buffer_s16,NEW_PLAYER)
				buffer_write(Buffer_Login,buffer_string,MenuPlayerNameInput)
				buffer_write(Buffer_Login,buffer_string,MenuPlayerEmailInput)
				buffer_write(Buffer_Login,buffer_string,MenuPlayerPassInput)
				LoginSaveEmail = MenuPlayerEmailInput
				LoginSavePass = MenuPlayerPassInput
				break;
		}
		ConnectionMode = 2
		network_send_packet(TKSClientSocket,Buffer_Login,buffer_tell(Buffer_Login))
	}
}

function SendKeepAlive() {
	// Ping the server now and then so we know if we're still connected or not....
	buffer_seek(Buffer_Ping, buffer_seek_start, 0);
	buffer_write(Buffer_Ping, buffer_s16, PING_CMD);
	var size = network_send_packet(TKSClientSocket, Buffer_Ping, buffer_tell(Buffer_Ping));
	if size <= 0 {
		network_destroy(TKSClientSocket);
		TKSClientSocket = -1
		ConnectionMode = 0
		show_message("Lost connection to the Theives Knight Server...")
	}

}


// Matchmaking Info Update
// TKS_MatchmakingRequest(Request Type, Additional Info)
// Request Type:		-1 Update the Server | 0/1 Local Host/Join | 2/3 Online Private Host/Join | 4/5 Public Host/Join
// Additional Info:  	Name of player to join, leave 0 for nothing
function TKS_MatchmakingRequest(argument0, argument1 = "") {
	buffer_seek(Buffer_PlayerInfo,buffer_seek_start,0)
	// First set the correct command to the server
	if argument0 = -1 { buffer_write(Buffer_PlayerInfo,buffer_s16,MATCHMAKING_INFO_UPDATE) } // Info Command 
	else { buffer_write(Buffer_PlayerInfo,buffer_s16,MATCHMAKING_REQUEST) } // Info Command
	// Matchmaking Type | Matching Password  | Sector ID | Gameplay Map | Pregame/Playing? | Player Count | Max Players
	buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerMatch)          // Matchmaking Type
	buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMatchPass)   // Matching Password
	buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerSector)      // Sector ID
	buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMap)         // Gameplay Map
	buffer_write(Buffer_PlayerInfo,buffer_bool,PL_PlayerGameStart)     // Pregame/Playing?
	buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerPlayers)        // Player Count
	buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerPlayersMax)     // Max Players
	
	// Matchmaking Request Type: -1 Update the Server | 0/1 Host Clear Private/Public | 2/3 Online Private Host/Join | 4/5 Public Host/Join
	if argument0 > -1  {
		switch argument0 {
			case 0://  Host Clear Private Game
			case 1://  Host Clear Public Game
				buffer_write(Buffer_PlayerInfo,buffer_s16,1) // Match Type
				buffer_write(Buffer_PlayerInfo,buffer_s16,0) // PlaceDelete
				buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMatchPass) // Password
				break;
			case 2:// Private Game Hosting
			case 4:// Public Game Hosting
				buffer_write(Buffer_PlayerInfo,buffer_s16,1) // Match Type
				buffer_write(Buffer_PlayerInfo,buffer_s16,1) // PlaceDelete
				buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMatchPass) // Password
				break;
			case 3:// Private Game Join Request
			case 5:// Public Game Join Request
				buffer_write(Buffer_PlayerInfo,buffer_s16,2) // Match Type
				buffer_write(Buffer_PlayerInfo,buffer_string,argument1) // Host Player to Join
				buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMatchPass) // Password
				break;
		}
	}
	// Send the server all the goods!	
	network_send_packet(TKSClientSocket,Buffer_PlayerInfo, buffer_tell(Buffer_PlayerInfo));
}

function TKS_AsyncEvents() {
	var buff = ds_map_find_value(async_load, "buffer");
	var cmd = buffer_read(buff, buffer_s16);
	
	// Now send a handshake with client game version
	if cmd == HANDSHAKE { 
		buffer_seek(Buffer_Handshake,buffer_seek_start, 0)
		buffer_write(Buffer_Handshake,buffer_s16,HANDSHAKE)
		buffer_write(Buffer_Handshake,buffer_string,GameVersion)
		network_send_packet(TKSClientSocket,Buffer_Handshake, buffer_tell(Buffer_Handshake));
	}
	
	// Server version mismatch
	if cmd == DISCONNECT_NOW { 
		show_message_async("The server forced your client to disconnect.")
		network_destroy(TKSClientSocket)
		TKSClientSocket = -1
		ConnectionMode = 0
		SimpleMenu_CheckOnlineStatus()
	}
	
	// Accessed the Server
	//
	// Change menu to select log in or new player
	if cmd == ONLINE_ACCESS { // Player is connected to the server
		ConnectionMode = 1 // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
		MenuState("Online Access")
	}
	
	// New Player
	// Email not found / Password incorrect
	if cmd == NP_NAME_TAKEN {
		ConnectionMode = 1
		show_message_async("That name is already taken.")
	}
	if cmd == NP_EMAIL_TAKEN {
		ConnectionMode = 1
		show_message_async("That email is already in use.")
	}
	
	// Log In
	// Email not found / Password incorrect
	if cmd == LOGIN_EMAIL_NOT_FOUND {
		ConnectionMode = 1
		show_message_async("Email Not Found")
	}
	if cmd == LOGIN_PASSWORD_INCORRECT {
		ConnectionMode = 1
		show_message_async("Password Incorrect")
	}
	
	// Successful log in
	if cmd == LOGIN_SUCCESS && ConnectionMode = 2 {
		ConnectionMode = 3 // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
		PL_PlayerID = buffer_read(buff,buffer_string)
		MenuState("Title")
		show_message_async("Login was successful!")
		cmd = MATCHMAKING_INFO
	}
	
	// Match Making Information
	//
	// Send the server the player's info for the first time after login
	if cmd == MATCHMAKING_INFO { 
		// Player ID | OS Type | IP Address | Matchmaking Type | Matching Password  | Sector ID | Gameplay Map | Pregame/Playing? | Player Count | Max Players
		buffer_seek(Buffer_PlayerInfo,buffer_seek_start,0)
		buffer_write(Buffer_PlayerInfo,buffer_s16,MATCHMAKING_INFO)      // Info Command
		buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerOS)        // OS Type
		buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerMatch)        // Matchmaking Type: -1 Nothing | 0/1 Local Host/Join | 2/3 Online Private Host/Join | 4/5 Public Host/Join
		buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMatchPass) // Matching Password
		buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerSector)    // Sector ID
		buffer_write(Buffer_PlayerInfo,buffer_string,PL_PlayerMap)       // Gameplay Map
		buffer_write(Buffer_PlayerInfo,buffer_bool,PL_PlayerGameStart)   // Pregame/Playing?
		buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerPlayers)      // Enemy Count
		buffer_write(Buffer_PlayerInfo,buffer_s16,PL_PlayerPlayersMax)   // Max Players
		
				
		network_send_packet(TKSClientSocket,Buffer_PlayerInfo, buffer_tell(Buffer_PlayerInfo));
	}
	
	// Update the server with juicy information
	if cmd == MATCHMAKING_INFO_UPDATE {
		TKS_MatchmakingRequest(-1)
	}
	
	// Tell this client to whom they will connect
	if cmd == MATCHMAKING_COMMAND {
		P2P_Join(buffer_read(Buffer_MatchCommand,buffer_string))
	}
	
	if cmd == MATCHMAKING_INFO_BROWSER {
		var BrowserListEntries = buffer_read(Buffer_MatchCommand,buffer_s16);
		for (var ap = 0; ap < BrowserListEntries; ap++) {
			ds_list_add(GameBrowserList_Name, buffer_read(Buffer_MatchCommand,buffer_string)) // Add Name
			ds_list_add(GameBrowserList_Players, buffer_read(Buffer_MatchCommand,buffer_s16)) // Add Current Players
			ds_list_add(GameBrowserList_MaxPlayers, buffer_read(Buffer_MatchCommand,buffer_s16)) // Add Max Players
			ds_list_add(GameBrowserList_Map, buffer_read(Buffer_MatchCommand,buffer_string)) // Add Map
			ds_list_add(GameBrowserList_IP, "Online") // Add IP
		}
	}
}