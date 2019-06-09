extends Button


#Method name: _on_PrevButton_pressed();
#Arguments: N/A

#Function change map to the prev one
func _on_PrevButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_parent().prev_map()
