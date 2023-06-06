

// Spawn an attack hitbox for the hit frames
if sprite_index = plhd_enemy_attack {
		if image_index > 4 && image_index < 6 && MeleeCD = 0 {
			var atk = instance_create_layer(x,y,"GameObjects", obj_Enemy_Attack);
			MeleeCD = MeleeCDReset
			atk.image_angle = point_direction(x,y,TargetX,TargetY)
			
			
			
		}
}

if Target != -1 {
	if Target.TakeDamageCD > 0 {
		with Target { Targeted = false }
		Target = -1
		Angry = -1
	}
}