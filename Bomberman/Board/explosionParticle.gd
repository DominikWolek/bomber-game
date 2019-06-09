extends Particles2D

func _process(delta):
	#we throw the particle object out
	#after it's done emmiting
	if(!is_emitting()):
		queue_free()