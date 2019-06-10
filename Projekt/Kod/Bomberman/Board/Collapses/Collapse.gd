extends Area2D
var time
var change_time

func _ready():
	#we add two timers. really, nothing worth commenting
	time = Timer.new()
	time.start(4)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	
	change_time = Timer.new()
	change_time.start(0.23)
	add_child(change_time)
	change_time.connect("timeout", self, "_on_TimerChange_timeout")
	



"""
Method name: _on_Timer_timeout
Arguments: none
That function is called when the time timer will 
send out a timeout signal
That function returns noting
"""
func _on_Timer_timeout():
	#so, basically
	#when the timer ends, every collapse object have an Area2D node
	#and everything on this area is thrown into /dev/null
	#also it changes the tiles to those indestructible ones
	for i in get_overlapping_bodies():
		if(i.has_method("immediate_death")):
			i.immediate_death()
		elif(i.name != "Board"):
			i.queue_free()
	
	for i in get_overlapping_areas():
		i.queue_free()
	
	for i in get_child(1).points:
		get_parent().set_cellv(get_parent().world_to_map(i), 0)
	#that is used in order to enable correct autotileing
	get_parent().update_bitmask_region()
	queue_free()

"""
Method name: _on_TimerChange_timeout
Arguments: none
That function is called when the change_time timer will 
send out a timeout signal. It is used do blink the red line
That function returns noting
"""

func _on_TimerChange_timeout():
	#here the red line makes BLING BLING
	if(get_node("Line2D2").visible):
		get_node("Line2D2").visible = false
	else:
		get_node("Line2D2").visible = true