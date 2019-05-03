extends Button

func _ready():
	pass 


func _on_SaveButton_pressed():
	var P1 = get_node("../HBoxContainer/P1Container").Controls
	var P2 = get_node("../HBoxContainer/P2Container").Controls
	var P3 = get_node("../HBoxContainer/P3Container").Controls
	var P4 = get_node("../HBoxContainer/P4Container").Controls
	var Plist = [P1,P2,P3,P4]
	var conf = get_node("/root/ConfigurationNode")
	conf.setNewMoveSet(Plist)
	
	var error = get_tree().change_scene( "res://GUI/SettingsScene.tscn");
	if error == OK:
		pass
	else:
		print(error);


