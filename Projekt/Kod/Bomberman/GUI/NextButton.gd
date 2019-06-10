extends Button

func _ready():
	pass # Replace with function body.

#Method name: _on_NextButton_pressed();
#Arguments: N/A
#Function change scene to the game scene.
func _on_NextButton_pressed():
	var error = get_tree().change_scene( "res://Board//Board.tscn");
	if error == OK:
		pass
	else:
		print(error);
