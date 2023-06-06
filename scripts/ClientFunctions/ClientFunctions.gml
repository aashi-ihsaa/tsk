//
// The following functions are for the clients of of peer-to-peer gameplay
//
function LAN_Broadcast_Listener(ss) {
	if ss = 0 {
		network_destroy(global.P2P_LAN_BroadcastListener)
		global.P2P_LAN_BroadcastListener = -1
		}
	if ss = 1 {
		var port = Player_Controller.P2P_LAN_BroadcastListen_Port;
		//while (P2P_LAN_BroadcastListener < 0 && port < 6400) {
		    //port++
		    global.P2P_LAN_BroadcastListener = network_create_server(network_socket_udp, port, 50)
			//show_message("Listener: " + string(global.P2P_LAN_BroadcastListener))
		//}
	}
}

function P2P_Join(IPA) {
	// Connect to a LAN Server
	if P2P_ClientSocket = -1 {
		P2P_ClientSocket = network_create_socket(network_socket_tcp)
		network_set_config(network_config_connect_timeout, 5000)
		var ErrorConnectServer = network_connect(P2P_ClientSocket, IPA, 6432);
		// If connection fails, um lick my balls idk what to do yet
		if ErrorConnectServer = 0 {
			if object_exists(obj_Menu_GameBrowser) { with obj_Menu_GameBrowser { instance_destroy() } }
			show_message_async("Server Connection Successful! Welcome to the LAN game.")
			MultiplayerMode = 2 // 0 Singleplayer | 1 Host | 2 Client
			room_goto(rm_PregameLobby)
			MenuState("Client Lobby") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
			if ConnectionMode = 3 { TKS_MatchmakingRequest(-1) } // Matchmaking Request Type: -1 Update the Server | 0/1 Host Clear Private/Public | 2/3 Online Private Host/Join | 4/5 Public Host/Join
		} else {
			P2P_ClientSocket = -1 
			show_message_async("Error - Cannot connect to server!")
		}
	}
}

// Send the host the status of the client's inputs
function SendPlayerInputToHost() {
	// First the command
	buffer_seek(Buffer_P2P_Play,buffer_seek_start,0)
	buffer_write(Buffer_P2P_Play,buffer_s16,P2P_PLAYER_COMMAND);
	// Then the details
	buffer_write(Buffer_P2P_Play,buffer_string,PL_PlayerID);
	buffer_write(Buffer_P2P_Play,buffer_f16,VirDir);
	buffer_write(Buffer_P2P_Play,buffer_f16,HorDir);
	buffer_write(Buffer_P2P_Play,buffer_f16,MagDir);
	buffer_write(Buffer_P2P_Play,buffer_s16,Move_Direction);
	// Send that bitch
	network_send_packet(P2P_ClientSocket,Buffer_P2P_Play,buffer_tell(Buffer_P2P_Play))
	
}

// Recieved data from the host about the gamestate
function P2P_ClientRecievedData() {
	// Recieved the list of where to draw everything
	var buff = ds_map_find_value(async_load, "buffer");
	var cmd = buffer_read(buff, buffer_s16); 
	switch cmd {
		case P2P_SERVER_COMMAND:
		    // Read all data....
		    DrawObjCount = buffer_read(buff,buffer_s16)
		
			x = buffer_read(buff,buffer_s16)
			y = buffer_read(buff,buffer_s16)
        
		    // NEW DATA!
		    ds_list_clear(AllSprites);
		    for (var i = 0; i < DrawObjCount; i++) {
				ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // sprite
		        ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // image
		        ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // x
		        ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // y
		        ds_list_add(AllSprites,buffer_read(buff,buffer_f16)) // xscale
		        ds_list_add(AllSprites,buffer_read(buff,buffer_f16)) // yscale
		        ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // Angle
		        ds_list_add(AllSprites,buffer_read(buff,buffer_s16)) // Color
		        ds_list_add(AllSprites,buffer_read(buff,buffer_f16)) // Alpha
			}
			break;
		
		case P2P_ROOM_GOTO:
			var gtm = buffer_read(buff,buffer_s16);
			room_goto(gtm)
			if gtm = rm_PregameLobby {
				MenuState("Client Lobby") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
			} else {
				MenuState("Gameplay") // Title, Online Access, Game Browser, Host Lobby, Client Lobby, Wardrobe, Options, Gameplay
			}
			break;
	}
}
