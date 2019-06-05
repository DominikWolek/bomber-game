extends Button


func _ready():
	pass 


func _on_HighscoreButton_pressed():
	var error = get_tree().change_scene( "res://GUI/Highscore/HighscoreScene.tscn");
	if error == OK:
		pass
	else:
		print(error);