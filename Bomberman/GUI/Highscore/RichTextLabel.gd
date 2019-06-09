extends RichTextLabel

#Method name: reload();
#Arguments: N/A
#Function update highscore list
func reload():
	text = ""
	var scores = Highscore.get_list()
	for i in scores:
		add_text(i.nickname + " - " + str(i.score) )
		newline()

func _ready():
	reload()

