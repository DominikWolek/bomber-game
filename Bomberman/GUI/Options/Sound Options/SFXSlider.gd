extends HSlider


func _ready():
	if (ConfigurationNode.get_value("Sounds", "sfx") != null):
		value = ConfigurationNode.get_value("Sounds", "sfx")
		Sounds.get_tree().call_group("SFX", "set_volume_db", value)

"""
Method name: _on_SFXSlider_value_changed
Arguments: value
Function change SFX volume
"""
func _on_SFXSlider_value_changed(value):
	Sounds.get_tree().call_group("SFX", "set_volume_db", value)
	if(value == -10):
		Sounds.get_tree().call_group("SFX", "set_stream_paused", true)
		get_parent().get_node("SFXSwitch").pressed = false
	else:
		Sounds.get_tree().call_group("SFX", "set_stream_paused", false)
		get_parent().get_node("SFXSwitch").pressed = true		
	ConfigurationNode.change_and_commit("Sounds", "sfx", value)
