extends Node
class_name NPCAnimationHandler

@onready var enemy_anim: AnimationTree = $"../EnemyAnim"


func update_animation(state: String):
	match state:
		"Idle":
			enemy_anim.set("parameters/Locomotion/transition_request", "Idle")
			
		"Walking":
			enemy_anim.set("parameters/Locomotion/transition_request", "Walk")
	
		"Falling":
			enemy_anim.set("parameters/Locomotion/transition_request", "Fall")
	
		"Running":
			enemy_anim.set("parameters/Locomotion/transition_request", "Run")
		
		"Sprint":
			enemy_anim.set("parameters/Locomotion/transition_request", "Sprint")
