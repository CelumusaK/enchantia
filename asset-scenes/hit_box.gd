extends Area3D

@export var enemy: CharacterBody3D


func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body.target.has_method("hurt"):
		var damage = enemy.calculate_damage()
		body.target. hurt(damage, enemy, body)
