extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.has_method("add_bomb")):
			body.add_bomb()
			queue_free()
			return
