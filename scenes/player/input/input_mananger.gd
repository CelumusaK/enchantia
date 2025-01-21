extends Node
class_name InputManager

@export var player: CharacterBody3D

func process_input(delta: float) -> InputPackage:
	var new_input = InputPackage.new()
	
	if Input.is_action_just_pressed("jump"):
		if new_input.actions.has("sprint"):
			new_input.actions.append("sprint_jump")
		else:
			new_input.actions.append("jump")
			
	if Input.is_action_just_pressed("primary attack"):
		new_input.actions.append("primary attack")
		
	new_input.input_direction = Input.get_vector("left", "right", "forward", "backwards")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("run")
		if Input.is_action_pressed("sprint"):
			new_input.actions.append("sprint")
		
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
		
	return new_input
	

func get_next_state(delta: float) -> String:
	var input_package = process_input(delta)
	# Determine the next state based on input package
	if player.velocity.y != 0 or !player.is_on_floor():
		return "Falling"
		
	if input_package.actions.has("jump"):
		return "Jump"
		
	if input_package.actions.has("primary attack"):
		return "Attack"
		
	if input_package.input_direction != Vector2.ZERO:
		if input_package.actions.has("run"):
			if input_package.actions.has("sprint"):
				return "Sprint"
			return "Running"
		
	if input_package.actions.has("idle"):
		return "Idle"

	if input_package.actions.has("crouch"):
		return "Crouch"

	

	return ""  # No state change
