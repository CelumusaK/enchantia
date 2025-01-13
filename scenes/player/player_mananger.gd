extends Node

@export var is_equip: bool = false

var player

func use_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.use(player)
	
func eqip_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.equip(player)
	is_equip = true
	
func get_global_position() -> Vector3:
	return player.global_position
