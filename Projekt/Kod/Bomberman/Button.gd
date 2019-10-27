extends Button

func _ready():
	pass 

"""
Method name: _on_BackButton_pressed();
Arguments: N/A
Function change scene to Main menu scene.
"""
func _on_BackButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Main Scene/MainMenuScene.tscn");
	if error == OK:
		pass
	else:
		print(error);