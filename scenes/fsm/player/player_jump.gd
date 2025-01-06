extends State
class_name PlayerJump

@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@export var player : CharacterBody3D

const JUMP_VELOCITY = 4.5
var timer: float = 0.0
var duration: float = 0.3

func Enter():
	animation_player.play("Jump")
	player.velocity.y = JUMP_VELOCITY
	
func Exit():
	pass
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	timer += delta
	if timer >= duration:
		if not player.is_on_floor():
			timer = 0.0
			Transitioned.emit(self, "Falling")
			
