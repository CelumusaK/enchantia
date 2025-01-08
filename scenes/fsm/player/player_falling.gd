extends State
class_name PlayerFalling

@export var player : CharacterBody3D
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"
@export var fsm: FSM

func Enter():
	print("Enter Falling")
	anim["parameters/conditions/fall"] = true
	
func Exit():
	print("Exit Falling")
	anim["parameters/conditions/fall"] = false
	anim["parameters/Falling/conditions/land"] = false
	
func Update(delta: float):
	player.velocity += player.get_gravity() * delta
	
func Physics_Update(delta: float):
	
	if player.velocity.y == 0:
		anim["parameters/Falling/conditions/land"] = true
		Transitioned.emit(self, "Idle")
		
		
