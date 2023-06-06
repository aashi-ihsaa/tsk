/// @description THE MAGIC!
var EventID = ds_map_find_value(async_load, "id");

//if global.P2P_LAN_BroadcastListener > -1 {
	if EventID == global.P2P_LAN_BroadcastListener {
		var buff = ds_map_find_value(async_load, "buffer");
		var ip = ds_map_find_value(async_load, "ip");
		//show_message_async("Broadcast heard")
	
		var index = ds_list_find_index(GameBrowserList_IP, ip);
		if index < 0 {
			ds_list_add(GameBrowserList_Name,buffer_read(buff,buffer_string)) // Add Name
			ds_list_add(GameBrowserList_Players,buffer_read(buff,buffer_s16)) // Add Current Players
			ds_list_add(GameBrowserList_MaxPlayers,buffer_read(buff,buffer_s16)) // Add Max Players
			ds_list_add(GameBrowserList_Map,buffer_read(buff,buffer_string)) // Add Map
			ds_list_add(GameBrowserList_IP,ip) // Add IP
		}
	}
//}

// Received data from the LEGACY Thieves Knight Server
if EventID == TKSClientSocket { TKS_AsyncEvents() }

// Recieved data from Firebase
//if EventID == TKFirebase { function TKF_AsyncEvents() }

// Recieved data from P2P connections
switch MultiplayerMode { // 0 Singleplayer | 1 Host | 2 Client
	case 1:
		if EventID == P2P_Server { // Received data from client players
			// If the socket ID is the server one, then it's a new client connecting OR an old client disconnecting
			P2P_ConnectDisconnectClient()
		} else {
			// All other sockets are connected client sockets, and we have recieved commands from them.
			P2P_ServerRecievedData()
		}
	break;
	case 2:
		if EventID == P2P_ClientSocket { // Received data from host player
			P2P_ClientRecievedData()
		}
	break;
	default:
}
