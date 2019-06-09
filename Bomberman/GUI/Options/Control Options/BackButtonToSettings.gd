extends Button

func _ready():
	pass # Replace with function body.


#zmiana sceny na ustawienia
func _on_BackButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Options/SettingsScene.tscn");
	if error == OK:
		pass
	else:
		print(error);


