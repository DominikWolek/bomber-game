extends Button

func _ready():
	pass 


func _on_SoundButton_pressed():
	var error = get_tree().change_scene( "res://GUI/SoundSettings.tscn");
	if error == OK:
		pass
	else:
		print(error);
