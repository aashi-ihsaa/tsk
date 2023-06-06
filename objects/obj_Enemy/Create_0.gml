/// @description  Initialise the Enemy

// Ovverides
Override_Menu          = false
Override_MovementInput = false
Override_Movement      = false
Override_AttackInput   = false
Override_Action        = false
Override_Animation     = false

// Basic Movements
InitMovementVariables()
// State Machinery
EnemyGameplayFunctions()
PrevX = x
PrevY = y

StateMachine = State_Spawn

FaceDirection = 0

// Speeds
Speed_Move    = 3
Speed_Walk    = 1
Speed_Run     = 2
Speed_Crawl   = 4

// Basic Combat
MeleeRange = 16
MeleeCD    = 0
MeleeCDReset = 30

// Misc
RespawnTimer = 0
image_speed = 0.2
debug_draw_color = c_white

// Enemy AI
PreviousWaypoint = id
Waypoint = id
UltraPath = path_add()
ChaseUpdateTimerReset = 30
ChaseUpdateTimer = 0
// Vision
SightDirectionCurrent = 0
SightDirectionTarget = 0
SightRange = 256
SightCone = 60
// Target
Target = -1
TargetX = 0
TargetY = 0
Angry = -1
