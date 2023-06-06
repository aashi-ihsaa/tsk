// Ganeplay functions and stuff

// Respawn
function Respawn(argument0) {
	if RespawnTimer > 0 { RespawnTimer-- }
	if RespawnTimer = 0 && object_exists(argument0) {
		RespawnTimer--
		var spawn_number;
		var spawn_loc;
		var spawnx;
		var spawny;
		var nearest_random_spawner;
		var found_it = false;
		spawn_number = round(random(instance_number(argument0)));
		    while found_it = false {
		        spawnx = random(room_width-448);
		        spawny = random(room_height-448);
		        nearest_random_spawner = instance_nearest(spawnx+224,spawny+224,argument0);
		        if nearest_random_spawner.SpawnActive = 0 && nearest_random_spawner.SpawnAreaClear = true {
		            found_it = true
		            spawn_loc = nearest_random_spawner;
					SpawnActive = 600
		        }
		    }
		x = spawn_loc.x
		y = spawn_loc.y
	}
}

// COINS!
function CoinSpawn() {
	if CoinSpawn_Timer > 0 { CoinSpawn_Timer-- }
	if CoinSpawn_Timer = 0 {
		CoinSpawn_Timer = 300+round(random(300))
		if instance_number(obj_Coin) < 12 {
			var spl = ds_list_create();
			ds_list_clear(spl)
			for (var i = 0; i < ds_list_size(global.CoinSpawnList); i++) {
			    var sp = global.CoinSpawnList[| i];
				if sp.SpawnActive = 0 && sp.SpawnAreaClear = true {
					with sp { ds_list_add(spl,id) }
				}
			}
			ds_list_shuffle(spl)
			for (var i = 0; i < 2; i++) {
			var sploc = ds_list_find_value(spl,i)
				for (var i = 0; i < choose(2,3); i++) {
					var rxo = random(32);
					var ryo = random(32);
					rxo -= 16
					ryo -= 16
					var spc = instance_create_layer(sploc.x+rxo,sploc.y+ryo,"GameObjects",obj_Coin)
					spc.Value = choose(1,1,1,1,1,2,2,3)
					spc.image_index = spc.Value-1
				}
			}
			ds_list_destroy(spl)
			/*
			var spawn_number;
			var spawn_loc;
			var spawnx;
			var spawny;
			var nearest_random_spawner;
			var found_it = false;
			spawn_number = round(random(instance_number(obj_Spawnpoint_Coins)));
			    while found_it = false {
			        spawnx = random(room_width-448);
			        spawny = random(room_height-448);
			        nearest_random_spawner = instance_nearest(spawnx+224,spawny+224,obj_Spawnpoint_Coins);
			        if nearest_random_spawner.SpawnActive = 0 && nearest_random_spawner.SpawnAreaClear = true {
			            found_it = true
			            spawn_loc = nearest_random_spawner;
						SpawnActive = 600
			        }
			    }
			x = spawn_loc.x
			y = spawn_loc.y
			
			instance_create_layer(spawn_loc.x+16,spawn_loc.y,"GameObjects",obj_Coin)
			instance_create_layer(spawn_loc.x-16,spawn_loc.y,"GameObjects",obj_Coin)
			instance_create_layer(spawn_loc.x,spawn_loc.y+16,"GameObjects",obj_Coin)
			instance_create_layer(spawn_loc.x,spawn_loc.y-16,"GameObjects",obj_Coin)
			*/
		}
	}
}
