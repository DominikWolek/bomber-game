extends Button

func _on_PrevButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_parent().prev_map()
