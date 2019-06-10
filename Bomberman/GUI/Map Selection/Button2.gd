extends Button


func _ready():
	pass 

"""
Method name: _on_NextButton_pressed();
Arguments: N/A
Function change scene to character settings.
"""
func _on_NextButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Character Selection/FirstStartScene.tscn");
	if error == OK:
		pass
	else:
		print(error);
