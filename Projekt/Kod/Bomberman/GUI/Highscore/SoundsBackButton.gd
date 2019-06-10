extends Button



func _on_SoundsBackButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_tree().change_scene( "res://GUI/Main Scene/MainMenuScene.tscn")
