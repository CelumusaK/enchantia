extends State
class_name PlayerJump

@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

const JUMP_VELOCITY = 4.5
var timer: float = 0.0
var duration: float = 0.3

func Enter():
	player.velocity.y = JUMP_VELOCITY
	
func Exit():
	pass
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	timer += delta
	if timer >= duration:
		if player.velocity.y != 0:
			Transitioned.emit(self, "Falling")
			
