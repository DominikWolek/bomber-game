extends Button

func _on_NextButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_parent().next_map()