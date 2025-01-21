extends State
class_name PlayerFalling

var _delta: float

func Enter():
	player.velocity += player.get_gravity() * _delta
	
func Exit():
	pass
	
func Update(delta: float):
	_delta = delta
	if player.velocity.y == 0:
		Transitioned.emit(self, "Idle")
	
func Physics_Update(delta: float):
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
		
		
