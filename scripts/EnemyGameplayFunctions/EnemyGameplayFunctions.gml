
// For enemies to find a new place to roam to.
function ChooseWaypoint() {
	var near_cardinal_waypoints = ds_list_create();
	var wpl = ds_list_create();
	var tolerance = 16;
	
	// Iterate through the list of waypoints and add only pathable ones to the list of potential canidates
	for (var i = 0; i < ds_list_size(global.WaypointList); i++) {
	    var wp = global.WaypointList[| i];
		ds_list_clear(wpl)
	    if (
			(abs(wp.x - Waypoint.x) <= tolerance ^^ abs(wp.y - Waypoint.y) <= tolerance) && !collision_line(x,y,wp.x,wp.y,obj_Solid_Parent,true,true)
				&&
			point_direction(Waypoint.x,Waypoint.y,wp.x,wp.y) != point_direction(Waypoint.x,Waypoint.y,PreviousWaypoint.x,PreviousWaypoint.y)
		) {
			var n = collision_line_list(x,y,wp.x,wp.y,obj_Waypoint,false,true,wpl,false);
			if n < 3 {
				ds_list_add(near_cardinal_waypoints, wp);
			}
	    }
	}

	if (ds_list_size(near_cardinal_waypoints) > 0) {
		// First make the waypoint being stood on the previous one, so he doesn't come back
		PreviousWaypoint = Waypoint
		// Then set the new waypoint to the next path and clean up the data
	    Waypoint = near_cardinal_waypoints[| irandom_range(0, ds_list_size(near_cardinal_waypoints) - 1)];
		debug_draw_color = c_blue
	} else {
		// No new paths, try going back. This will prevent getting stuck in dead ends
		ds_list_clear(wpl)
		if abs(point_direction(x,y,PreviousWaypoint.x,PreviousWaypoint.y)/90) < 4 && !collision_line(x,y,wp.x,wp.y,obj_Solid_Parent,true,true) {
			Waypoint = PreviousWaypoint
			debug_draw_color = c_green
		} else {
			// No obviosly followable waypoint, so pick the nearest visible one
			for (var i = 0; i < ds_list_size(global.WaypointList); i++) {
			    wp = global.WaypointList[| i];
			    if !collision_line(x,y,wp.x,wp.y,obj_Solid_Parent,true,true) {
					var n = collision_line_list(x,y,wp.x,wp.y,obj_Waypoint,false,true,wpl,false);
					if n < 3 {
						ds_list_add(near_cardinal_waypoints, wp)
					}
			    }
			}
			// Then set the new waypoint to the next path and clean up the data
		    Waypoint = near_cardinal_waypoints[| irandom_range(0, ds_list_size(near_cardinal_waypoints) - 1)];
			debug_draw_color = c_yellow
		}
	}
	PerfectPixelMove(Speed_Move, SightDirectionCurrent)
	
	// Finally clean up them memory suckling data structures
	ds_list_destroy(near_cardinal_waypoints);
	ds_list_destroy(wpl)
	
}


/// Ultrapath MkII
/// @desc	Use the UltraPath grid to move towards a target.
/// @arg Target X
/// @arg Target Y
function UltraPath_MKI(tX,Ty) {
	// Clear and create new path
	path_delete(UltraPath)
	UltraPath = path_add()
	mp_grid_path(global.UltraGrid,UltraPath,x,y,Waypoint.x,Waypoint.y,false)
	path_start(UltraPath,Speed_Walk,path_action_stop,true)
}
	
// Watch for dirty thieves! Always
function WatchForThieves() {
	var np = instance_nearest(x,y,obj_Player);
	if point_distance(x,y,np.x,np.y) < SightRange && !collision_line(x,y,np.x,np.y,obj_Solid_Parent,false,true) {
		if abs(angle_difference(SightDirectionCurrent,point_direction(x,y,np.x,np.y))) < SightCone/2 || point_distance(x,y,np.x,np.y) < 32 {
			// If a farther away player is the target, untarget them
			if Target != -1 { Target.Targeted = false }
			// Set the new target
			Target = np
			Target.Targeted = true
			if Angry = -1 { StateMachine = State_MarkPlayerForDoom }
			Angry = 300
		}
	}	
}
	
// State Machinery

// Spawn State + Animation
State_Despawn = function() {
	Override_Animation = true
	sprite_index = plhd_enemy_despawn
	image_index = 0
	image_speed = 1
}

// Spawn State + Animation
State_Spawn = function() {
	Override_Animation = true
	sprite_index = plhd_enemy_spawn
	image_index = 0
	image_speed = 1
}

// Idle - Waiting
State_Idle = function() {
	Override_Animation = false
	sprite_index = plhd_enemy_idle
	image_speed = 0.3
	
}

