extends Button

var playerID
var code

func _ready():
	playerID = get_parent().playerID
func _on_BOMB_pressed():
	set_process_input(true)
	add_user_signal("AnyKeyClicked")
	yield(self,"AnyKeyClicked")
	get_node("/root/ConfigurationNode")._change_and_commit(playerID,"bomb",code)
	get_node("/root/ConfigurationNode").UpdateMoveSet(playerID)
	
func _input(event):
	if event is InputEventKey:
			 code = event.get_scancode()
			 emit_signal("AnyKeyClicked")
			 set_process_input(false)
			
			 

