extends Button

var player_id
var code

func _ready():
	player_id = get_parent().player_id
	
	
#funkcja blokuje sygnal i obsluguje zmiane przycisku
func _on_DOWN_pressed():
	#sprawdzenie czy inny przycisk nie jest obslugiwany
	if ( get_parent().get_parent().getSignal() == true ):
		return
	else:
		get_parent().get_parent().setSignalOn()
	#proces obslugi wejscia	
	set_process_input(true)
	add_user_signal("AnyKeyClicked")
	yield(self,"AnyKeyClicked")
	get_node("/root/ConfigurationNode").change_and_commit(player_id,"down",code)
	get_node("/root/ConfigurationNode").update_move_set(player_id)
	get_parent().get_parent().setSignalOff()
	
#funkcja nadpisujaca standardowa obsluge wejscia	
func _input(event):
	if event is InputEventKey:
			 code = event.get_scancode()
			 emit_signal("AnyKeyClicked")
			 set_process_input(false)
			
			 
