/// @Description  Load in saved input layout

x = 0
y = 0

// Online Functionality
GameVersion = "0.0.1"
ServerID = "ThievesKnight.com"
ServerID = "192.168.0.32"
P2P_HostID = ""
ConnectionMode  = 0 // 0 Offline | 1 Connected | 2 Attempting Login | 3 Fully Logged In
MultiplayerMode = 0 // 0 Singleplayer | 1 Host | 2 Client



TKSClientSocket = -1
P2P_ClientSocket = -1
P2P_Server = -1
P2P_Server_Port = 6511

global.P2P_LAN_BroadcastListener = -1
P2P_LAN_Broadcaster = -1
P2P_LAN_BroadcastListen_Port = 6510

LoginSaveEmail = ""
LoginSavePass = ""
PingTimer = 120

// Initialize Networking Commands
// Generic
#macro PING_CMD 0
#macro HANDSHAKE 1
#macro DISCONNECT_NOW 2
// Access to TKS Server
#macro ONLINE_ACCESS 3
#macro NEW_PLAYER 4
#macro NP_NAME_TAKEN 5
#macro NP_EMAIL_TAKEN 6
#macro PLAYER_LOGIN 7
#macro LOGIN_EMAIL_NOT_FOUND  8
#macro LOGIN_PASSWORD_INCORRECT 9
#macro LOGIN_SUCCESS 10
// Matchmaking Details
#macro MATCHMAKING_INFO 11
#macro MATCHMAKING_INFO_UPDATE 12
#macro MATCHMAKING_INFO_BROWSER 14
#macro MATCHMAKING_REQUEST 15
#macro MATCHMAKING_COMMAND 16
// P2P Play
#macro P2P_PLAYER_NAME 17
#macro P2P_ROOM_GOTO 18
#macro P2P_PLAYER_COMMAND 19
#macro P2P_SERVER_COMMAND 20

// Player info for server to know
// Player ID | OS Type | Matchmaking Type | Matching Password  | Sector ID | Gameplay Map | Pregame/Playing? | Player Count | Max Players
PL_PlayerID         = "Player"      // Player ID
PL_PlayerOS         = os_type // OS Type
PL_PlayerMatch      = -1      // Matchmaking Type: -1 Nothing | 0/1 Local Host/Join | 2/3 Online Private Host/Join | 4/5 Public Host/Join
PL_PlayerMatchPass  = ""      // Matching Password
PL_PlayerSector     = 0       // Sector ID
PL_PlayerMap        = 0       // Gameplay Map
PL_PlayerGameStart  = false   // False Pregame | True Playing Match
PL_PlayerPlayers    = 1       // Player Count
PL_PlayerPlayersMax = 4       // Max Player Limit

// Communication Buffers
//Buff = buffer_create(256, buffer_grow, 1)
Buffer_Ping = buffer_create(16, buffer_fixed, 1)
Buffer_Handshake = buffer_create(1024, buffer_fixed, 1)
Buffer_Login = buffer_create(16384, buffer_fixed, 1)
Buffer_MatchCommand = buffer_create(16384, buffer_fixed, 1)
Buffer_PlayerInfo = buffer_create(16384, buffer_fixed, 1)
Buffer_Host_and_Client = buffer_create(16384, buffer_fixed, 1)
Buffer_P2P_Play = buffer_create(16384, buffer_fixed, 1)
Buffer_LAN_Broadcast = buffer_create(16384, buffer_fixed, 1)

// Game Network Control (P2P Modes)
LAN_BroadcastTimer = 60
MyPlayer = -1
Clients = ds_map_create();
SocketList = ds_list_create();
AllSprites = ds_list_create();
DrawObjCount = 0
ds_map_clear(Clients)
ds_list_clear(SocketList)
ds_list_clear(AllSprites)

// Game Browser Data
GameBrowserList_Name = ds_list_create();
GameBrowserList_Players = ds_list_create();
GameBrowserList_MaxPlayers = ds_list_create();
GameBrowserList_Map = ds_list_create();
GameBrowserList_IP = ds_list_create();
ds_list_clear(GameBrowserList_Name)
ds_list_clear(GameBrowserList_Players)
ds_list_clear(GameBrowserList_MaxPlayers)
ds_list_clear(GameBrowserList_Map)
ds_list_clear(GameBrowserList_IP)

// Game Menus
SimpleMenuInit()
MenuState("Title")


// Game Control
InitPlayerInputIndexMK5()
PlayerInputIndexMK5()

// Camera
CamWidth = 640
CamHeight = 360
CamFollow = noone
xTo = x
yTo = y
surface_resize(application_surface,CamWidth+1,CamHeight+1)
application_surface_draw_enable(false)

// Gameplay Features
CoinSpawn_Timer = -1
CoinSpawn_Frequency = 600

// Spawn & Waypoints 
global.WaypointList = ds_list_create()
ds_list_clear(global.WaypointList)
global.PlayerSpawnList = ds_list_create()
ds_list_clear(global.PlayerSpawnList)
global.EnemySpawnList = ds_list_create()
ds_list_clear(global.EnemySpawnList)
global.CoinSpawnList = ds_list_create()
ds_list_clear(global.CoinSpawnList)