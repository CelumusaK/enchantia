extends Node
class_name PlayerDirection

@onready var camera: Camera3D = $"../TwistPivot/PitchPivot/SpringArm3D/Camera3D"
@onready var skin: Node3D = $"../YBot/Armature"

var rotation_speed: float = 12.0


var last_move_dir: Vector3 = Vector3.ZERO
var input_package: InputPackage
@export var input_manager: InputManager

# Centralized function to handle movement direction and turning
func handle_movement_and_turning(delta: float) -> Vector3:
	
	input_package = input_manager.process_input(delta)
	# Get input direction
	var input_dir = input_package.input_direction  # From InputPackage

	# Get the camera's basis and calculate the movement direction
	var camera_basis = camera.global_basis
	var direction = (camera_basis.x * input_dir.x + camera_basis.z * input_dir.y)
	direction.y = 0.0
	direction = direction.normalized()

	# Update the last move direction
	last_move_dir = direction
	
	# Handle the turning logic (rotation)
	if last_move_dir != Vector3.ZERO:
		var target_rotation = atan2(last_move_dir.x, last_move_dir.z)  # Z-forward axis
		var current_rotation = skin.rotation.y
		skin.rotation.y = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)

	return last_move_dir
