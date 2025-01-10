extends State
class_name PlayerDeath
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

func Enter():
	anim["parameters/conditions/death"] = true
	
func Exit():
	anim["parameters/conditions/death"] = false
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	pass
