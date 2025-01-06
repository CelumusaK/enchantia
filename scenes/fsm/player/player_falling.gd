extends State
class_name PlayerFalling

@export var player : CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"

func Enter():
	animation_player.play("Falling")
	
func Exit():
	pass
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	if player.is_on_floor():
		Transitioned.emit(self, "Idle")
