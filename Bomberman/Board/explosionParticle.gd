extends CPUParticles2D

func _process(delta):
	if(!is_emitting()):
		queue_free()