extends Panel

var gameInfo = {}
var colours = []

# Called when the node enters the scene tree for the first time.
func _ready():
	gameInfo = get_node("/root/ConfigurationNode").gameInfo
	colours = ["Basic","Red","Blue","Green","Yellow","Grey","Pink"]
	_PlayerChanged("P1")
	_PlayerChanged("P2")
	_PlayerChanged("P3")
	_PlayerChanged("P4")

func _PlayerChanged(player):
	var play = get_node(player+"Settings")
	play.get_node("Name").text = gameInfo[player]["name"]
	play.get_node("Color").text = colours[gameInfo[player]["colour"]]
	play.get_node("isBot").pressed = gameInfo[player]["is_bot"]
	var z = play.get_node("isPlaying") 
	if z :
		z.pressed = gameInfo[player]["is_playing"]

func setBot(player,info):
	get_node("/root/ConfigurationNode")._change_and_commit(player,"is_bot",info)

func setPlaying(player,info):
	get_node("/root/ConfigurationNode")._change_and_commit(player,"is_playing",info)

func setNextColor(player):
	changePlayerColor(player,gameInfo[player]["colour"])

func changePlayerName(player,name):
	get_node("/root/ConfigurationNode")._change_and_commit(player,"name", name)
	_PlayerChanged(player)

func changePlayerColor(player,colour):
	get_node("/root/ConfigurationNode")._change_and_commit(player,"colour",(colour+1) % 7)
	_PlayerChanged(player)

func _process(delta):
	pass