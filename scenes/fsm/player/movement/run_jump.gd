extends State
class_name RunJump

@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

const JUMP_VELOCITY = 4.5
var timer: float = 0.0
var duration: float = 0.3

func Enter():
	print("Enter runJump")
	anim["parameters/conditions/locomotion"] = true
	anim["parameters/Locomotion/conditions/runjump"] = true
	player.velocity.y = JUMP_VELOCITY
	
func Exit():
	print("Exit RunJump")
	anim["parameters/conditions/locomotion"] = false
	anim["parameters/Locomotion/conditions/runjump"] = false
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	timer += delta
	if timer >= duration:
		if player.velocity.y != 0:
			timer = 0.0
			Transitioned.emit(self, "Falling")
			
