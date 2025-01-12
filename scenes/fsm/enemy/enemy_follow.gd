extends State
class_name EnemyFollow

@export var enemy : CharacterBody3D
@export var move_speed:= 3.0
@onready var skin: Node3D = $"../../YBot/Armature"
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"

@export var player : CharacterBody3D
var dir := Vector3.ZERO
var last_move_dir := Vector3.ZERO
var rotation_speed := 10.0

func Enter():
	animation_player.play("Walking")
	
func Exit():
	pass
	
func Update(delta: float):
	if dir.length() > 0.2:
		last_move_dir = dir
	var target_angle := Vector3.BACK.signed_angle_to(last_move_dir, Vector3.UP)
	
	skin.global_rotation.y = lerp(skin.global_rotation.y, target_angle, rotation_speed * delta)
	
func Physics_Update(delta: float):
	if player.stats.health == 0:
		Transitioned.emit(self, "Wander")
	
	var direction = player.global_position - enemy.global_position
	dir = direction

	if direction.length() < 25 and player.stats.health != 0:
		enemy.velocity = direction.normalized() * move_speed
		if direction.length() < 1.5 and player.stats.health != 0:
			enemy.velocity = Vector3.ZERO
			Transitioned.emit(self, "Attack")
	else:
		enemy.velocity = Vector3.ZERO
		
	if direction.length() > 25:
		Transitioned.emit(self, "Wander")
