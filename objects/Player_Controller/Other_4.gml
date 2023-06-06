/// @description Init the room


// Move Players to a spawnpoint
with obj_Player { RespawnTimer = 0 }


// Set up the pathing grid
	var ugs = 1;
	global.UltraGrid = mp_grid_create(192,192,(room_width)/ugs,(room_height)/ugs,ugs,ugs)
	if object_exists(obj_Solid_Parent) { mp_grid_add_instances(global.UltraGrid, obj_Solid_Parent, 0) }

	// Freshen up the list of spwan and nav waypoints
	ds_list_clear(global.WaypointList);
	with obj_Waypoint { ds_list_add(global.WaypointList,id) }

	ds_list_clear(global.PlayerSpawnList);
	with obj_Spawnpoint_Player { ds_list_add(global.PlayerSpawnList,id) }
	ds_list_clear(global.EnemySpawnList);
	with obj_Spawnpoint_Enemy { ds_list_add(global.EnemySpawnList,id) }
	ds_list_clear(global.CoinSpawnList);
	with obj_Spawnpoint_Coins { ds_list_add(global.CoinSpawnList,id) }
