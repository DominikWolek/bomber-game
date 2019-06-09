extends Button

func _ready():
	pass 


func _on_ExitButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_tree().quit();