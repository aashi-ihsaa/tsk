/// @description THE GAMEPLAY

// Respawn
Respawn(obj_Spawnpoint_Player)

// Stately Machinery!
if !Override_Animation { StateMachine() }
if TakeDamageCD > 0 { TakeDamageCD-- }


// Face Direction
if HorDir > 0 { image_xscale = abs(image_xscale) }
if HorDir < 0 { image_xscale = -abs(image_xscale) }




// REPLACE THIS


// COINS!
if place_meeting(x,y,obj_Coin) {
	var nc = instance_place(x,y,obj_Coin);
	Coins = nc.Value
	with nc { instance_destroy() }
}

// Stay out of the walls, dummy...
MoveOutOfTheWay(obj_Solid_Parent)
MoveOutOfTheWay(obj_Enemy)
MoveOutOfTheWay(obj_Player)