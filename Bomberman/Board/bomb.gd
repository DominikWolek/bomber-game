extends RigidBody2D
var time
var colour = get_modulate()
var change_time
var placedBy

func _ready():
	time = Timer.new()
	time.start(3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	change_time = Timer.new()
	change_time.start(0.23)
	add_child(change_time)
	change_time.connect("timeout", self, "_on_change_time_timeout")
	
func _on_change_time_timeout():
	if(modulate == colour):
		modulate = Color(1, 0, 0)
	else:
		modulate = colour

func _on_Timer_timeout():
	get_parent().bumv(position, placedBy)
	queue_free()