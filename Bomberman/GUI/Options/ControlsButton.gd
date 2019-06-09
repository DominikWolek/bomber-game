extends Button

func _ready():
	pass 


func _on_ControlsButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Options/Control Options/ControlsSettings.tscn");
	if error == OK:
		pass
	else:
		print(error);


