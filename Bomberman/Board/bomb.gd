extends RigidBody2D
var time
var color = get_modulate()
var change_time
var placedBy

func _ready():
	Sounds.get_node("BombSet").position = position
	Sounds.get_node("BombSet").play()
	
	time = Timer.new()
	time.start(3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	change_time = Timer.new()
	change_time.start(0.23)
	add_child(change_time)
	change_time.connect("timeout", self, "_on_change_time_timeout")
	
func _on_change_time_timeout():
	if(modulate == color):
		modulate = Color(1, 0, 0)
	else:
		modulate = color

func _on_Timer_timeout():
	get_parent().bumv(position, placedBy)
	queue_free()