/// @description THE AI

// Respawn
Respawn(obj_Spawnpoint_Enemy)


// Attack Cooldown
if MeleeCD > 0 { MeleeCD-- }


// State Machine Time
if !Override_Animation { StateMachine() }


// Facing Direction for 1 direction sprites
if PrevX > x { image_xscale = -abs(image_xscale) }
if PrevX < x { image_xscale = abs(image_xscale) }
PrevX = x
PrevY = y

// Looking Direction
if Target = -1 { SightDirectionTarget = point_direction(x, y, Waypoint.x, Waypoint.y) }
else { SightDirectionTarget = point_direction(x, y, TargetX, TargetY) }
var DirDif = angle_difference(SightDirectionTarget , SightDirectionCurrent);
SightDirectionCurrent += min(abs(DirDif), 4) * sign(DirDif);

// Stay out of the walls, dummy...
if place_meeting(x,y,obj_Player) {
	path_end()
	MoveOutOfTheWay(obj_Solid_Parent)
}
MoveOutOfTheWay(obj_Enemy)
if place_meeting(x,y,obj_Player) {
	path_end()
	MoveOutOfTheWay(obj_Player)
}

if keyboard_check_pressed(vk_alt) {ChooseWaypoint()}