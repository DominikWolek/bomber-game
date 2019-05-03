extends Button



var code

func _on_UP_pressed():
	set_process_input(true)
	add_user_signal("AnyKeyClicked")
	yield(self,"AnyKeyClicked")
	get_parent().Controls[1] = code

	
	
func _input(event):
	if event is InputEventKey:
			 code = event.get_scancode()
			 emit_signal("AnyKeyClicked")
			 set_process_input(false)
			
			 