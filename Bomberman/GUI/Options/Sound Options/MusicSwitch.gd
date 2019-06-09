extends CheckButton


func _ready():
	if (ConfigurationNode.get_value("Sounds", "soundSwitch") != null):
		pressed = ConfigurationNode.get_value("Sounds", "soundSwitch")
		Sounds.get_tree().call_group("Sounds", "set_stream_paused", !pressed)



#Arguments: button_pressed
#Function set music ON/OFF
func _on_MusicSwitch_toggled(button_pressed):
	if((Sounds.get_node("MainMenu").is_playing() == false ) 
		and button_pressed) :
		Sounds.get_node("MainMenu").play()
	Sounds.get_tree().call_group("Sounds", "set_stream_paused", !button_pressed)		
	if(button_pressed == false):
		get_parent().get_node("MusicSlider").value = -10
	else:
		get_parent().get_node("MusicSlider").value = -2.5		
	ConfigurationNode.change_and_commit("Sounds", "soundSwitch", button_pressed)