extends RigidBody2D
var time
var colour = get_modulate()
var change = true
var change_time = 1.15


func _ready():
	time = Timer.new()
	time.start(3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout():
	get_parent().bumv(position, "test", 2)
	queue_free()

func _process(delta):
	if(time.get_time_left()<change_time):
		change_time -= 0.23
		if(change == true):
			modulate = Color(1, 0, 0)
			change = false
		else:
			modulate = colour
			change = true