// Patrolling from waypoint to waypoint around the map
State_Patrol = function() {
	Override_Animation = false
	sprite_index = plhd_enemy_run
	image_speed = 0.6
	
	TargetX = Waypoint.x
	TargetY = Waypoint.y
	Speed_Move = Speed_Walk
	
	WatchForThieves()
	PerfectPixelMove(Speed_Move, SightDirectionCurrent)
	
	if distance_to_point(Waypoint.x,Waypoint.y) < 1 { ChooseWaypoint() }
}

// Do the angry animation to mark the player before chasing them
State_MarkPlayerForDoom = function() {
	Override_Animation = true
	sprite_index = plhd_enemy_buff
	image_index = 0
	image_speed = 1
	
	path_end()
}

// Chasing the nearest player
State_Chase = function() {
	WatchForThieves()
	Speed_Move = Speed_Run
	
	// Maintain anger and focus
	sprite_index = plhd_enemy_run
	if !collision_line(x,y,Target.x,Target.y,obj_Solid_Parent,false,true) && distance_to_point(Target.x,Target.y){
		TargetX = Target.x
		TargetY = Target.y
		Angry = 300
	} else {
		Angry--	
	}
	
	// UltraPath to the Player
	if distance_to_object(Target) > 5 {
		//PerfectPixelMove(Speed_Move, SightDirectionCurrent)
		mp_potential_step_object(TargetX,TargetY,Speed_Move,obj_Solid_Parent)
	}
	
	// Murdalate the dirty thief
	if !collision_line(x,y,Target.x,Target.y,obj_Solid_Parent,false,true) && distance_to_object(Target) < MeleeRange && MeleeCD = 0 {
		StateMachine = State_Attacking
		StateMachine()
		exit;
	}
	
	// End the chase.. Target escaped :c -  Find a waypoint to navigate to
	if Angry = 0 {
		Target.Targeted = false
		Target = -1
		Angry--
		ChooseWaypoint()
		StateMachine = State_Patrol
	}
}

// Attacking the player!
State_Attacking = function() {
	Override_Animation = true
	sprite_index = plhd_enemy_attack
	image_index = 0
	image_speed = 1.5
	path_end()
	
}

// Drawing that silly sight cone
function DrawSightCone() {
	// Sight Cone!

	// Left cone line
		var rf1 = instance_create_layer(x,y,"GameObjects",obj_Range_Finder);
		with rf1 { move_contact_solid(other.SightDirectionCurrent + other.SightCone / 2, other.SightRange) }
		var rf2 = instance_create_layer(x,y,"GameObjects",obj_Range_Finder);
		with rf2 { move_contact_solid(other.SightDirectionCurrent + other.SightCone / 4, other.SightRange) }
		//var coneLlength = distance_to_point(rf1.x,rf1.y);
	
	// Center cone line
		var rf3 = instance_create_layer(x,y,"GameObjects",obj_Range_Finder);
		with rf3 { move_contact_solid(other.SightDirectionCurrent, other.SightRange) }
		//var coneClength = distance_to_point(rf2.x,rf2.y);
	
	// Right cone line
		var rf4 = instance_create_layer(x,y,"GameObjects",obj_Range_Finder);
		with rf4 { move_contact_solid(other.SightDirectionCurrent - other.SightCone / 4, other.SightRange) }
		var rf5 = instance_create_layer(x,y,"GameObjects",obj_Range_Finder);
		with rf5 { move_contact_solid(other.SightDirectionCurrent - other.SightCone / 2, other.SightRange) }
		//var coneRlength = distance_to_point(rf3.x,rf3.y);


	if Target = -1 { draw_set_color(c_white) } else { draw_set_color(c_red) }
	//draw_line(x, y, x + lengthdir_x(coneClength, SightDirectionCurrent), y + lengthdir_y(coneClength, SightDirectionCurrent));
	//draw_line(x, y, x + lengthdir_x(coneLlength, SightDirectionCurrent + SightCone / 2), y + lengthdir_y(coneLlength, SightDirectionCurrent + SightCone / 2))
	//draw_line(x, y, x + lengthdir_x(coneRlength, SightDirectionCurrent - SightCone / 2), y + lengthdir_y(coneRlength, SightDirectionCurrent - SightCone / 2))
	draw_line(x,y,rf1.x,rf1.y)
	//draw_line(x,y,rf2.x,rf2.y)
	draw_line(x,y,rf5.x,rf5.y)
	draw_line(rf1.x,rf1.y,rf2.x,rf2.y)
	draw_line(rf2.x,rf2.y,rf3.x,rf3.y)
	draw_line(rf3.x,rf3.y,rf4.x,rf4.y)
	draw_line(rf4.x,rf4.y,rf5.x,rf5.y)
	
	// Clean up the rangefinders
	
	with rf1 { instance_destroy() }
	with rf2 { instance_destroy() }
	with rf3 { instance_destroy() }
	with rf4 { instance_destroy() }
	with rf5 { instance_destroy() }
	
}