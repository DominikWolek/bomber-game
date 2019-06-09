extends Button


func _ready():
	pass # Replace with function body.


#Method name: _on_NextButton_pressed();
#Arguments: N/A
#Function change scene back to main menu.
func _on_NextButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Character Selection/FirstStartScene.tscn");
	if error == OK:
		pass
	else:
		print(error);
