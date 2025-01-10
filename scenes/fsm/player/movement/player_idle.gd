extends State
class_name PlayerIdle

@export var player : CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

@export var fsm: FSM
@export var timer: float = 0.0
@export var player_stats: Resource

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
	if player_stats.is_dead:
		Transitioned.emit(self, "death")
	
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
		
	if Input.is_action_pressed("punch attack") or Input.is_action_pressed("kick attack"):
		timer += delta
		print(timer)
		
	if Input.is_action_just_released("punch attack"):
		if timer <= 0.1:
			Transitioned.emit(self, "combat/punch")
			timer = 0.0
			
		if timer <= 0.3:
			Transitioned.emit(self, "combat/widehook")
			timer = 0.0
			
		if timer > 0.4:
			Transitioned.emit(self, "combat/heavypunch")
			timer = 0.0
		
	if Input.is_action_just_released("kick attack"):
		if timer <= 0.3:
			Transitioned.emit(self, "combat/shortkick")
			timer = 0.0
			
		if timer > 0.3:
			Transitioned.emit(self, "combat/widekick")
			timer = 0.0
		
