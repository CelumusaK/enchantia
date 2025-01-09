extends State
class_name PlayerPunch

@export var player : CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

@export var fsm: FSM

func Enter():
	print("Enter Hook")
	anim["parameters/conditions/attack"] = true
	anim["parameters/UnarmedAttack/conditions/widehook"] = true
	
func Exit():
	print("Exit Hook")
	anim["parameters/conditions/attack"] = false
	anim["parameters/UnarmedAttack/conditions/widehook"] = false
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	player.velocity = Vector3.ZERO
		
	if Input.get_vector("left", "right", "forward", "backwards") and not Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Walking")
		
	if Input.get_vector("left", "right", "forward", "backwards") and Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Running")
		
	if Input.get_vector("left", "right", "forward", "backwards") and Input.is_action_pressed("sprint") and not Input.is_action_pressed("run"):
		Transitioned.emit(self, "Sprint")
		
	if Input.is_action_just_pressed("crouch"):
		Transitioned.emit(self, "Crouch")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
		
