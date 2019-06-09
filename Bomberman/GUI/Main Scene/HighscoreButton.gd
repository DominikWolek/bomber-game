extends Button


func _ready():
	pass 


func _on_HighscoreButton_pressed():
	Sounds.get_node("MenuButton").play()
	var error = get_tree().change_scene( "res://GUI/Highscore/HighscoreScene.tscn");
	if error == OK:
		pass
	else:
		print(error);