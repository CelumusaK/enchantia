extends CharacterBody3D

@onready var twist_pivot: Node3D = $TwistPivot
@onready var pitch_pivot: Node3D = $TwistPivot/PitchPivot
@onready var ray_cast_3d: RayCast3D = $TwistPivot/PitchPivot/RayCast3D

@export var inventory_data: InventoryData = preload("res://main_inventory/test_inv.tres")
@onready var inventory_interface: Control = $UI/InventoryInterface

var twistinput = 0.0
var pitchinput = 0.0
var sensitivity = 0.005


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory_interface.set_player_inventory_data(inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	twist_pivot.rotate_y(twistinput)
	pitch_pivot.rotate_x(pitchinput)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-40), deg_to_rad(30))
	
	twistinput = 0.0
	pitchinput = 0.0

	move_and_slide()
	
func move_input():
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		twistinput -= event.relative.x * sensitivity
		pitchinput -= event.relative.y * sensitivity
		
	if Input.is_action_just_pressed("inventory_action"):
		toggle_inventory_interface()
		
	if Input.is_action_just_pressed("interact"):
		interact()

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()

func interact() -> void:
	if ray_cast_3d.is_colliding():
		ray_cast_3d.get_collider().player_interact()

func player_attack(body: Node):
	if body.is_in_group("Enemies"):
		print("Enemy hurt")
		
func player_hurt():
	print("Player Hurt")
