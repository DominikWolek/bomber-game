extends Panel

var gameInfo = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	gameInfo.map = 0
	gameInfo.P1 = {Name = "P1" , isBot=false}
	gameInfo.P2 = {Name = "P2" , isBot=false}
	gameInfo.P3 = {Name = "P3" , isBot=false}
	gameInfo.P4 = {Name = "P4" , isBot=false}

func _process(delta):
	var lab = get_node("mapLabel")
	lab.text = str(gameInfo.map + 1)