extends Area3D
@onready var right: Area3D = $"."

@export var player: CharacterBody3D

func _on_body_entered(body: Node3D) -> void:
	var _body = right.get_overlapping_bodies()
	
	for bodies in _body:
		if bodies.has_method("hurt"):
			bodies.hurt()
