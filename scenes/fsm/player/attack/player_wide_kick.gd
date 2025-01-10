extends State
class_name PlayerWidekick
@onready var anim: AnimationTree = $"../../../YBot/AnimationTree"

var timer: float = 0.0
@export var player : CharacterBody3D
var time: float = 0.0

func Enter():
	anim["parameters/conditions/attack"] = true
	anim["parameters/UnarmedAttack/conditions/widekick"] = true
	
func Exit():
	anim["parameters/conditions/attack"] = false
	anim["parameters/UnarmedAttack/conditions/widekick"] = false
	timer = 0.0
	time = 0.0
	
func Update(delta: float):
	time += delta
	
func Physics_Update(delta: float):
	player.velocity = Vector3.ZERO
	
	if time >= 2:
		Transitioned.emit(self, "Idle")
		time = 0.0
		
	if Input.is_action_just_pressed("crouch"):
		Transitioned.emit(self, "Crouch")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
		
	if Input.is_action_pressed("punch attack") or Input.is_action_pressed("kick attack"):
		timer += delta
		print(timer)
		
	if Input.is_action_just_released("punch attack"):
		if timer <= 0.2:
			Transitioned.emit(self, "combat/punch")
			timer = 0.0
			
		if timer <= 0.4:
			Transitioned.emit(self, "combat/widehook")
			timer = 0.0
			
		if timer > 0.4:
			Transitioned.emit(self, "combat/heavypunch")
			
		
	if Input.is_action_just_released("kick attack"):
		if timer <= 0.9:
			Transitioned.emit(self, "combat/shortkick")
			timer = 0.0
