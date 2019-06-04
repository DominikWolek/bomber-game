extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.has_method("speed_up")):
			body.speed_up()
			queue_free()
			return