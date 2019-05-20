extends Panel

var time

func add(text):
	get_node("canvcas/text").add_text(text)


	

func _ready():
	time = Timer.new()
	time.start(6)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	
func _on_Timer_timeout():
	get_tree().change_scene( "res://GUI/MainMenuScene.tscn");
