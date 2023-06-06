switch sprite_index {
	case plhd_enemy_despawn:
		Override_Animation = true
		StateMachine = State_Spawn
		StateMachine()
		
		RespawnTimer = 0
		Target = -1
		Angry = -1
		break;
	case plhd_enemy_spawn:
		StateMachine = State_Idle
		StateMachine()
		
		alarm[0] = 120
		break;
	case plhd_enemy_buff:
		Override_Animation = false
		StateMachine = State_Chase
		StateMachine()
		
		Angry = 300
		break;
	case plhd_enemy_attack:
		if Target = -1 {
			// Attack hit, despawn and go away
			Override_Animation = true
			StateMachine = State_Despawn
			StateMachine()
		} else {
			// Attack missed, go chase some more!
			Override_Animation = false
			StateMachine = State_Chase
			StateMachine()
		}
		break;
}