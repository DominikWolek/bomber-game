extends CPUParticles2D

func _process(delta):
	#we throw the particle pbject out
	#after it's done emmiting
	if(!is_emitting()):
		queue_free()