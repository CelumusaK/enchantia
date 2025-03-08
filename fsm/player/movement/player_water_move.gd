extends State
class_name WaterMove

var swim_speed: float = 1.5

func Enter():
	pass
	
func Exit():
	pass
	
func Update(delta: float):
	if next_state != "" and next_state != "WaterMove" and next_state != "SwinUp"  and next_state != "SwimDown":
		Transitioned.emit(self, next_state)
	
func Physics_Update(delta: float):
	if Input.is_action_just_pressed("swimup"):
		player.velocity.y += 1
	if Input.is_action_just_pressed("swimdown"):
		player.velocity.y -= 1
	player.velocity = player_direction.handle_movement_and_turning(delta) * swim_speed
	player.move_and_slide()
