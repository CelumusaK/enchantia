extends CharacterBody3D

@onready var twist_pivot: Node3D = $TwistPivot
@onready var pitch_pivot: Node3D = $TwistPivot/PitchPivot
@onready var camera_3d: Camera3D = $TwistPivot/PitchPivot/SpringArm3D/Camera3D
@onready var skin: Node3D = $Armature
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var twistinput = 0.0
var pitchinput = 0.0

var sensitivity = 0.005

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var main_sm: LimboHSM

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	initiate_state_machine()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var camera = camera_3d.global_transform.basis
	
	var input_dir := Input.get_vector("left", "right", "forward", "backwards")
	var direction = (camera.x * input_dir.x + camera.z * input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	var camera_yaw = camera_3d.global_transform.basis.get_euler().y
	skin.rotation.y = camera_yaw + deg_to_rad(180)

	twist_pivot.rotate_y(twistinput)
	pitch_pivot.rotate_x(pitchinput)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-40), deg_to_rad(20))
	
	twistinput = 0.0
	pitchinput = 0.0

	move_and_slide()
	
func initiate_state_machine():
	main_sm = LimboHSM.new()
	add_child(main_sm)
	
	var idle_state = LimboState.new().named("idle").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state = LimboState.new().named("walk").call_on_enter(walk_start).call_on_update(walk_update)
	var jump_state = LimboState.new().named("jump").call_on_enter(jump_start).call_on_update(jump_update)
	
	main_sm.add_child(idle_state)
	main_sm.add_child(walk_state)
	main_sm.add_child(jump_state)
	
	main_sm.initial_state = idle_state
	
	main_sm.initialize(self)
	main_sm.set_active(true)
	

func idle_start():
	animation_player.play("Idle")
	
func idle_update():
	pass
	
func walk_start():
	pass
	
func walk_update():
	pass
	
func jump_start():
	pass
	
func jump_update():
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		twistinput -= event.relative.x * sensitivity
		pitchinput -= event.relative.y * sensitivity
