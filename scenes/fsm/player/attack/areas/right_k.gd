extends Area3D

@export var player_stats: Resource

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hurt"):
		body.hurt(player_stats.attack_power)
		body.update_health()
