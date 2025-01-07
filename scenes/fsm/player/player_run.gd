extends State
class_name PlayerRun

@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var camera_3d: Camera3D = $"../../TwistPivot/PitchPivot/SpringArm3D/Camera3D"
@onready var skin: Node3D = $"../../YBot/Armature"
@onready var anim: AnimationTree = $"../../YBot/AnimationTree"
@onready var check_floor: RayCast3D = $"../../TwistPivot/CheckFloor"

@export var player : CharacterBody3D
var input_dir:= Vector2.ZERO
var SPEED = 10.0
var dir := Vector3.ZERO
var last_move_dir := Vector3.ZERO
var rotation_speed := 10.0
var _delta: float

func Enter():
	anim["parameters/conditions/locomotion"] = true
	anim["parameters/Locomotion/conditions/run"] = true
	
func Exit():
	anim["parameters/conditions/locomotion"] = false
	anim["parameters/Locomotion/conditions/run"] = false
	
func Update(delta: float):
	_delta = delta
	var camera = camera_3d.global_basis
	input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (camera.x * input_dir.x + camera.z * input_dir.y)
	direction.y = 0.0
	direction = direction.normalized()
	dir = direction
	
	if direction.length() > 0.2:
		last_move_dir = direction
	var target_angle := Vector3.BACK.signed_angle_to(last_move_dir, Vector3.UP)
	
	skin.global_rotation.y = lerp(skin.global_rotation.y, target_angle, rotation_speed * delta)
	
func Physics_Update(delta: float):
	if Input.is_action_pressed("run"):
		player.velocity.x = dir.x * SPEED
		player.velocity.z = dir.z * SPEED
		
	if not Input.is_action_pressed("run") and player.velocity != Vector3.ZERO and not Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Walking")
		
	if not Input.is_action_pressed("run") and player.velocity != Vector3.ZERO and Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Sprint")
			
	if player.velocity == Vector3.ZERO and not Input.get_vector("left", "right", "forward", "backwards") and not Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		Transitioned.emit(self, "Idle")
	
	if player.velocity != Vector3.ZERO and not Input.get_vector("left", "right", "forward", "backwards") and not Input.is_action_pressed("run") and not Input.is_action_pressed("sprint"):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		Transitioned.emit(self, "Idle")
	
	if player.velocity == Vector3.ZERO:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		Transitioned.emit(self, "Idle")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "RunJump")
		
	if !check_floor.is_colliding() and !player.is_on_ceiling_only():
			Transitioned.emit(self, "Falling")
