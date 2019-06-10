extends Button

func _ready():
	pass

#Method name: _on_NextButton_pressed();
#Arguments: N/A
#Function change scene back to main menu.
func _on_BackButton_pressed():
	get_parent().get_node("Scores").reload()
	var error = get_tree().change_scene( "res://GUI/MainMenuScene.tscn");
	if error == OK:
		pass
	else:
		print(error)