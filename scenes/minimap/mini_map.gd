extends Panel

@export var target: CharacterBody3D
@export var camera_dis: float = 20.0

@onready var camera: Camera3D = $SubViewportContainer/SubViewport/Camera

func _process(delta: float) -> void:
	if target:
		camera.position = Vector3(target.position.x, camera_dis, target.position.z)
