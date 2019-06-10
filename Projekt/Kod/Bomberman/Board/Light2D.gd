extends Light2D

var time

func _ready():
	time = Timer.new()
	time.start(0.3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout():
	#after the light is gone, the object is also gone
	time.queue_free()
	queue_free()
	
func _process(delta):
	#in every frame, we multiply the energy times 1.1. It
	#makes for a nice flash effect
	energy *= 1.1
