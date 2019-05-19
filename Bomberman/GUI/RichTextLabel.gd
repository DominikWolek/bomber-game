extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func reload():
	clear()
	var scores = Highscore.GetList()
	for i in scores:
		add_text(i.nickname + " - " + str(i.score) )
		newline()
# Called when the node enters the scene tree for the first time.
func _ready():
	reload()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
