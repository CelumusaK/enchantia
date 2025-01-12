extends CharacterBody3D
class_name Ememy

@export var stats: Resource
@onready var health_bar: ProgressBar = $SubViewport/HealthBar

func _ready() -> void:
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health

func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
func _process(_delta: float) -> void:
	pass

func hurt(damage: int):
	stats.take_damage(damage)
	
func update_health():
	health_bar.value = stats.health
