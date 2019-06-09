extends Button

func _ready():
	pass # Replace with function body.


#Method name: _on_BackButton_pressed();
#Arguments: N/A
#Function change scene to scene with settings on button click. It also gives simple error handling
#for engine exceptions
func _on_BackButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Options/SettingsScene.tscn");
	if error == OK:
		pass
	else:
		print(error);


