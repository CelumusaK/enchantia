extends Area3D
@export var enemy_stats: Resource 
@export var player: CharacterBody3D

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hurt"):
		body.hurt(enemy_stats.attack_power)
		body.update_health()
		player.is_kicked = true
		print(enemy_stats.attack_power)
