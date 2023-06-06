function InitMovementVariables() {
HorDir = 0
VirDir = 0
MagDir = clamp(point_distance(0,0,HorDir,VirDir),0,1);
Move_Direction = 0
}

/// Perfect Pixel Move
/// @desc	Move perfectly in a direction without intersecting wall objects.
/// @arg Speed		= How fast to move.
/// @arg Direction	= Which direction to move.
function PerfectPixelMove(argument0,argument1) {
	// X
	var LDX = lengthdir_x(argument0,argument1);
	for (var i = 0; i < 1; i++) {
		if LDX > 0 { if !place_meeting(x+1,y,obj_Solid_Parent) { x++ } }
		if LDX < 0 { if !place_meeting(x-1,y,obj_Solid_Parent) { x-- } }
	}
	// Y
	var LDY = lengthdir_y(argument0,argument1);
	for (var i = 0; i < 1; i++) {
		if LDY > 0 { if !place_meeting(x,y+1,obj_Solid_Parent) { y++ } }
		if LDY < 0 { if !place_meeting(x,y-1,obj_Solid_Parent) { y-- } }
	}
}


// Allows an object to be pushed around by other objects
function MoveOutOfTheWay(argument0) {
	if place_meeting(x,y,argument0) {
		var oe = instance_place(x,y,argument0);
		//Move_Direction = point_direction(oe.x,oe.y,x,y)
		var PushDir = point_direction(oe.x,oe.y,x,y)
		var lastX = x;
		var lastY = y;
		
		var whilebreak = 0;
		while place_meeting(x,y,oe) {
			//move_and_collide(lengthdir_x(1,Move_Direction),lengthdir_y(1,Move_Direction),all)
			
			//*
			// X
			var LDX = abs(lengthdir_x(1,PushDir));
			for (var i = 0; i < LDX; i++) {
				if oe.x < x { if !place_meeting(x+1,y,obj_Solid_Parent) { x++ } }
				if oe.x > x { if !place_meeting(x-1,y,obj_Solid_Parent) { x-- } }
			}
			// Y
			var LDY = abs(lengthdir_y(1,PushDir));
			for (var i = 0; i < LDY; i++) {
				if oe.y < y { if !place_meeting(x,y+1,obj_Solid_Parent) { y++ } }
				if oe.y > y { if !place_meeting(x,y-1,obj_Solid_Parent) { y-- } }
			}//*/
			
			
			whilebreak++
			if whilebreak > 100 {
				break;
			if x = lastX {
				if !place_meeting(x+1,y,obj_Solid_Parent) { x++ } else
				if !place_meeting(x-1,y,obj_Solid_Parent) { x-- }
				lastX = x
				}
			if y = lastY {
				if !place_meeting(x,y+1,obj_Solid_Parent) { y++ } else
				if !place_meeting(x,y-1,obj_Solid_Parent) { y-- }
				lastY = y
				}
				
			}
		}	
	}
}
