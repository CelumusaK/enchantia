extends State
class_name PlayerJump

@export var player : CharacterBody3D
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"
@onready var check_floor: RayCast3D = $"../../TwistPivot/CheckFloor"

const JUMP_VELOCITY = 4.5
var timer: float = 0.0
var duration: float = 0.3

func Enter():
	print("Enter Jump")
	anim["parameters/conditions/locomotion"] = true
	anim["parameters/Locomotion/conditions/jump"] = true
	
	player.velocity.y = JUMP_VELOCITY
	
func Exit():
	print("Exit Jump")
	anim["parameters/conditions/locomotion"] = false
	anim["parameters/Locomotion/conditions/jump"] = false
	
func Update(delta: float):
	timer += delta
	
func Physics_Update(delta: float):
	if !check_floor.is_colliding() and !player.is_on_ceiling_only():
		Transitioned.emit(self, "Falling")
			
