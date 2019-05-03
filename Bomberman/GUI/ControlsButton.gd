extends Button

func _ready():
	pass 


func _on_ControlsButton_pressed():
	var error = get_tree().change_scene( "res://GUI/ControlsSettings.tscn");
	if error == OK:
		pass
	else:
		print(error);


