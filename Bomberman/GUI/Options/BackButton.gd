extends Button

func _ready():
	pass

func _on_BackButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Main Scene/MainMenuScene.tscn");
	if error == OK:
		pass
	else:
		print(error)