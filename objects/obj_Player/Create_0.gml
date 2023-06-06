/// @description  Initialise the Player

// Name
PlayerName = ""
MyPlayer = self

// Ovverides
Override_Menu          = false
Override_MovementInput = false
Override_Movement      = false
Override_AttackInput   = false
Override_Action        = false
Override_Animation = false

// Movement Initiations
InitPlayerInputIndexMK5()
PlayerInputIndexMK5()
InitMovementVariables()

// State Machinery
PlayerGameplayFunctions()
StateMachine = State_Spawn

FaceDirection = 0
IsMoving = false

// Speeds
Speed_Move    = 5
Speed_Walk    = 3
Speed_Run     = 5
Speed_Stairs  = 4
Speed_Crawl   = 3
Speed_BonkedGroundSlide = 1

// Basic Combat
CombatGCD    = 0
MeleeCD      = 0
RangedCD     = 0
DefensiveCD  = 0
// Bonkled
Targeted = false
TakeDamageCD = 0
BonkDirection = 0
BonkerID = noone

// Misc
RespawnTimer = 0

// Game Features
Coins = 0
