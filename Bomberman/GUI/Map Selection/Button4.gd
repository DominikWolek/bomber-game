extends Button

#Method name: _on_NextButton_pressed();
#Arguments: N/A

#Function change map to the next one
func _on_NextButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_parent().next_map()