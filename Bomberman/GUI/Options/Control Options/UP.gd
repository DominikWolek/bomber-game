extends Button

var player_id

var code

func _ready():
	player_id = get_parent().player_id


"""
Method name: _on_UP_pressed();
Arguments: N/A
Function change the key that is corresponding to the parent node's ui_up action
"""
func _on_UP_pressed():
	
	#Check if there is no concurrent signal handling
	if ( get_parent().get_parent().getSignal() == true ):
		return
	else:
	#Get the exclussiveness for input handling
		get_parent().get_parent().setSignalOn()
		
	
	set_process_input(true)
	add_user_signal("AnyKeyClicked")
	
	#Waiting for _input() to trigger signal
	yield(self,"AnyKeyClicked")
	get_parent().get_parent().setSignalOff()
	
#	#Change the action in ConfigurationNode
	get_node("/root/ConfigurationNode").change_and_commit(player_id,"up",code)
	get_node("/root/ConfigurationNode").update_move_set(player_id)
	
"""
Method name: _input();
Arguments: event
Function get event from system, and trigger special signal, that is handled by button.
"""
func _input(event):
	if event is InputEventKey:
		code = event.get_scancode()
		emit_signal("AnyKeyClicked")
		set_process_input(false)
