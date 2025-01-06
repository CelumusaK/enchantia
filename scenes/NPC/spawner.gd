extends Node3D

var npc = preload("res://scenes/NPC/npc.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = npc.instantiate()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
