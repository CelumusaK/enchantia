extends State
class_name EnemyIdle

@export var enemy : CharacterBody3D
@export var move_speed:= 3.0
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"

@export var player : CharacterBody3D

var move_direction : Vector2
var wander_time: float

func randomize_wander():
	wander_time = randf_range(1, 3)
	
func Enter():
	animation_player.play("Idle")
	
func  Update(delta: float):
	pass

func  Physics_Update(delta: float):
	if player.stats.health == 0:
		Transitioned.emit(self, "Wander")
		
	#var direction = player.global_position - enemy.global_position
	#if direction.length() > 2 and player.stats.health != 0:
		#Transitioned.emit(self, "Follow")
