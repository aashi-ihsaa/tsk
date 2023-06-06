/// @description Check for clearances
if distance_to_object(obj_Actor_Parent) < 64 { SpawnAreaClear = false } else { SpawnAreaClear = true }
if SpawnActive > 0 { SpawnActive-- }