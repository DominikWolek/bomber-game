extends Button

var playerID
var code

func _ready():
	playerID = get_parent().playerID
	
	
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
	get_node("/root/ConfigurationNode")._change_and_commit(playerID,"down",code)
	get_node("/root/ConfigurationNode").UpdateMoveSet(playerID)
	get_parent().get_parent().setSignalOff()
	
#funkcja nadpisujaca standardowa obsluge wejscia	
func _input(event):
	if event is InputEventKey:
			 code = event.get_scancode()
			 emit_signal("AnyKeyClicked")
			 set_process_input(false)
			
			 