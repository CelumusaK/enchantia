extends State
class_name PlayerCrouch

@onready var standing: CollisionShape3D = $"../../Standing"
@onready var crouching: CollisionShape3D = $"../../Crouching"
@onready var camera_3d: Camera3D = $"../../TwistPivot/PitchPivot/SpringArm3D/Camera3D"
@onready var skin: Node3D = $"../../YBot/Armature"
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"
@onready var crouch_check: RayCast3D = $"../../CrouchCheck"

@export var player : CharacterBody3D
var input_dir:= Vector2.ZERO
var SPEED = 5.0
var dir := Vector3.ZERO
var last_move_dir := Vector3.ZERO
var rotation_speed := 10.0

func Enter():
	animation_player.play("CrouchIdle")
	SPEED = 3.0
	standing.disabled = true
	crouching.disabled = false

	
func Exit():
	standing.disabled = false
	crouching.disabled = true
	
func Update(delta: float):
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
	
	if player.velocity != Vector3.ZERO:
		animation_player.play("CrouchWalk")
	else:
		animation_player.play("CrouchIdle")
	
func Physics_Update(delta: float):
	if Input.is_action_just_pressed("crouch") and not crouch_check.is_colliding():
		Transitioned.emit(self, "Idle")
		
	if dir != Vector3.ZERO:
		player.velocity.x = dir.x * SPEED
		player.velocity.z = dir.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		
	if not player.is_on_floor():
			Transitioned.emit(self, "Falling")
