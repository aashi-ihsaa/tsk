//
// The following functions are for the host's server systems of peer-to-peer gameplay
//
/*function LAN_Broadcaster(ss) {
	if ss = 0 { network_destroy(P2P_LAN_Broadcaster) }
	if ss = 1 {
		var port = P2P_LAN_BroadcastListen_Port;
		while (P2P_LAN_Broadcaster < 0 && port < 6400) {
		    port++
		    P2P_LAN_Broadcaster = network_create_server(network_socket_udp, port, 100)
		}
	}
}*/

function StartHostServer() { // Create the server. If boned, retry on other ports
	var port = P2P_Server_Port;
	while (P2P_Server < 0 && port < P2P_Server_Port+300) {
	    port++
	    P2P_Server = network_create_server(network_socket_tcp, port, 8)
	}
	if P2P_Server < 0 { show_message("Failed to create server. Server already exists.") }
	else {
		MultiplayerMode = 1 // 0 Singleplayer | 1 Host | 2 Client
		if ConnectionMode = 3 { TKS_MatchmakingRequest(4) } // Matchmaking Request Type: -1 Update the Server | 0/1 Host Clear Private/Public | 2/3 Online Private Host/Join | 4/5 Public Host/Join
		//LAN_Broadcaster(1)
	}
}

// Connect or Disconnect clients and their characters
function P2P_ConnectDisconnectClient() { 
	// 1 Connect or 0 Disconnect
	var t = ds_map_find_value(async_load, "type");
	var sock = ds_map_find_value(async_load, "socket");
	//var ip = ds_map_find_value(async_load, "ip");
    
	// Connecting?
	if t == network_type_connect {
		// Add client to our list of connected clients
		ds_list_add(SocketList, sock);

		// Create a new player character for the client       
		var inst = instance_create_layer(-100, -100, "GameObjects", obj_Player);
		PL_PlayerPlayers++
		
		// Update TKS about the new player count here

		// Put this player into the data map, using the socket ID as the lookup
		ds_map_add(Clients, sock, inst);
	} else {
		// Client Disconnect - Lookup the player character, delete, and clear the socket
		var inst = ds_map_find_value(Clients, sock);
		ds_map_delete(Clients, sock);
		with(inst) { instance_destroy(); }
		PL_PlayerPlayers--
		
		var index = ds_list_find_index(SocketList, sock);
		ds_list_delete(SocketList, index);
		}
	if ConnectionMode = 3 { TKS_MatchmakingRequest(-1) } // Matchmaking Request Type: -1 Update the Server | 0/1 Host Clear Private/Public | 2/3 Online Private Host/Join | 4/5 Public Host/Join
}

function LAN_Broadcast_P2P_Server() {
	if LAN_BroadcastTimer != 0 { LAN_BroadcastTimer-- } else {
		LAN_BroadcastTimer = 120
		buffer_seek(Buffer_LAN_Broadcast,buffer_seek_start,0)
		buffer_write(Buffer_LAN_Broadcast,buffer_string,PL_PlayerID) // Add Name
		buffer_write(Buffer_LAN_Broadcast,buffer_s16,PL_PlayerPlayers) // Add Current Players
		buffer_write(Buffer_LAN_Broadcast,buffer_s16,PL_PlayerPlayersMax) // Add Max Players
		buffer_write(Buffer_LAN_Broadcast,buffer_string,PL_PlayerMap) // Add Map
		
		//for (var i = 0; i < 100; i++) {
			network_send_broadcast(P2P_Server, P2P_LAN_BroadcastListen_Port/*+i*/, Buffer_LAN_Broadcast, buffer_tell(Buffer_LAN_Broadcast));
			
			//show_message_async("Broadcast sent")
		//}
	}	
}

