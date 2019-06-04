extends Button

var player_id
var code

func _ready():
	player_id = get_parent().player_id
	
func _on_DOWN_pressed():
	set_process_input(true)
	add_user_signal("AnyKeyClicked")
	yield(self,"AnyKeyClicked")
	get_node("/root/ConfigurationNode").change_and_commit(player_id,"down",code)
	get_node("/root/ConfigurationNode").update_move_set(player_id)
	
	
func _input(event):
	if event is InputEventKey:
			 code = event.get_scancode()
			 emit_signal("AnyKeyClicked")
			 set_process_input(false)
			
			 