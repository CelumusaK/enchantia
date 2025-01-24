extends Area3D

@export var enemy: CharacterBody3D


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hurt"):
		var damage = enemy.calculate_damage()
		body. hurt(damage, enemy, body)
