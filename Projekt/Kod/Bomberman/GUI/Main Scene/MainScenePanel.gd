extends Panel

#Method name: _on_StartButton_pressed();
#Arguments: N/A
#Function _ready check if music is already playing, if not it start it.

func _ready():
	if((Sounds.get_node("MainMenu").is_playing() == false ) 
		and ConfigurationNode.get_value("Sounds", "soundSwitch")) :
		Sounds.get_node("MainMenu").play()

