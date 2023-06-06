
//buffer_delete(Buff)
buffer_delete(Buffer_Ping)
buffer_delete(Buffer_Handshake)
buffer_delete(Buffer_Login)
buffer_delete(Buffer_MatchCommand)
buffer_delete(Buffer_PlayerInfo)
buffer_delete(Buffer_Host_and_Client)
buffer_delete(Buffer_P2P_Play)
buffer_delete(Buffer_LAN_Broadcast)

ds_list_destroy(MenuButtonList)

ds_list_destroy(AllSprites)
ds_list_destroy(Clients)
ds_list_destroy(SocketList)

// Game Browser Data
ds_list_destroy(GameBrowserList_Name)
ds_list_destroy(GameBrowserList_Players)
ds_list_destroy(GameBrowserList_MaxPlayers)
ds_list_destroy(GameBrowserList_Map)
ds_list_destroy(GameBrowserList_IP)

mp_grid_destroy(global.UltraGrid)
ds_list_destroy(global.WaypointList)

ds_list_destroy(global.PlayerSpawnList)
ds_list_destroy(global.EnemySpawnList)
ds_list_destroy(global.CoinSpawnList)