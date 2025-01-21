extends State
class_name PlayerIdle

func Enter():
	player.velocity = Vector3.ZERO
	
func Exit():
	pass
	
func Update(delta: float):
	if next_state != "" and next_state != "Idle":
		Transitioned.emit(self, next_state)
	
func Physics_Update(delta: float):
	player.velocity = Vector3.ZERO
	
	
