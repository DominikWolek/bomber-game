extends Button

func _ready():
	pass 

func _on_SettingsButton_pressed():
	var error = get_tree().change_scene( "res://GUI/SettingsScene.tscn");
	if error == OK:
		pass
	else:
		print(error);
