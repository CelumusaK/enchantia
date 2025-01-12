extends RigidBody3D

var dropped = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if dropped == true:
		apply_impulse(transform.basis.z, -transform.basis.z * 10)
		dropped = false
