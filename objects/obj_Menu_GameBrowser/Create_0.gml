// Board Info
image_index = 0
image_speed = 0
image_xscale = 0.47
image_yscale = 0.67
DrawXoffset = x
DrawYoffset = y
TextDrawXoffset = x+12

// Paper Info
paper_image_xscale = 0.45
paper_image_yscale = 0.1
paper_DrawXoffset = x
paper_ListYStart = y-65
paper_TextDrawXoffset = x+40
paper_TextDrawYstart = y-72

ElListo = Player_Controller.MenuButtonList
ds_list_add(ElListo,id)

PanelText = ""

DefColor = #E4DAC9
HighColor = #70D651
DrawColor = DefColor

ListSize = 0
DisplayCount = 0 
ScrollPos = 0
SelectedEntry = -1
SelectedPlayer = -1

LAN_Broadcast_Listener(1)
//global.P2P_LAN_BroadcastListener = network_create_server(network_socket_udp, Player_Controller.P2P_LAN_BroadcastListen_Port, 100)
