extends RigidBody2D
var time
var color = get_modulate()
var change_time
var placed_by

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
	#the bomb goes red and normal
	if(modulate == color):
		modulate = Color(1, 0, 0)
	else:
		modulate = color

func _on_Timer_timeout():
	#on timer timeout, the bomb calls board and explode
	get_parent().explodev(position, placed_by)
	queue_free()
