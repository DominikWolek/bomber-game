extends Light2D

var time

func _ready():
	time = Timer.new()
	time.start(0.3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout():
	time.queue_free()
	queue_free()
	
func _process(delta):
	energy *= 1.1
