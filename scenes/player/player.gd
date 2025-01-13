extends CharacterBody3D
class_name Player

@onready var twist_pivot: Node3D = $TwistPivot
@onready var pitch_pivot: Node3D = $TwistPivot/PitchPivot
@onready var ray_cast_3d: RayCast3D = $TwistPivot/PitchPivot/RayCast3D
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var camera_3d: Camera3D = $TwistPivot/PitchPivot/SpringArm3D/Camera3D
@onready var skin: Node3D = $YBot/Armature
@onready var hotbar_inventory: PanelContainer = $UI/HotbarInventory
@onready var right: BoneAttachment3D = $YBot/Armature/GeneralSkeleton/BodyAttacks/Right

@export var stats: Resource

@export var inventory_data: InventoryData = preload("res://main_inventory/new_inv.tres")
@onready var inventory_interface: Control = $UI/InventoryInterface

var twistinput = 0.0
var pitchinput = 0.0
var sensitivity = 0.005

var is_kicked: bool = false
@export var equipped_item: Sword

func _ready() -> void:
	PlayerMananger.player = self
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#hotbar_inventory.set_inventory_data(inventory_data)
	inventory_interface.set_player_inventory_data(inventory_data)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	
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

	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		twistinput -= event.relative.x * sensitivity
		pitchinput -= event.relative.y * sensitivity
		
	if Input.is_action_just_pressed("inventory_action"):
		toggle_inventory_interface()
		
	if Input.is_action_just_pressed("interact"):
		interact()
	
	if Input.is_action_just_pressed("unequip_action"):
		unequip_item()

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

func player_attack(body: Node3D):
	if body.has_method("hurt"):
		body.hurt()
		
func hurt(damage: int):
	stats.take_damage(damage)
	
func update_health():
	health_bar.value = stats.health

func get_drop_position() -> Vector3:
	var direction = skin.global_transform.basis.z
	return skin.global_position + direction

func heal(heal_value: int) -> void:
	stats.heal(heal_value)
	update_health()

func unequip_item() -> void:
	if not equipped_item or not inventory_data:
		return  # Nothing to unequip
	
	# Get the item data from the equipped item
	var item_data = equipped_item.item_data_equip
	print(item_data)
	print("Up Here")
	
	# Create SlotData and add to inventory
	var slot_data = SlotData.new()
	slot_data.item_data = item_data  # Link the ItemDataEquippable directly
	slot_data.quantity = 1  # Assuming quantity is 1 for the equipped item
	
	# Add the item back to the inventory
	if inventory_data.pick_up_slot_data(slot_data):
		# Remove the 3D instance from the hand
		equipped_item.queue_free()
		equipped_item = null
	else:
		print("Inventory is full! Cannot unequip item.")
