extends Button


func _on_NextButton_pressed():
	if(get_parent().check_all_names()):
		get_parent().get_node("ErrorMessage").bbcode_text = ""
		var error = get_tree().change_scene( "res://Board/Board.tscn");
		if error == OK:
			pass
		else:
			print(error);
	else:
		var message = "[center]Wrong nicknames"
		get_parent().get_node("ErrorMessage").bbcode_text = message
