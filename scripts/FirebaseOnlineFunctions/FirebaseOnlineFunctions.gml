
// User signs up or logs into Firebase
function TKF_Login(argument0 = -1, argument1 = -1, argument2 = -1) {
	if argument2 = -1 {
		// Player is logging in
		var EI = argument0	
		var PI = argument1
		
		
	} else {
		// Player is creating account
		var NI = argument0	
		var EI = argument1	
		var PI = argument2
		
	}
	
}



// Host updates the database with details
function TKF_UpdateHostDatabase(argument0) {
	if argument0 = 0 {
		// Delete this user's data from the RTDB
		
	} else {
		// Add this user's data to the RTDB
		
	}
	
}



// Recieved data from Firebase
function TKF_AsyncEvents() {
	// Login success/failure
	
	
	// Populate game browser with data
	/*
		var BrowserListEntries = buffer_read(Buffer_MatchCommand,buffer_s16);
		for (var ap = 0; ap < BrowserListEntries; ap++) {
			ds_list_add(GameBrowserList_Name, buffer_read(Buffer_MatchCommand,buffer_string)) // Add Name
			ds_list_add(GameBrowserList_Players, buffer_read(Buffer_MatchCommand,buffer_s16)) // Add Current Players
			ds_list_add(GameBrowserList_MaxPlayers, buffer_read(Buffer_MatchCommand,buffer_s16)) // Add Max Players
			ds_list_add(GameBrowserList_Map, buffer_read(Buffer_MatchCommand,buffer_string)) // Add Map
			ds_list_add(GameBrowserList_IP, "Online") // Add IP
		}
	*/
}
