extends State
class_name PlayerSprint

var SPEED: float = 6.0

func Enter():
	pass
	
func Exit():
	pass
	
func Update(delta: float):
	player_direction.handle_movement_and_turning(delta)
	if next_state != "" and next_state != "Sprint":
		Transitioned.emit(self, next_state)
	
func Physics_Update(delta: float):
		player.velocity = player_direction.handle_movement_and_turning(delta) * SPEED
		player.move_and_slide()
