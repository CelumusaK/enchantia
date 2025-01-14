extends CharacterBody3D
class_name Player

@onready var twist_pivot: Node3D = $TwistPivot
@onready var pitch_pivot: Node3D = $TwistPivot/PitchPivot
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var camera_3d: Camera3D = $TwistPivot/PitchPivot/SpringArm3D/Camera3D
@onready var right: BoneAttachment3D = $YBot/Armature/GeneralSkeleton/BodyAttacks/Right

@export var stats: Resource


var twistinput = 0.0
var pitchinput = 0.0
var sensitivity = 0.005

var is_kicked: bool = false

func _ready() -> void:
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health

func _physics_process(delta: float) -> void:

	twist_pivot.rotate_y(twistinput)
	pitch_pivot.rotate_x(pitchinput)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-40), deg_to_rad(30))
	
	twistinput = 0.0
	pitchinput = 0.0

	move_and_slide()

	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		twistinput -= event.relative.x * sensitivity
		pitchinput -= event.relative.y * sensitivity
		

func player_attack(body: Node3D):
	if body.has_method("hurt"):
		body.hurt()
		
func hurt(damage: int):
	stats.take_damage(damage)
	
func update_health():
	health_bar.value = stats.health
