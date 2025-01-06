extends CharacterBody3D

@onready var hitbox: Area3D = $YBot/Armature/Hitbox


@export var player : CharacterBody3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _process(_delta: float) -> void:
	pass

func enemy_attack():
	var body = hitbox.get_overlapping_bodies()
	if body == null:
		return
	else:
		if body:
			player.player_hurt()
func enemy_hurt():
	print("Enemy Hurt")
