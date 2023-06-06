
if Angry < 1 {
	ChooseWaypoint() 
} else {
	ChaseUpdateTimer = ChaseUpdateTimerReset
	path_delete(UltraPath)
	UltraPath = path_add()
	mp_grid_path(global.UltraGrid,UltraPath,x,y,Target.x,Target.y,true)
	path_start(UltraPath,Speed_Run,path_action_stop,true)
}