function P2P_Room_Goto(argument0) {
	var sc = ds_list_size(SocketList);
	for (var i = 0; i < sc; i++) {
		var sock = ds_list_find_value(SocketList,i);
		buffer_seek(Buffer_P2P_Play,buffer_seek_start,0)
		buffer_write(Buffer_P2P_Play,buffer_s16,P2P_ROOM_GOTO);
		buffer_write(Buffer_P2P_Play,buffer_s16,argument0);
		network_send_packet(sock,Buffer_P2P_Play,buffer_tell(Buffer_P2P_Play))
	}
	if ConnectionMode = 3 { TKS_MatchmakingRequest(-1) } // Matchmaking Request Type: -1 Update the Server | 0/1 Host Clear Private/Public | 2/3 Online Private Host/Join | 4/5 Public Host/Join
}

// Send the clients the details of the game objects
function SendDataToClientPlayers() {
	var sc = ds_list_size(SocketList);
	if sc > 0 {
		global.Buffer_P2P_Play = Buffer_P2P_Play
	    buffer_seek(Buffer_P2P_Play,buffer_seek_start,0)
		buffer_write(Buffer_P2P_Play,buffer_s16,P2P_SERVER_COMMAND);
	    // Total number of actors that will need drawing
		/* Gonna need to replace PL_PlayerPlayers with a count of all gameplay actors */
		var actors = instance_number(obj_Actor_Parent);
	    buffer_write(Buffer_P2P_Play,buffer_s16,actors)

		// Placehold the client camera's xy locations
		var ph1 = buffer_tell(global.Buffer_P2P_Play);
		buffer_write(global.Buffer_P2P_Play,buffer_s16,0)
		var ph2 = buffer_tell(global.Buffer_P2P_Play);
		buffer_write(global.Buffer_P2P_Play,buffer_s16,0)

	    // All game actors will have to write their data
		PackObjectSpritesForShipping(obj_Actor_Parent)
        
	    // Now pepper up them datasteaks for everyone
		var bs = buffer_tell(Buffer_P2P_Play);
	    for (var i = 0; i < sc; i++) {
	        var sock = ds_list_find_value(SocketList,i);
			// Write in client location
		    //buffer_seek(Buffer_P2P_Play, buffer_seek_start, 4);
		    var inst = ds_map_find_value(Clients, sock);
		    buffer_poke(global.Buffer_P2P_Play,ph1,buffer_s16,inst.x);
			buffer_poke(global.Buffer_P2P_Play,ph2,buffer_s16,inst.y);
			// Send that cow
	        network_send_packet(sock,Buffer_P2P_Play,bs)
	    }
	}
}

function PackObjectSpritesForShipping(argument0) {
	with(argument0) {
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,sprite_index);
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,image_index);
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,x);
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,y);
	        buffer_write(global.Buffer_P2P_Play,buffer_f16,image_xscale);
	        buffer_write(global.Buffer_P2P_Play,buffer_f16,image_yscale);
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,image_angle);
	        buffer_write(global.Buffer_P2P_Play,buffer_s16,image_blend);
	        buffer_write(global.Buffer_P2P_Play,buffer_f16,image_alpha);
	    }
}

// Read incoming data to the host from a client player
function P2P_ServerRecievedData() { 
	// get the buffer the data resides in
	var buff = ds_map_find_value(async_load, "buffer");
	var cmd = buffer_read(buff, buffer_s16);
	var sock = ds_map_find_value(async_load, "id");
	var inst = ds_map_find_value(Clients, sock);

	switch cmd {
		case P2P_PLAYER_COMMAND: // Read the input that was sent
		inst.PlayerName = buffer_read(buff, buffer_string); // Set the client player's name
		inst.VirDir = buffer_read(buff, buffer_f16);
		inst.HorDir = buffer_read(buff, buffer_f16);
		inst.MagDir = buffer_read(buff, buffer_f16);
		inst.Move_Direction = buffer_read(buff, buffer_s16);
		break;
	case PING_CMD: // Return a ping for latency testing
	
		break;
	}
}



