extends State
class_name PlayerIdle

@export var player : CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"

func Enter():
	animation_player.play("Idle")
	
func Exit():
	pass
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	if player.velocity != Vector3.ZERO:
		Transitioned.emit(self, "Walking")
		
	if Input.is_action_just_pressed("backwards") or Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") and not Input.is_action_pressed("run"):
		Transitioned.emit(self, "Walking")
		
	if Input.is_action_just_pressed("backwards") or Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") and Input.is_action_pressed("run"):
		Transitioned.emit(self, "Running")
		
	if Input.is_action_just_pressed("crouch"):
		Transitioned.emit(self, "Crouch")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
