extends State
class_name PlayerFalling

@export var player : CharacterBody3D
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"
@export var fsm: FSM
@onready var check_floor: RayCast3D = $"../../TwistPivot/CheckFloor"

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
	
	if check_floor.is_colliding():
		anim["parameters/Falling/conditions/land"] = true
		Transitioned.emit(self, "Idle")
		
