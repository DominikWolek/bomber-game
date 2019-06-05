extends CheckButton


func _ready():
	if (ConfigurationNode.get_value("Sounds", "sfxSwitch") != null):
		pressed = ConfigurationNode.get_value("Sounds", "sfxSwitch")
		Sounds.get_tree().call_group("SFX", "set_stream_paused", !pressed)



func _on_SFXSwitch_toggled(button_pressed):
	Sounds.get_tree().call_group("SFX", "set_stream_paused", !button_pressed)		
	if(button_pressed == false):
		get_parent().get_node("SFXSlider").value = -10
	else:
		get_parent().get_node("SFXSlider").value =-2.5		
	ConfigurationNode.change_and_commit("Sounds", "sfxSwitch", button_pressed)
