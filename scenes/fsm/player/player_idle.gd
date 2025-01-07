extends State
class_name PlayerIdle

@export var player : CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

@export var fsm: FSM

func Enter():
	print("Enter Idle")
	if fsm.old_state != fsm.states.get("CrouchWalk".to_lower()):
		anim["parameters/CrouchIdle/conditions/tostand"] = false
			
	player.velocity = Vector3.ZERO
	anim["parameters/conditions/idle"] = true
	
func Exit():
	print("Exit Idle")
	anim["parameters/conditions/idle"] = false
	
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
		
