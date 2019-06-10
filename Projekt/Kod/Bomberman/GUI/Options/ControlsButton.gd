extends Button

func _ready():
	pass
 
"""
Method name: _on_ControlsButton_pressed();
Arguments: N/A
Function change scene to scene with controls settings on button click. It also gives simple error handling
for engine exceptions
"""
func _on_ControlsButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Options/Control Options/ControlsSettings.tscn");
	if error == OK:
		pass
	else:
		print(error);


