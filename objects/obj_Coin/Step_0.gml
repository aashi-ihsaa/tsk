MoveOutOfTheWay(obj_Enemy)

if place_meeting(x,y,obj_Enemy) {
	if place_meeting(x,y,obj_Coin) {
		with instance_place(x,y,obj_Coin) {
			MoveOutOfTheWay(obj_Coin)
		}
	}
}

MoveOutOfTheWay(obj_Coin)
if alarm[0] < (room_speed * 25)/5 {
	if (alarm[0] mod 10 < 5) {
			image_alpha += 0.2
		} else {
			image_alpha -= 0.2
		}
}