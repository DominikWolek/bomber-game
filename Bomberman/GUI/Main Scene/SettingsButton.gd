extends Button

func _ready():
	pass 

func _on_SettingsButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Options/SettingsScene.tscn");
	if error == OK:
		pass
	else:
		print(error);
