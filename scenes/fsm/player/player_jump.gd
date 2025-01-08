extends State
class_name PlayerJump

@export var player : CharacterBody3D
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

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
	if timer >= duration:
		if player.velocity.y != 0:
			Transitioned.emit(self, "Falling")
			
