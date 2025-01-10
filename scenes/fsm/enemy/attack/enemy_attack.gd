extends State
class_name EnemyAttack

@export var player : CharacterBody3D
@onready var skin: Node3D = $"../../YBot/Armature"
@onready var animation_player: AnimationPlayer = $"../../YBot/AnimationPlayer"

@export var enemy: CharacterBody3D

var timer: float = 0.0
var duration: float = 2.25
var rotation_speed : float = 10.0

func Enter():
	animation_player.play("RoungHouseKick")
	
func Exit():
	pass
	
func Update(delta: float):
	timer += delta
	enemy.look_at(player.global_position)
func Physics_Update(delta: float):
	if timer >= duration:
		Transitioned.emit(self, "Follow")
		timer = 0.0
