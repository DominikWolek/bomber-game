extends Area2D
"""
Method name: _physic_process
Arguments: delta - time elapsed since previous execution of _physic_process
The purpose of the function is to check if any player has entered the 
powerup's field. If so, the powerup disappears and the corresponding player 
gains a bonus (in this case, higher speed of the character)
"""
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.has_method("speed_up")):
			body.speed_up()
			queue_free()
			return