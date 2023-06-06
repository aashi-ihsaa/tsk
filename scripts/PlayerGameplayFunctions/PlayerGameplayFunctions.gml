// State Machinery

// Spawn State + Animation
State_Spawn = function() {
	Override_Animation = true
	sprite_index = plhd_player_spawn
	image_index = 0
	image_speed = 1
}

// Playable
State_Playable = function() {
	
	// Move Speed States
	if place_meeting(x,y,obj_Altitude_Stairs) { Speed_Move = Speed_Stairs } else { Speed_Move = Speed_Run }
	
	
	if place_meeting(x,y,obj_Enemy_Attack) {
		StateMachine = State_KnockedDown
		TakeDamageCD = 180
		BonkerID = instance_nearest(x,y,obj_Enemy_Attack)
		StateMachine()
		exit;
	}

	// Movement
	// X
	var LDX = lengthdir_x(Speed_Move*MagDir,Move_Direction);
	for (var i = 0; i < abs(LDX); i++) {
		if HorDir > 0 { if !place_meeting(x+1,y,obj_Solid_Parent) { x++ } }
		if HorDir < 0 { if !place_meeting(x-1,y,obj_Solid_Parent) { x-- } }
	}
	// Y
	var LDY = lengthdir_y(Speed_Move*MagDir,Move_Direction);
	for (var i = 0; i < abs(LDY); i++) {
		if VirDir > 0 { if !place_meeting(x,y+1,obj_Solid_Parent) { y++ } }
		if VirDir < 0 { if !place_meeting(x,y-1,obj_Solid_Parent) { y-- } }
	}
	// Is Moving?
	if HorDir != 0 || VirDir != 0 { IsMoving = true } else { IsMoving = false }
	
	// Choose the moving sprite
	if IsMoving = true {
		sprite_index = plhd_player_run
		image_speed = Speed_Move/6
	} else {
		sprite_index = plhd_player_idle
	}
	
}

// Jumping
State_Jumping = function() {
	
	Override_Animation = true
}
// Knocked Down
State_KnockedDown = function() {
	sprite_index = plhd_player_hit
	image_speed = 1
	
	var dmsld = TakeDamageCD/200;
	dmsld = clamp(dmsld,0,1)
	
	if BonkerID != noone { 
		BonkDirection = point_direction(BonkerID.x,BonkerID.y,x,y) 
		with BonkerID { instance_destroy() }
		BonkerID = noone
	}
	
	// Movement
	// X
	var LDX = lengthdir_x(dmsld*Speed_BonkedGroundSlide,BonkDirection);
	for (var i = 0; i < abs(LDX); i++) {
		if LDX > 0 { if !place_meeting(x+1,y,obj_Solid_Parent) { x++ } }
		if LDX < 0 { if !place_meeting(x-1,y,obj_Solid_Parent) { x-- } }
	}
	// Y
	var LDY = lengthdir_y(dmsld*Speed_BonkedGroundSlide,BonkDirection);
	for (var i = 0; i < abs(LDY); i++) {
		if LDY > 0 { if !place_meeting(x,y+1,obj_Solid_Parent) { y++ } }
		if LDY < 0 { if !place_meeting(x,y-1,obj_Solid_Parent) { y-- } }
	}
	
	// End the knockdown
	if TakeDamageCD = 0 {
		StateMachine = State_Playable
		StateMachine()
	}
}

// Recovering
State_Recovering = function() {
	
}