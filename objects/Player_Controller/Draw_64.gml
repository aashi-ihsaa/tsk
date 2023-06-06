draw_set_color(c_black)
draw_set_font(fnt_Mainlux_24)

/*
draw_text(x+10,y+0, string(array_length(Menu)))
draw_text(x+10,y+30, string(MenuSelection))
draw_text(x+10,y+60, string(Menu[MenuSelection]))
draw_text(x+10,y+90, MenuPlayerEmailInput)
draw_text(x+10,y+120, MenuPlayerPassInput)
draw_text(x+10,y+150, PlayerTextInput)
*/



switch MultiplayerMode { // 0 Singleplayer | 1 Host | 2 Client
	case 1: // Send things to clients
		draw_text(view_wport[0]-60,view_yport[0]+90,"Host")
		break;
	case 2: // Send things to the host
		draw_text(view_wport[0]-60,view_yport[0]+90,"Client")
		break;
}
SimpleMenuDraw()


	draw_text(x,y-20,LAN_BroadcastTimer)
