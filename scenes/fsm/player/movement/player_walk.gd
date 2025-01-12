extends State
class_name PlayerWalk

@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var camera_3d: Camera3D = $"../../TwistPivot/PitchPivot/SpringArm3D/Camera3D"
@onready var skin: Node3D = $"../../YBot/Armature"
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"

var _delta: float
@export var timer: float = 0.0

@export var player : CharacterBody3D
var input_dir:= Vector2.ZERO
var SPEED = 3.0
var dir := Vector3.ZERO
var last_move_dir := Vector3.ZERO
var rotation_speed := 10.0

func Enter():
	print("Enter Walking")
	anim["parameters/conditions/locomotion"] = true
	anim["parameters/Locomotion/conditions/walk"] = true
	
func Exit():
	print("Exit Walking")
	anim["parameters/conditions/locomotion"] = false
	anim["parameters/Locomotion/conditions/walk"] = false
	
func Update(delta: float):
	#anim["parameters/Blend2/blend_amount"] = lerp(1, 0, 2 * _delta)
	
	_delta = delta
	var camera = camera_3d.global_basis
	input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (camera.x * input_dir.x + camera.z * input_dir.y)
	direction.y = 0.0
	direction = direction.normalized()
	dir = direction
	last_move_dir = -dir
	
	if last_move_dir != Vector3.ZERO:
		var target_rotation = atan2(-last_move_dir.x, -last_move_dir.z)  # Z-forward axis
		var current_rotation = skin.rotation.y
		skin.rotation.y = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)
	
func Physics_Update(delta: float):
	if dir != Vector3.ZERO and not Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		player.velocity.x = dir.x * SPEED
		player.velocity.z = dir.z * SPEED
		
	if dir != Vector3.ZERO and Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Running")
		
	if dir != Vector3.ZERO and Input.is_action_pressed("sprint") and not Input.is_action_pressed("run"):
		Transitioned.emit(self, "Sprint")
			
	if dir == Vector3.ZERO and not Input.get_vector("left", "right", "forward", "backwards") and not Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		Transitioned.emit(self, "Idle")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
		
	if player.velocity.y != 0:
			Transitioned.emit(self, "Falling")
			
	if !player.is_on_floor():
		Transitioned.emit(self, "Falling")
		
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
		if timer <= 0.1:
			Transitioned.emit(self, "combat/shortkick")
			timer = 0.0
			
		if timer <= 0.3:
			Transitioned.emit(self, "combat/widekick")
			timer = 0.0
		
