extends Area2D
var time
var change_time

func _ready():
	time = Timer.new()
	time.start(4)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	
	change_time = Timer.new()
	change_time.start(0.23)
	add_child(change_time)
	change_time.connect("timeout", self, "_on_TimerChange_timeout")
	




func _on_Timer_timeout():
	for i in get_overlapping_bodies():
		if(i.has_method("immediateDeath")):
			i.immediateDeath()
		elif(i.name != "Board"):
			i.queue_free()
	
	for i in get_overlapping_areas():
		i.queue_free()
	
	for i in get_child(1).points:
		get_parent().set_cellv(get_parent().world_to_map(i), 0)
	get_parent().update_bitmask_region()
	queue_free()


func _on_TimerChange_timeout():
	if(get_node("Line2D2").visible):
		get_node("Line2D2").visible = false
	else:
		get_node("Line2D2").visible = true
	
	
func _process(delta):
	pass