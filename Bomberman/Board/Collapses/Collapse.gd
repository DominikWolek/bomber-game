extends Area2D
var time
var colour 
var change_time = 4
var change = true

func _ready():
	time = Timer.new()
	time.start(4)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	colour = get_node("Line2D2").default_color
	




func _on_Timer_timeout():
	for i in get_overlapping_bodies():
		if(i.name != "Board"):
			i.queue_free()
	
	for i in get_child(1).points:
		get_parent().set_cellv(get_parent().world_to_map(i), 0)
	get_parent().update_bitmask_region()
	queue_free()

	
func _process(delta):
	if(time.get_time_left()<change_time):
		change_time -= 0.23
		if(change == true):
			get_node("Line2D2").default_color = Color(0, 0, 0)
			change = false
		else:
			get_node("Line2D2").default_color = colour
			change = true