extends CharacterBody3D
class_name Ememy

@onready var health_bar: ProgressBar = $SubViewport/HealthBar

@export var stats: Resource

func _ready() -> void:
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _process(_delta: float) -> void:
	pass

func hurt(damage: int):
	stats.take_damage(damage)
	
func update_health():
	health_bar.value = stats.health
