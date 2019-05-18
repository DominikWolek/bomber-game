extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Sounds.get_node("MainMenu").is_playing() == false):
		Sounds.get_node("MainMenu").play()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
