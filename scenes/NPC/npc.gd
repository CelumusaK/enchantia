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
	var bodies = hitbox.get_overlapping_bodies()
	if !bodies:
		return

	for body in bodies:
		if body.has_method("hurt"):
			body.hurt()
			
func hurt():
	print("Enemy Hurt")
