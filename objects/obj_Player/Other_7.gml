switch sprite_index {
	case plhd_player_spawn:
		Override_Animation = false
		StateMachine = State_Playable
		StateMachine()
		break;
	case plhd_player_hit:
		image_index = -1
		image_speed = 0
		break;
}