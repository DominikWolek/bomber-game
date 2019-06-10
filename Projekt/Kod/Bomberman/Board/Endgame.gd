extends Panel

var time

func add(text):
	#that just add text to the endgame screen
	get_node("canvcas/text").add_text(text)


func _ready():
	#it starts the timer. when the timer ends, function
	#on_timer_timeout is called. Music playes, scene changes
	time = Timer.new()
	time.start(6)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")
	
func _on_Timer_timeout():
	Sounds.get_node("GameEnds").play()	
	Sounds.get_node("La Calahorra").stop()
	get_tree().change_scene( "res://GUI/Main Scene/MainMenuScene.tscn");
