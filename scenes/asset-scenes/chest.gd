extends RigidBody3D

signal  toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData = preload("res://main_inventory/box_inv.tres")

func player_interact() -> void:
	toggle_inventory.emit(self)
