/// @description More Game Handling



switch MultiplayerMode { // 0 Singleplayer | 1 Host | 2 Client
	case 1: // Send things to clients
		SendDataToClientPlayers()
		LAN_Broadcast_P2P_Server()
		break;
	case 2: // Send things to the host
		SendPlayerInputToHost()
		break;
}


// Camera Following
if MyPlayer != -1 {
	CamFollow = MyPlayer
	xTo = MyPlayer.x
	yTo = MyPlayer.y	
} else {
	CamFollow = noone
}

x += (xTo - x)/15
y += (yTo - y)/15

camera_set_view_pos(view_camera[0],floor(x-(CamWidth*0.5)),floor(y-(CamHeight*0.5)))

