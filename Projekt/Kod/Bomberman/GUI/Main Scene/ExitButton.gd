extends Button

func _ready():
	pass 

#Method name: _on_ExitButton_pressed();
#Arguments: N/A
#Function play exit game sound and  exit game.

func _on_ExitButton_pressed():
	Sounds.get_node("MenuButton").play()
	get_tree().quit();