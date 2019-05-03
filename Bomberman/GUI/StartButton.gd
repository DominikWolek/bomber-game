extends Button

func _ready():
	pass 


func _on_StartButton_pressed():
	var error = get_tree().change_scene( "res://GUI/FirstStartScene.tscn");
	if error == OK:
		pass
	else:
		print(error);
