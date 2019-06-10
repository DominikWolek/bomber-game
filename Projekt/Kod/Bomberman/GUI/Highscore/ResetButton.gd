extends Button


func _ready():
	pass # Replace with function body.


#Method name: _on_ResetButton_pressed();
#Arguments: N/A
#Function reset highscore on button press.
func _on_ResetButton_pressed():
	Sounds.get_node("MenuButton").play()
	Highscore.reset()
	get_parent().get_node("Scores").reload()
